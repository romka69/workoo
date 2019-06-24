module ReviewsHelper
  def can_review?
    true unless task.reviews.find_by(by_user: current_user)
  end
end
