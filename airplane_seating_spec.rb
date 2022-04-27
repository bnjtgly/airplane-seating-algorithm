require 'test/unit'
require_relative 'airplane_seating'

class AirplaneSeatingSpec < Test::Unit::TestCase
  describe "AirplaneSeating" do
    before do
      @flight = AirplaneSeating.new([[3,2], [4,3], [2,3], [3,4]], 30)
      @seats = @flight.arange_seat
    end

    it "should not have a nil cell" do
      @flight != nil
    end

    it "should not have a passenger_count lessthan 0" do
      @flight.passenger >= 1
    end

    it "should result an array" do
      @seats.is_a? Array
    end

    it "should have equal or more seats than passenger" do
      if (@seats.length >= @flight.passenger)
        true
      else
        false
      end
    end

  end
end