class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,:edit,:update,:destroy]
  before_action :require_user, except: [:show,:index]
  before_action :same_user, only: [:edit,:update,:destroy]

    def show
    end

    def index
      @article = Article.all
    end

    def new 
      @article = Article.new
    end

    def edit
    end

    def create
      @article = Article.new(params.require(:article).permit(:name,:description))
      @article.user = current_user
      if @article.save
        flash[:success] = "Article created successfully"
        redirect_to @article
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(params.require(:article).permit(:name,:description))
        flash[:info] = "Article updated successfully"
        redirect_to @article
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      flash[:danger] = "Article deleted successfully"
      redirect_to articles_path
    end

    private 

    def set_article
      @article = Article.find(params[:id])
    end

    def same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "Your can edit or delete your own article"
        redirect_to @article  
      end
    end
end
