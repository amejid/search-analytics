class SearchesController < ApplicationController
  def index
    @searches = Search.group(:query).select('query, COUNT(*) as count').order(count: :desc).limit(20)
  end
end
