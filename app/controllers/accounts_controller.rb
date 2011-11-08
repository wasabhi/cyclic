class AccountsController < ApplicationController
  load_and_authorize_resource
  
  # GET /accounts/1
  # GET /accounts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite
    @user = User.new
  end

  def send_invite
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = @user.password_confirmation = Devise.friendly_token
    @user.account = @account
    if @user.save
      redirect_to invite_account_url(@account), :notice => "#{@user.email} has been invited and should a confirmation email."
    else
      render :invite
    end
  end
    
end
