class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  def index

    #for search
    if params[:query].present?
    # sql_query = "name @@ :query OR location @@ :query"
    #  @bikes = Bike.where(sql_query, query: "%#{params[:query]}%")
      @bikes = Bike.search_by_name_and_location(params[:query])
    else
      @bikes = Bike.all
    end
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
        image_url: helpers.asset_url("bikeicon.png")
      }
    end
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user

    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  def edit
  end

  def show
    user = User.where(id: @bike.user_id).first
    @name = user.first_name
  end

  def update
    if @bike.user == current_user

    # the update action already saves the changes
      if @bike.update(bike_params)
        redirect_to bike_path(@bike)
      else
        render :edit
      end
    end
  end

  def destroy
    if @bike.user == current_user
      @bike.destroy
    end
    redirect_to bikes_path
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :model, :image, :description, :location, :year, :price)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end
end
