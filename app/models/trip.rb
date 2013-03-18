class Trip < ActiveRecord::Base
  has_many :stop_times, :foreign_key => "trip_id", :primary_key => "trip_id", :order => "stop_sequence"
  belongs_to :route, :foreign_key => "route_id", :primary_key => "route_id"
  has_many :shape_points, :foreign_key => "shape_id", :primary_key => "shape_id", :order => "shape_pt_sequence"

  def geometry
    trip_points = shape_points.map do |p|
      [p.shape_pt_lon, p.shape_pt_lat]
    end
    {
      :type => "LineString",
      :coordinates => trip_points
    }
  end

  def start_time
    stop_times.any? ? stop_times.first.arrival_time : null
  end

  def end_time
    stop_times.any? ? stop_times.last.departure_time : null
  end

  def first_stop_name
    stop_times.any? ? stop_times.first.stop.stop_name : null
  end

  def last_stop_name
    stop_times.any? ? stop_times.last.stop.stop_name : null
  end
end
