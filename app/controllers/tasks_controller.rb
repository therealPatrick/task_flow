# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
   @tasks = policy_scope(Task)
  end

  def show
    authorize @task
  end

  def new
    @task = current_user.tasks.build
    authorize @task
  end

  def create
    @task = current_user.tasks.build(task_params)
    authorize @task
    if @task.save
      TaskMailer.task_created(@task).deliver_now
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      TaskMailer.task_updated(@task).deliver_now
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end
