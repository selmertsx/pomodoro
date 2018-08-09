class AuthorizationController < ApplicationController

  def new
    redirect_to authz.authorization_uri(new_state, new_nonce)
  end

  def create
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
end
