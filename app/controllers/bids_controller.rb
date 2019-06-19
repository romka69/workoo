class BidsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def create
    task = Task.find(params[:task_id])
    @bid = task.bids.create(user: current_user)
  end

  def destroy
    @bid = current_user.bids.find(params[:id])

    if @bid
      @bid.destroy
    else
      head :forbidden
    end
  end

  def approve_executor
    if current_user.author_of?(task)
      bid.set_approve
      task.set_executor(bid.user)
    else
      head :forbidden
    end
  end

  private

  def task
    @task ||= bid.task
  end

  def bid
    @bid ||= Bid.find(params[:id])
  end

  helper_method :task, :bid
end
