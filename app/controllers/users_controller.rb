class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_user_auth, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show

    @articles = @user.articles

  end

  def index
    @user = User.all
    @user = User.paginate(page: params[:page], per_page: 5)

  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to alpha blog #{@user.username}, you have succesfully sign up"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end


  def update



      if @user.update(user_params)

        flash[:notice] = "usuario editado exitosamente"
        redirect_to @user
      else
        render 'edit'
      end

  end

  def destroy
    @user.destroy
    if @user == current_user
      session[:user_id] = nil 
    end
    flash[:notice] = "El usuario a sido eliminado"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:username, :email,  :password)
  end
  def set_user
    @user = User.find(params[:id])
  end

end
