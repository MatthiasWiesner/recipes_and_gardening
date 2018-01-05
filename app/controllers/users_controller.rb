class UsersController < ApplicationController
  before_action :check_loggedin

  def index
    @users = User.all()
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      flash[:success] = 'Erfolgreich geändert'
    else
      flash[:danger] = 'Irgendwas ist schief gelaufen'
    end
    render 'edit'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
