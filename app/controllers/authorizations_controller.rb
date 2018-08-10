class AuthorizationsController < ApplicationController

  def new
    redirect_to authz.authorization_uri(new_state, new_nonce)
  end

  def callback
  end

  def create
    id_token = authz.decode_id_token(params)
    id_token.verify!(issuer: authz.issuer, client_id: authz.identifier, nonce: stored_nonce)
    session[:identifier] = id_token.subject

    render json: id_token.raw_attributes, status: :success
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

  # TODO: validateの実装が終わった後に、session[:nonce].delete と置き換える
  def stored_nonce
    session[:nonce]
  end

  # TODO: validateの実装が終わった後に、session[:state].delete と置き換える
  def stored_state
    session[:state]
  end

  def get_identifier(user_info)
    return user_info.email
  end
end
