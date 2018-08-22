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

  # TODO: もう少し良い方法を考える
  def after_login
    user = User.find_by_sub(session[:openid_subject])

    if user
      redirect_to user and return
    else
      redirect_to new_user_url(user_params) and return
    end
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

  # TODO: Query Parameterに重要な情報を載せるのは良くないと思うので、おいおいSPAで完結させるようにする
  def user_params
    params.permit(:sub, :name, :preferred_username)
  end
end
