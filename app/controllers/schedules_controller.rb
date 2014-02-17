class SchedulesController < ApplicationController
  before_filter :set_the_header

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private

  def set_the_header
    @the_header = :schedule
  end

end
