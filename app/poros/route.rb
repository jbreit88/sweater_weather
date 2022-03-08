class Route
  attr_reader :travel_time,
              :origin,
              :destination

  def initialize(data)
    if data[:info][:statuscode] && data[:info][:statuscode] == 402
      @travel_time = 'Impossible route'
    else
      @travel_time = data[:route][:formattedTime]
      @origin = "#{data[:route][:locations][0][:adminArea5]},#{data[:route][:locations][0][:adminArea3]}"
      @destination = "#{data[:route][:locations][1][:adminArea5]},#{data[:route][:locations][1][:adminArea3]}"
    end
  end
end
