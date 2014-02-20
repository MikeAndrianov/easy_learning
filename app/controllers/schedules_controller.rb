class SchedulesController < ApplicationController
  before_filter :set_the_header

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = Event.all
    @events_by_date = @events.group_by{ |event| event.starts_at.to_date }
  end

  private

  def set_the_header
    @the_header = :schedule
  end

end
