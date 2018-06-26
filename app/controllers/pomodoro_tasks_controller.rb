class PomodoroTasksController < ApplicationController
  before_action :set_pomodoro_task, only: [:show, :edit, :update, :destroy]

  # GET /pomodoro_tasks
  # GET /pomodoro_tasks.json
  def index
    @pomodoro_tasks = PomodoroTask.all
  end

  # GET /pomodoro_tasks/1
  # GET /pomodoro_tasks/1.json
  def show
  end

  # GET /pomodoro_tasks/new
  def new
    @pomodoro_task = PomodoroTask.new
  end

  # GET /pomodoro_tasks/1/edit
  def edit
  end

  # POST /pomodoro_tasks
  # POST /pomodoro_tasks.json
  def create
    @pomodoro_task = PomodoroTask.new(pomodoro_task_params)

    respond_to do |format|
      if @pomodoro_task.save
        format.html { redirect_to @pomodoro_task, notice: 'Pomodoro task was successfully created.' }
        format.json { render :show, status: :created, location: @pomodoro_task }
      else
        format.html { render :new }
        format.json { render json: @pomodoro_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pomodoro_tasks/1
  # PATCH/PUT /pomodoro_tasks/1.json
  def update
    respond_to do |format|
      if @pomodoro_task.update(pomodoro_task_params)
        format.html { redirect_to @pomodoro_task, notice: 'Pomodoro task was successfully updated.' }
        format.json { render :show, status: :ok, location: @pomodoro_task }
      else
        format.html { render :edit }
        format.json { render json: @pomodoro_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pomodoro_tasks/1
  # DELETE /pomodoro_tasks/1.json
  def destroy
    @pomodoro_task.destroy
    respond_to do |format|
      format.html { redirect_to pomodoro_tasks_url, notice: 'Pomodoro task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pomodoro_task
      @pomodoro_task = PomodoroTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pomodoro_task_params
      params.require(:pomodoro_task).permit(:objective, :user_id)
    end
end
