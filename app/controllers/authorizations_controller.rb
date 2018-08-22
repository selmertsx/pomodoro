class AuthorizationsController < ApplicationController

  # TODO:
  # セッションの取扱いをもっとセキュアにする
  # http://openid.net/specs/openid-connect-session-1_0.html
  def new
    redirect_to authz.authorization_uri(new_state, new_nonce)
  end

  def callback
  end

  def create
    if stored_state != fragment_params[:state]
      return render status: :unauthorized
    end

    id_token = authz.verify!(fragment_params[:id_token], stored_nonce)
    session[:openid_subject] = id_token.subject
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

  def fragment_params
    params.permit(:id_token, :state)
  end
end
