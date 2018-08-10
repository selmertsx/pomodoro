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
  end

  private

  def client
    @client ||= OpenIDConnect::Client.new(
      issuer: issuer,
      identifier: identifier,
      authorization_endpoint: authorization_endpoint
    )
  end

  def config
    @concig ||= OpenIDConnect::Discovery::Provider::Config.discover! issuer
  end
end
