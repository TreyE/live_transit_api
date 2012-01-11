class TripsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @trip = Trip.by_trip_id(:key => params[:id]).first

    respond_to do |format|
      format.html {
        self.formats = [:json]
        render :content_type => "application/json"
      }
      format.json
      format.xml
    end
  end
end
