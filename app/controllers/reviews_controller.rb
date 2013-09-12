class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    review          = Review.new(params_review)
    review.user_id  = current_user.id
    review.video_id = params[:video_id]

    if review.save
      redirect_to video_path(review.video), flash: { success: "Thank you for reviewing this video!"}
    else
      redirect_to video_path(review.video), flash: { error: "Description may not be blank " }
    end
  end

private

  def params_review
    params[:review].permit(:description, :rating)
  end
end
