class Authorization
  include ActiveModel::Model

  AUTHORIZATION_ENDPOINT = Rails.application.credentials.oidc[:authorization_endpoint].freeze
  ISSUER = Rails.application.credentials.oidc[:issuer].freeze
  IDENTIFIER = Rails.application.credentials.oidc[:identifier].freeze
  JWKS_URI = Rails.application.credentials.oidc[:jwks_uri].freeze
  REDIRECT_URI = Rails.application.credentials.oidc[:redirect_uri].freeze

  attr_reader :client

  def initialize
    @client = OpenIDConnect::Client.new(
      issuer: ISSUER,
      identifier: IDENTIFIER,
      authorization_endpoint: AUTHORIZATION_ENDPOINT,
      redirect_uri: REDIRECT_URI
    )
  end

  def authorization_uri(state, nonce)
    client.authorization_uri(
      response_type: 'id_token',
      state: state,
      nonce: nonce,
      scope: %w[openid email profile]
    )
  end

  def verify!(jwt_string, nonce)
    id_token = OpenIDConnect::ResponseObject::IdToken.decode(jwt_string, jwk_json)
    id_token.verify!(
      issuer: ISSUER,
      client_id: IDENTIFIER,
      nonce: nonce
    )
    id_token
  end

  private

  def jwk_json
    @jwks ||= JSON.parse(
      OpenIDConnect.http_client.get_content(JWKS_URI)
    ).with_indifferent_access

    JSON::JWK::Set.new @jwks[:keys]
  end
end
