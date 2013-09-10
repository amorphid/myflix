class VideosController < ApplicationController
  before_filter :authorize

  def index
    @categories = Category.all
  end

  def search
    @title  = params[:title]
    @videos = Video.search_by_title(@title)
  end

  def show
    @video = Video.find(params[:id])
  end
end
