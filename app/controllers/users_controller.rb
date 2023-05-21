class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit,:update,:destroy]
    before_action :same_user, only: [:edit, :update]
  
    def index
      @user = User.all
    end
  
    def show
      @article = @user.articles
    end
  
    def new
        @user = User.new
    end
    
    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Your account information was updated successfully"
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
          flash[:info] = "Welcome to the blog, #{@user.username}! You signed in successfully."
          redirect_to articles_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def destroy
      @user.destroy
      session[:user_id] = nil if @user = current_user
      flash[:danger] = "Account and all associated articles have been deleted"
      redirect_to articles_path
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "Your can edit or delete your own article"
        redirect_to @user  
      end
    end
end