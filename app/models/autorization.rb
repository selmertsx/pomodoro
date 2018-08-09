class Authorization < ActiveModelBase
  attr_accessor
    :issuer,
    :identifier,
    :jwks_uri,
    :authorization_endpoint,
    :redirect_uri,


  def initialize()
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
end


