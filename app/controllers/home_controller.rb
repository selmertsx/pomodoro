
class HomeController < ApplicationController
  include ActionController::RequestForgeryProtection
  include ActionController::ImplicitRender
  include ActionView::Layouts

  layout "application"

  def index
  end
end
