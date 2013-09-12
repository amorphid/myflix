class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    review          = Review.new(params_review)
    review.user_id  = current_user.id
    review.video_id = params[:video_id]

    if review.save
      redirect_to video_path(review.video), flash: { success: "Review created successfully"}
    else
      redirect_to video_path(review.video), flash: { error: "Invalid rating and/or description" }
    end
  end

private

  def params_review
    params[:review].permit(:description, :rating)
  end
end
