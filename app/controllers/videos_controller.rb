class VideosController < ApplicationController
  before_filter :authorize

  def index
    @categories = Category.all
  end

  def search
    title = params[:title]
    @videos = Video.search_by_title(title)

    if title.empty?
      flash[:error] = "Please enter 1 or more characters.  Previous search contained 0 characters."
    elsif @videos.empty?
      flash[:error] = "No results for search \"#{title}\""
    end
  end

  def show
    @video   = Video.find(params[:id])
    @average_rating = @video.average_rating(@video.review_ratings_as_array)
    @review  = Review.new
    @reviews = Review.where(video_id: @video.id).order("created_at DESC")
  end
end
