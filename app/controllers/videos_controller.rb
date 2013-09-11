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
    @video    = Video.find(params[:id])
    @comment  = Comment.new
    @comments = Comment.where(video_id: @video.id)
  end
end
