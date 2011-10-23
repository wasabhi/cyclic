module UserAuthenticationHelper
  def sign_in_user
    @user = FactoryGirl.create :user
    sign_in @user
  end
end
