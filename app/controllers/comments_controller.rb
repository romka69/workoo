class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  load_and_authorize_resource

  def create
    @comment = task.comments.new(comment_params)
    @comment.author = current_user
    @comment.save
    flash[:notice] = 'Комментарий создан'
  end

  def update
    if current_user.author_of?(comment) && comment.edit_time_not_left?
      comment.update(comment_params)
      flash[:notice] = 'Комментарий сохранен'
    else
      head :forbidden
    end
  end

  private

  def comment
    @comment ||= params[:id] ? Comment.find(params[:id]) : task.comment.new
  end

  def task
    @task = if params[:task_id]
              Task.find(params[:task_id])
            else
              comment.task
            end
  end

  helper_method :comment, :task

  def comment_params
    params.require(:comment).permit(:body)
  end
end
