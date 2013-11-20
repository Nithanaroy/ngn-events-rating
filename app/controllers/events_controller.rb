require 'exceptions'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def welcome
    render :file => "#{Rails.root}/public/welcome.html"
  end

  # GET /events
  # GET /events.json
  def index
    @search = Event.joins('LEFT OUTER JOIN events_ratings ON events.id = events_ratings.event_id').select('events.*', 'AVG(rating) as rating').group(:id).search(params[:q])
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
    elsif (params[:q] and params[:q][:s].index(/rating (asc|desc)/)) #TODO Make Ransack do this for associated table
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
    do_update_or_create(:create)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    do_update_or_create(:update)
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
    event = Event.find(params[:id])
    event.ratings << EventsRatings.new(:rating => params[:rating])
    if event.save
      flash[:notice] = 'Saved the rating!'
      render :partial => 'layouts/notice', locals: {type: 'success'}
    else
      flash[:notice] = 'Could not save the rating. Please try again!'
      render :partial => 'layouts/notice', locals: {type: 'error'}
    end
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

  def do_update_or_create(action)
    begin
      if (action == :update)
        update_helper
      elsif (action == :create)
        create_helper
      end
    rescue TooBigFile => e
      @type = 'danger' # for error notice
      flash[:notice] = e.message
      render action: 'new'
    rescue InvalidFile => e
      flash[:notice] = e.message
      @type = 'danger' # for error notice
      render action: 'new'
    rescue Exception => e
      puts "Whats the matter: "
      flash[:notice] = GlobalConstants::GENERIC_ERROR_MSG
      @type = 'danger' # for error notice
      render action: 'show'
    end
  end

  def create_helper
    @event = Event.new(event_params)
    @event.transaction do
      respond_to do |format|
        if @event.save!
          upload_or_delete(@event.id)
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render action: 'show', status: :created, location: @event }
        else
          format.html { render action: 'new' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update_helper
    @event.transaction do
      respond_to do |format|
        if @event.update(event_params)
          upload_or_delete(@event.id)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def validate_file
    uploaded_io = params[:event][:picture]
    raise InvalidFile, 'Only images can be uploaded' unless uploaded_io.content_type.index('image/')
    raise TooBigFile, "Image shouldn't be greater than #{GlobalConstants::MAX_FILE_SIZE / 1024 / 1024}MB" if uploaded_io.size > GlobalConstants::MAX_FILE_SIZE
  end

  # Maintains the image files in the file system under the /public/event_images/ folder.
  # Uploads files if present. Deletes file if present
  def upload_or_delete(filename)
    uploaded_io = params[:event][:picture]
    abs_filepath = GlobalConstants::EVENT_IMAGES_PATH.join(filename.to_s)
    if not uploaded_io.nil? and uploaded_io.size > 0
      validate_file
      File.open(abs_filepath, 'wb') { |file| file.write(uploaded_io.read) }
    elsif params[:event][:remove_image?] == 'true'
      File.delete(abs_filepath) if File.exists? abs_filepath
    end
  end
end
