class UsersController < ApplicationController
  load_and_authorize_resource

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to edit_user_url(@user.to_param), :notice => 'Profile Updated' }
      else
        format.html { render :edit }
      end
    end
  end

end
