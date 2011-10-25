require 'spec_helper'

describe AccountsController do

  def valid_attributes
    FactoryGirl.attributes_for :account
  end

  describe "when I am signed in" do
    before do
      sign_in_user
    end

    describe "GET show" do
      it "assigns the requested account as @account" do
        account = @user.account
        get :show, :id => account.id
        assigns(:account).should eq(account)
      end

      it "does not allow access to another account" do
        account = Account.create! valid_attributes
        expect {
          get :show, :id => account.id
        }.to raise_error CanCan::AccessDenied
      end
    end

    describe "GET edit" do
      it "assigns the requested account as @account" do
        account = @user.account
        get :edit, :id => account.id
        assigns(:account).should eq(account)
      end

      it "does not allow a user to edit another account" do
        account = Account.create! valid_attributes
        expect {
          get :edit, :id => account.id
        }.to raise_error CanCan::AccessDenied
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested account" do
          account = @user.account
          Account.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => account.id, :account => {'these' => 'params'}
        end

        it "assigns the requested account as @account" do
          account = @user.account
          put :update, :id => account.id, :account => valid_attributes
          assigns(:account).should eq(account)
        end

        it "redirects to the account" do
          account = @user.account
          put :update, :id => account.id, :account => valid_attributes
          response.should redirect_to(account)
        end
      end

      describe "with invalid params" do
        it "assigns the account as @account" do
          account = @user.account
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, :id => account.id, :account => {}
          assigns(:account).should eq(account)
        end

        it "re-renders the 'edit' template" do
          account = @user.account
          # Trigger the behavior that occurs when invalid params are submitted
          Account.any_instance.stub(:save).and_return(false)
          put :update, :id => account.id, :account => {}
          response.should render_template("edit")
        end
      end
    end
  end

end
