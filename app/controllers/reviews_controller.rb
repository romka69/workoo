class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  load_and_authorize_resource

  def create
    @review = task.reviews.new(review_params)
    @review.by_user = current_user
    @review.for_user = if current_user.author_of?(task)
                         User.find(task.executor_id)
                       else
                         task.author
                       end
    @review.save
    flash[:notice] = 'Отзыв создан'
  end

  private

  def review
    @review ||= params[:id] ? Review.find(params[:id]) : task.review.new
  end

  def task
    @task ||= if params[:task_id]
              Task.find(params[:task_id])
            else
              review.task
            end
  end

  helper_method :review, :task

  def review_params
    params.require(:review).permit(:body)
  end
end
