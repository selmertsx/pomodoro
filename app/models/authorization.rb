class Authorization
  include ActiveModel::Model

  attr_reader :issuer
  attr_reader :identifier
  attr_reader :redirect_uri

  def initialize
    @issuer = Rails.application.credentials.oidc[:issuer]
    @identifier = Rails.application.credentials.oidc[:identifier]
    @redirect_uri = Rails.application.credentials.oidc[:redirect_uri]
  end

  def authorization_uri(state, nonce)
    client.redirect_uri ||= redirect_uri
    client.authorization_uri(
      response_type: 'id_token',
      state: state,
      nonce: nonce,
      scope: %w[openid email profile]
    )
  end

  def decode_id_token(fragment)
    OpenIDConnect::ResponseObject::IdToken.decode fragment['id_token'], config.jwks
  end

  private

  def client
    @client ||= OpenIDConnect::Client.new(
      issuer: issuer,
      identifier: identifier,
      authorization_endpoint: config.authorization_endpoint
    )
  end

  def config
    @config ||= OpenIDConnect::Discovery::Provider::Config.discover! issuer
  end
end
