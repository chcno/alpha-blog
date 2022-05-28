class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    @articles = @user.articles
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to alpha blog #{@user.username}, you have succesfully sign up"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update

    @user = User.find(params[:id])


      if @user.update(user_params)

        flash[:notice] = "usuario editado exitosamente"
        redirect_to @user
      else
        render 'edit'
      end

  end


  def user_params
    params.require(:user).permit(:username, :email,  :password)
  end

end
