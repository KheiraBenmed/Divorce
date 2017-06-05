class AvocatsController < ApplicationController

  before_action :set_avocat, only: [:show, :edit, :update, :destroy]

  def new
    @avocat = Avocat.new
  end

  def index
    if params[:search] && params[:search] != ""
      @avocats = Avocat.near(params[:search],2)
    else
    @avocats = Avocat.where.not(latitude: nil, longitude: nil)
  end
    @hash = Gmaps4rails.build_markers(@avocats) do |avocat, marker|
      marker.lat avocat.latitude
      marker.lng avocat.longitude
      marker.infowindow render_to_string(partial: "pages/avocat_map_box", locals: { avocat: avocat })
    end
  end

   def show
    @avocats = Avocat.all
    @hash = Gmaps4rails.build_markers(@avocat) do |avocat, marker|
      marker.lat avocat.latitude
      marker.lng avocat.longitude
      marker.infowindow render_to_string(partial: "pages/avocat_map_box", locals: { avocat: avocat })
    end
  end

   def create
    @avocat = Avocat.new(avocats_params)
    if @avocat.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
  end

  private

  def set_avocat
    @avocat = Avocat.find(params[:id])
  end

  def avocat_params
    params.require(:avocat).permit(:name, :address)
  end
end

