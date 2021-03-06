class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :only_see_own_page, only: [:show]
  # before_action :only_create_user_when_none_signed_in, only: [:new, :create]
  before_action :give_users_right_to_admin, only: [:index]
  #before_action :check_before_delete, only: [:destroy]
  # GET /users
  def index
    @users = User.all
  end
  def admin
    @users = User.all
  end
  # GET /users/1
  def show
  end
  # GET /users/new
  def new
    @user = User.new
  end
  # GET /users/1/edit
  def edit
  end
  # POST /users
  def create
    #unless current_user
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to admin_users_url, notice: 'User was successfully created.'
      else
        render :new
      end
    #end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  # delete user
def destroy
  if @user.id == current_user.id
    redirect_to admin_users_url, notice: "You can not delete signed in user"
    @admins = User.admins
  elsif @admins == 1
    redirect_to admin_users_url, notice: "Atleast one admin must remain!"
  else
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :user_type, :password, :password_comfirmation)
    end
    def give_users_right_to_admin
      unless current_user && current_user.user_type == "admin"
        redirect_to root_url, notice: "only admin user can access this page"
      end
    end
end
