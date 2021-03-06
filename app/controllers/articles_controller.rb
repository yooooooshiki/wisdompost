class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @articles = Article.order("created_at DESC").page(params[:page]).per(10)
    @articles ||= Post.page(params[:page]).per(10)
    # @user = current_user
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user 
    @article.title = params[:article][:title]
    @article.content = params[:article][:content]
    @article.save
    redirect_to root_path
  end 

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new #①
    @comments = @article.comments #②
    @like = Like.find_by(user_id: current_user.id, article_id: params[:id]) if user_signed_in?
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:id]) if user_signed_in?
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    article = Article.find(params[:id])
    article.update(article_params)
    redirect_to root_path
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end

end