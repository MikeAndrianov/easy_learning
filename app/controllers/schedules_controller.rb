class SchedulesController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    # Optimization needed!
    #
    @events = @user.shared_events.sort_by{|event| event.starts_at.strftime('%H %M')}
    # can't write something like @events = @user.shared_events.order(:starts_at)
    # because we should sort by time, not by datetime 
    #

    @events_by_date = @events.reject{ |event| event.is_recurrent }.group_by{ |event| event.starts_at.to_date }
    @events.select{|event| event.is_recurrent}.each do |event|
      date = event.starts_at.to_date

      while date <= event.ends_at.to_date do
        @events_by_date[date] ||= [] 
        @events_by_date[date] << event

        date += 1.send(event.period)
      end

    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_the_header
    @the_header = :schedule
  end
  
  def set_user
    @user = current_user
  end

end
