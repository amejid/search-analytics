class ArticlesController < ApplicationController
  def index
    if params[:query].present?
      save_search(params[:query])
      @articles = Article.where('title ILIKE ?', "%#{params[:query]}%").first(25)
    else
      @articles = Article.all.first(50)
    end
  end

  private

  def save_search(query)
    last_search = current_user.searches.order(created_at: :desc).first
    return unless should_save_search?(query, last_search)

    if last_search.nil? || !query.include?(last_search.query)
      Search.create(query:, user: current_user)
    elsif last_search.query.length < query.length
      last_search.update(query:)
    end
  end

  def should_save_search?(query, last_search)
    return false if query.blank? || query.length < 3
    return false if last_search.present? && last_search.query.include?(query)
    return true if last_search.nil? || !query.include?(last_search.query)

    last_search.query.length < query.length
  end
end
