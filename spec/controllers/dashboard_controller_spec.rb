require 'spec_helper'

describe DashboardController do

  describe "when I am not signed in" do
    it "redirects to the login page" do
      get 'index'
      response.should redirect_to :new_user_session
    end
  end

end
