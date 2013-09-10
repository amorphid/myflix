class StaticPagesController < ApplicationController
  def front
    if current_user
      redirect_to home_path
    end
  end
end
