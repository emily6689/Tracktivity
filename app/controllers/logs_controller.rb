class LogsController < ApplicationController

  def index
    @activities = current_user.activities
    @logs = current_user.logs
    if params[:q]
      query_date = Date.parse(params[:q][:date])
      @queried_logs       = @logs.sort_by_week(query_date)
      @total_productivity = @queried_logs.total_productivity
      @queried_categories = @queried_logs.list_categories
      render :index
    end
  end

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
  end
end
