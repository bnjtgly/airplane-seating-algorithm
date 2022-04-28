require "./airplane_seating"

class Booking
  attr_accessor :layout, :number_of_passengers, :seat_types, :layout_with_passengers

  def initialize(layout, number_of_passengers=0)
    @layout = layout
    @number_of_passengers = number_of_passengers
    @layout_with_passengers = [layout.size]
    @layout.each_with_index do |(cols, rows), layout_index|
      @layout_with_passengers[layout_index] = Array.new(rows) {Array.new(cols, "xx")}
    end

    @seat_types = { asile: [], window: [], center: [] }
  end

  def group_seat_types
    layout.each_with_index do |(cols, rows), layout_index|
      rows.times do |row_index|
        cols.times do |col_index|

          if layout_index == 0
            seat_types[:asile] << [layout_index, row_index, col_index] if col_index == (cols - 1)
            seat_types[:window] << [layout_index, row_index, col_index] if col_index == 0
          end

          if layout.count == (layout_index + 1)
            seat_types[:asile] << [layout_index, row_index, col_index] if col_index == 0
            seat_types[:window] << [layout_index, row_index, col_index] if col_index == (cols - 1)
          end
    
          if (col_index == 0 || col_index == (cols - 1)) && layout_index != 0 && (layout.count != layout_index + 1)
            seat_types[:asile] << [layout_index, row_index, col_index]
          end
    
          if !seat_types[:asile].include?([layout_index, row_index, col_index]) && !seat_types[:window].include?([layout_index, row_index, col_index])
            seat_types[:center] << [layout_index, row_index, col_index]
          end

        end
      end
    end
    seat_types
  end

  def sort_seats(seats=[])
    seats_sorted = []
    max_seats_to_sort = seats.flatten.max + 1
    
    max_seats_to_sort.times do |layout_index|
      max_seats_to_sort.times do |row_index|
        max_seats_to_sort.times do |col_index|
          next if !seats.include?([ row_index, layout_index, col_index ])
          seats_sorted << [ row_index, layout_index, col_index ]
        end
      end
    end

    seats_sorted
  end

  def allot!
    group_seat_types
    seats_allotment = sort_seats(seat_types[:asile]) + sort_seats(seat_types[:window]) + sort_seats(seat_types[:center])
    seats_allotment.each_with_index do |(layout_index, row_index, col_index), passenger_index|
      passenger_index = passenger_index + 1
      break if passenger_index > number_of_passengers
      passenger = passenger_index < 10 ? "0#{passenger_index}" : passenger_index.to_s
      layout_with_passengers[layout_index][row_index][col_index] = passenger
    end
  end

  def print_layout(array_3d=layout_with_passengers, row_size=layout.collect(&:last).max)
    empty_space = []
    row_size.times do |row|
      array_3d.each_with_index do |array_2d, layout_index|
        empty_space[layout_index] = 0 if row == 0
        if array_2d[row].nil?
          empty_space[layout_index].times { print ' ' }
        else
          seats = "[#{array_2d[row].join(' ')}] "
          empty_space[layout_index] = seats.length if row == 0
          print seats
        end
      end
      puts
    end
  end
end

puts "Default Seats: [3,2], [4,3], [2,3], [3,4]"
print "Please enter number of passengers: "

passenger = gets.to_i
airplane_seating_layout = Booking.new([[3,2], [4,3], [2,3], [3,4]], passenger)
puts "Layout"
seats_layout = airplane_seating_layout.print_layout


puts "Values"
airplane_seating = AirplaneSeating.new([[3,2], [4,3], [2,3], [3,4]], passenger)
seats = airplane_seating.arange_seat
puts seats.inspect