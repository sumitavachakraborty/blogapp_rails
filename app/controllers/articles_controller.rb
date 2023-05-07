class ArticlesController < ApplicationController

    def show
      @article = Article.find(params[:id])
    end

    def index
      @article = Article.all
    end

    def new 
      @article = Article.new
    end

    def edit
      @article = Article.find(params[:id])
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
      @article = Article.find(params[:id])
      if @article.update(params.require(:article).permit(:name,:description))
        flash[:notice] = "Article updated successfully"
        redirect_to @article
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      flash[:notice] = "Article deleted successfully"
      redirect_to articles_path
    end

end
