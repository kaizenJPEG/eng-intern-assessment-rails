class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])

    begin
      @article.destroy!
      flash[:notice] = 'Article was successfully destroyed.'
      redirect_to articles_path
    rescue ActiveRecord::RecordNotDestroyed
      flash[:alert] = 'Article could not be destroyed.'
      redirect_to article_path(@article)
    end
  end
end
