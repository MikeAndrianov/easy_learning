class SettingsController < ApplicationController
  before_filter :set_the_header

  def show; end

  private

  def set_the_header
    @the_header = :settings
  end
end
