class LogsController < ApplicationController

  def create
    @log = Activity.find(params[:activity_id]).incomplete_logs.take
    if @log
      @log.time_clocked_out = DateTime.now
    else
      @log = Log.new(time_clocked_in: DateTime.now, activity_id: params[:activity_id])
    end
    if @log.save
      respond_to do |format|
        format.json { render json: @log }
      end
    end
    # redirect_to activity_path(@log.activity)
  end

  # def update
  #   @log = Log.find(params[:id])
  #   @log.update!(time_clocked_out: DateTime.now)
  #   redirect_to activity_path(@log.activity)
  # end

end
