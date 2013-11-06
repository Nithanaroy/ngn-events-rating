class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @search = Event.joins('LEFT OUTER JOIN events_ratings ON events.id = events_ratings.event_id').select('events.*', 'AVG(rating) as ra' ).group(:event_id).search(params[:q])
    #@search = Event.includes(:ratings).joins('LEFT OUTER JOIN events_ratings ON events.id = events_ratings.event_id').search(params[:q])
    #@search = Event.includes(:ratings).search(params[:q])
    #if (params[:q].nil?)
    #  @events = @search.result(:distinct => true).order('created_at DESC').page(params[:page]).per(2)
    #else
    #  @events = @search.result(:distinct => true).page(params[:page]).per(2)
    #end

    #@search = Event.joins('LEFT OUTER JOIN events_ratings ON events.id = events_ratings.event_id').select('events.*', 'AVG(rating) as ra').group(:event_id).search(params[:q])
    #puts "Search Sorts #{@search.sorts}"
    @events = @search.result(:distinct => true).page(params[:page]).per(2)
    if (params[:q].nil?)
      @events = @events.order('created_at DESC')
    elsif (params[:q] and params[:q][:s].index(/ra (asc|desc)/)) #TODO Make Ransack do this for associated table
      @events = @events.order(params[:q][:s])
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def add_rating
    puts "Params #{params}"
    event = Event.find(params[:id])
    event.ratings << EventsRatings.new(:rating => params[:rating])
    event.save
    render :nothing => true
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :details, :place, :from, :to)
  end
end
