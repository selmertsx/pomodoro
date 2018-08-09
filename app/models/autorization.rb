class Authorization < ActiveModelBase
  attr_accessor
    :issuer,
    :identifier,
    :jwks_uri,
    :authorization_endpoint,
    :redirect_uri

  def initialize()
    issuer = Rails.application.credentials.oidc[:issuer]
    identifier = Rails.application.credentials.oidc[:identifier]
    jwks_uri = Rails.application.credentials.oidc[:jwks_uri]
    authorization_endpoint = Rails.application.credentials.oidc[:authorization_endpoint]
    redirect_uri = Rails.application.credentials.oidc[:redirect_uri]
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

  private

  def client
    @client ||= OpenIDConnect::Client.new member_to_json
  end

  def member_to_json
    [:issuer,
     :identifier,
     :jwks_uri,
     :authorization_endpoint
    ].inject({}) do |hash, key|
      hash.merge!(
          key => self.send(key)
      )
    end
  end
end


