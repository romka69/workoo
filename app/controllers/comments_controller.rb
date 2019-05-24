class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  load_and_authorize_resource

  def create
    @comment = task.comments.new(comment_params)
    @comment.author = current_user
    @comment.save
    flash[:notice] = 'Комментарий создан'
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
