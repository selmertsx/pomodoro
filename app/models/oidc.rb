class OIDC
  include ActiveModel::Model
  attr_accessor :access_token, :id_token, :user_info

  def initizalize()
    @access_token
  end
end
