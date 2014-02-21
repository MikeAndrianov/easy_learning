class EventsController < ApplicationController
  before_filter :set_the_header, :set_user

  #TODO: add destroy action! Also add dependent: :destroy Enent.rb has_many :participations, dependent: :destroy
  #

  def index
    @events = @user.events
  end

  def show; end

  def new
    @event = Event.new
    @participation = @event.participations.build
  end

  def edit
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @event = Event.new(event_params)
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @product.update(product_params)
  #       format.html { redirect_to @product, notice: 'Product was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update

  end
  
  private

  def set_user
    @user = current_user
  end

  def set_the_header
    @the_header = :settings
  end

  def event_params
    params[:event][:user_ids].reject!{ |id| id.empty? }
    params[:event].permit!
  end

end
