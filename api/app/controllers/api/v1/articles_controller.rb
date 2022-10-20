class Api::V1::ArticlesController < ApplicationController
  include Pagy::Backend
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    if index_params[:search].present?
    @pagy, @articles = pagy(Article.all.where("title like ?", "%#{index_params[:search]}%").order("articles.publishedAt #{index_params[:sort_dir]}"), page: index_params[:page].to_i, items: index_params[:limit].to_i)
    render json: { data: @articles,
                  total: @pagy.count }
    else
      @pagy, @articles = pagy(Article.all.order("articles.publishedAt #{index_params[:sort_dir]}"), page: index_params[:page].to_i, items: index_params[:limit].to_i)
      render json: { data: @articles,
                    total: @pagy.count }
    end
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def index_params
      params.permit(:page, :limit, :sort_dir, :search)
    end

    def article_params
      params.require(:article).permit(:id, :imageUrl, :newsSite, :publishedAt, :summary, :title, :updatedAt, :url)
    end
end