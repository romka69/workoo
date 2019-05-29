class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  load_and_authorize_resource

  def index
    @tasks = Task.all
  end

  def show
    @comment = Comment.new
    @bids = task.bids
  end

  def new
  end

  def create
    @task = Task.new(task_params)
    @task.author = current_user

    if @task.save
      redirect_to @task, notice: 'Задание создано'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if task.update(task_params)
      redirect_to task, notice: 'Задание обновлено'
    else
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :price)
  end

  def task
    @task ||= params[:id] ? Task.find(params[:id]) : Task.new
  end

  # method for executor (partial bid/bid_link)
  def bid
    @bid ||= task.bids.find_by(user: current_user)
  end

  helper_method :task, :bid

end
