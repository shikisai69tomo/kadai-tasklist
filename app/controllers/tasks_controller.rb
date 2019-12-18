class TasksController < ApplicationController
  before_action :require_user_logged_in #全アクションにログインが必要
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.order(created_at: :desc) #タスク一覧を作成順に表示
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to root_path
    else
      @task = current_user.tasks.build(task_params)
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end

  def edit
  end

  def update
    @task = current_user.tasks.build(task_params)
    
      if @task.update_attributes(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  
  
  private
  
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
  
end
