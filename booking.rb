require "./airplane_seating"
class Booking

  puts "Default Seats: [3,2], [4,3], [2,3], [3,4]"
  print "Please enter number of passengers: "
  passenger = gets.to_i

  airplane_seating = AirplaneSeating.new([[3,2], [4,3], [2,3], [3,4]], passenger)
  seats = airplane_seating.arange_seat

  puts "Seats = #{seats}"
end