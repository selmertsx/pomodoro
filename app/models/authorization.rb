class Authorization
  include ActiveModel::Model

  attr_reader :issuer
  attr_reader :identifier
  attr_reader :jwks_uri
  attr_reader :authorization_endpoint
  attr_reader :redirect_uri

  def initialize()
    @issuer = Rails.application.credentials.oidc[:issuer]
    @identifier = Rails.application.credentials.oidc[:identifier]
    @jwks_uri = Rails.application.credentials.oidc[:jwks_uri]
    @authorization_endpoint = Rails.application.credentials.oidc[:authorization_endpoint]
    @redirect_uri = Rails.application.credentials.oidc[:redirect_uri]
  end

  def authorization_uri(state, nonce)
    client.redirect_uri ||= redirect_uri
    response_type = [:id_token, :token]
    client.authorization_uri(
      response_type: response_type.collect(&:to_s),
      state: state,
      nonce: nonce,
      scope: [:openid, :email, :profile].collect(&:to_s)
    )
  end

  def validate(fragment, state, nonce)

    #stateパラメータのチェック
    unless fragment['state'] == state then
      Rails.logger.warn 'invalid state parameter.'
      return false
    end

    begin
      _id_token = fragment['id_token']
      id_token = decode_id_token(_id_token)
      id_token.verify!(issuer: issuer, client_id: identifier, nonce: nonce)
      oidc.id_token = id_token.raw_attributes.with_indifferent_access

      if fragment['access_token']
        access_token = OpenIDConnect::AccessToken.new(fragment.merge({:client => client}))
        oidc.user_info = access_token.userinfo!
      end

      return true
    rescue => e
      Rails.logger.warn e.message
      return false
    end
  end

  private

  def client
    @client ||= OpenIDConnect::Client.new member_to_json
  end

  def member_to_json
    {
      issuer: issuer,
      identifier: identifier,
      jwks_uri: jwks_uri,
      authorization_endpoint: authorization_endpoint
    }
  end

  def decode_id_token(id_token)
    if jwks_uri
      header = JSON.parse(Base64.decode64(id_token.split('.').first)).with_indifferent_access
      kid = header[:kid]
      OpenIDConnect::ResponseObject::IdToken.decode id_token, public_keys_with_kid[kid]
    end
  end

  def jwks
    @jwks ||= JSON.parse(OpenIDConnect.http_client.get_content(jwks_uri)).with_indifferent_access
    JSON::JWK::Set.new @jwks[:keys]
  end

  def public_keys_with_kid
    @public_keys_with_kid ||= lambda { |hash|
      jwks.each do |jwk|
        hash.merge!({jwk[:kid] => JSON::JWK.decode(jwk)})
      end
      hash
    }.call({})
  end

  def parse_jwk_key(key)
    json = JSON.parse(key)
    jwk = json['keys'].first
    create_rsa_key(jwk['n'], jwk['e'])
  end

  def create_rsa_key(mod, exp)
    key = OpenSSL::PKey::RSA.new
    exponent = OpenSSL::BN.new decode(exp)
    modulus = OpenSSL::BN.new decode(mod)
    key.e = exponent
    key.n = modulus
    key
  end

  def parse_x509_key(key)
    OpenSSL::X509::Certificate.new(key).public_key
  end
end
