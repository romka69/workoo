class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  authorize_resource

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
  end

  def create
    @task = Task.new(tasks_params)

    if @task.save
      redirect_to @task, notice: 'Задание создано'
    else
      render :new
    end
  end

  private

  def tasks_params
    params.require(:task).permit(:title, :body, :price)
  end

  def task
    @task ||= params[:id] ? Task.find(params[:id]) : Task.new
  end

  helper_method :task

end
