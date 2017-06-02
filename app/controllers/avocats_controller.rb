class AvocatsController < ApplicationController

  before_action :set_avocat, only: [:show, :edit, :update, :destroy]

  def new
    @avocat = Avocat.new
  end

  def index
    @avocats = Avocat.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@avocats) do |avocat, marker|
      marker.lat avocat.latitude
      marker.lng avocat.longitude
      marker.infowindow render_to_string(partial: "pages/avocat_map_box", locals: { avocat: avocat })
    end
  end

   def show
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

  #  def search
  #   @search = params[:search]
  #   if params[:search] =! ""
  #     @users = User.near("#{params[:search]}", 5)
  #     @avocats = find_avocates_by_location(@users)
  #   else
  #     @avocats = Avocat.all
  #   end
  # end

  def destroy
  end

  private

  def set_avocat
    @avocat = Avocat.find(params[:id])
  end

  def avocat_params
    params.require(:avocat).permit(:name, :address)
  end

   # def find_avocats_by_location(users)
  #   avocats_array = []
  #   user_avocats_array = []
  #   users.each do |user|
  #   user.avocats.each do |avocat|
  #     user_avocats_array << avocat
  #     end
  #   end
  #   user_avocats_array.each do |avocat|
  #     avocats_array << avocat
  #   end
  #   return avocats_array
  # end
end

