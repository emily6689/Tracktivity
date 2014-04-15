class LogsController < ApplicationController

  def create
    @log = Log.new(time_clocked_in: DateTime.now, activity_id: params[:activity_id])
    @log.save
    redirect_to activity_path(@log.activity)
  end

  def update
    @log = Log.find_by(id: params[:id])
    @log.update!(time_clocked_out: DateTime.now)
    redirect_to activity_path(@log.activity)
  end

end
