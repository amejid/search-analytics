class ArticlesController < ApplicationController
  def index
    @articles = if params[:query].present?
                  Article.where('title ILIKE ?', "%#{params[:query]}%").first(25)
                else
                  Article.all.first(50)
                end
  end
end
