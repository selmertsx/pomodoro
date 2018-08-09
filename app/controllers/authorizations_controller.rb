class AuthorizationsController < ApplicationController

  def new
    redirect_to authz.authorization_uri(new_state, new_nonce)
  end

  def callback
  end

  def create
    unless authz.validate(params, stored_state, stored_nonce)
      render :nothing => true, :status => 400 and return
    end
    binding.pry
    session[:identifier] = get_identifier(authz.oidc.user_info)
    render status: :success
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
