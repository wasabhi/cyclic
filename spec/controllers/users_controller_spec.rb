require 'spec_helper'

describe UsersController do

  describe "when I am not logged in" do
    it "returns http success" do
      get 'edit', :id => 1
      response.should redirect_to :new_user_session
    end

    it "returns http success" do
      put 'update', :id => 1
      response.should redirect_to :new_user_session
    end
  end

  describe "when I am logged in" do
    before do
      sign_in_user
    end

    it "returns http success" do
      get 'edit', :id => @user.to_param
      assigns(:user).should == @user
      response.should be_success
    end

    it "returns http success" do
      original_email = @user.email
      new_email = 'new@eg.com'
      
      expect {
        put :update, :id => @user.to_param, :user => { :email => new_email }
        response.should redirect_to edit_user_path(@user)
        @user.reload
      }.to change{ @user.email }.from(original_email).to(new_email)
    end

    it "should not allow one user to edit another user's profile" do
      user = FactoryGirl.create :user

      expect {
        get :edit, :id => user.to_param
      }.to raise_error CanCan::AccessDenied
    end
  end
end
