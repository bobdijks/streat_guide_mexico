class StallsController < ApplicationController
  before_action :set_stall, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create]

  def index
    if params[:query].present?
      @stalls = Stall.search_by_name_and_description(params[:query]).geocoded
      @markers = @stalls.geocoded.map do |place|
        {
          id:  place.id,
          lat: place.latitude,
          lng: place.longitude,
          info_window: render_to_string(partial: "info_window", locals: { stall: place })
        }
      end
    else
      @stalls = Stall.geocoded
      @markers = @stalls.geocoded.map do |place|
        {
          id:  place.id,
          lat: place.latitude,
          lng: place.longitude,
          info_window: render_to_string(partial: "info_window", locals: { stall: place })
        }
      end
    end
  end

  def show
    @review = Review.new

    @markers = [
      {
        id: @stall.id,
        lat: @stall.latitude,
        lng: @stall.longitude,
        info_window: render_to_string(partial: "info_window", locals: { stall: @stall })
      }
    ]
  end

  def new
    @stall = Stall.new
  end

  def create
    @stall = Stall.new(stall_params)
    @stall.user = current_user
    if @stall.save
      flash[:alert] = "Created succesfully"
      redirect_to stall_path(@stall)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @stall.update(stall_params)
    redirect_to stall_path(@stall) # Optional
  end

  def destroy
    @stall.destroy
    redirect_to stalls_path
  end

  private

  def stall_params
    params.require(:stall).permit(:name, :category, :description, :rating, :address, services: [], photos: [])
  end

  def set_stall
    @stall = Stall.find(params[:id])
  end

end
