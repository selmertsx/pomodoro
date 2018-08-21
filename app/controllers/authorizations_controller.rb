class AuthorizationsController < ApplicationController

  def new
    redirect_to authz.authorization_uri(new_state, new_nonce)
  end

  def callback
  end

  def create
    id_token = authz.decode_id_token(id_token_fragment)
    id_token.verify!(
      issuer: Authorization::ISSUER,
      client_id: Authorization::IDENTIFIER,
      nonce: stored_nonce
    )

    session[:identifier] = id_token.subject
    render json: id_token.raw_attributes, status: :ok
  end

  private

  def authz
    @authz ||= Authorization.new
  end

  def new_state
    session[:state] = SecureRandom.hex(8)
  end

  def new_nonce
    session[:nonce] = SecureRandom.hex(16)
  end

  def stored_nonce
    session.delete(:nonce)
  end

  def stored_state
    session.delete(:state)
  end

  def id_token_fragment
    params.permit(:id_token)
  end
end
