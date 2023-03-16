require 'fuzzystringmatch'
class ArticlesController < ApplicationController
  before_action :current_user
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
    last_search = @current_user.searches.order(created_at: :desc).first
    return unless should_save_search?(query, last_search)

    if last_search.nil? || !similar?(last_search.query, query)
      Search.create(query:, user: @current_user)
    else
      last_search.update(query:)
    end
  end

  def should_save_search?(query, last_search)
    return false if query.blank? || query.length < 3
    return true if last_search.nil? || !query.include?(last_search.query)

    last_search.query.length < query.length
  end

  def similar?(text1, text2)
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    distance = jarow.getDistance(text1.gsub(/\s+/, ''), text2.gsub(/\s+/, ''))
    distance > 0.8
  end

  def current_user
    current_ip = request.remote_ip
    existing_user = User.find_by(ip_address: current_ip)
    @current_user = if existing_user.present?
                      existing_user
                    else
                      User.create(ip_address: current_ip)
                    end
  end
end
