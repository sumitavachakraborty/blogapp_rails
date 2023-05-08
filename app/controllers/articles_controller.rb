class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,:edit,:update,:destroy]


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
      if @article.save
        flash[:notice] = "Article created successfully"
        redirect_to @article
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(params.require(:article).permit(:name,:description))
        flash[:notice] = "Article updated successfully"
        redirect_to @article
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      flash[:notice] = "Article deleted successfully"
      redirect_to articles_path
    end

    private 

    def set_article
      @article = Article.find(params[:id])
    end

end
