class PomodoroMemosController < ApplicationController
  before_action :set_pomodoro_memo, only: [:show, :edit, :update, :destroy]

  # GET /pomodoro_memos
  # GET /pomodoro_memos.json
  def index
    @pomodoro_memos = PomodoroMemo.all
  end

  # GET /pomodoro_memos/1
  # GET /pomodoro_memos/1.json
  def show
  end

  # GET /pomodoro_memos/new
  def new
    @pomodoro_memo = PomodoroMemo.new
  end

  # GET /pomodoro_memos/1/edit
  def edit
  end

  # POST /pomodoro_memos
  # POST /pomodoro_memos.json
  def create
    @pomodoro_memo = PomodoroMemo.new(pomodoro_memo_params)

    respond_to do |format|
      if @pomodoro_memo.save
        format.html { redirect_to @pomodoro_memo, notice: 'Pomodoro memo was successfully created.' }
        format.json { render :show, status: :created, location: @pomodoro_memo }
      else
        format.html { render :new }
        format.json { render json: @pomodoro_memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pomodoro_memos/1
  # PATCH/PUT /pomodoro_memos/1.json
  def update
    respond_to do |format|
      if @pomodoro_memo.update(pomodoro_memo_params)
        format.html { redirect_to @pomodoro_memo, notice: 'Pomodoro memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @pomodoro_memo }
      else
        format.html { render :edit }
        format.json { render json: @pomodoro_memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pomodoro_memos/1
  # DELETE /pomodoro_memos/1.json
  def destroy
    @pomodoro_memo.destroy
    respond_to do |format|
      format.html { redirect_to pomodoro_memos_url, notice: 'Pomodoro memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pomodoro_memo
      @pomodoro_memo = PomodoroMemo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pomodoro_memo_params
      params.require(:pomodoro_memo).permit(:memo, :pomodoro_task_id)
    end
end
