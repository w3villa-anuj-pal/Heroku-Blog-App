class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @pagy, @users = pagy(User.all, items: 4)
  end
  
  def show
    @blogs = @user.blogs
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to blogs_path, :notice => "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, :notice => "Your account information was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated Blogs successfully deleted"
    redirect_to blogs_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to @user, :notice => "You Can Only Edit Your Own Profile"
    end
  end
  
end