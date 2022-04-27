class AirplaneSeating
  attr_accessor :passenger, :container

  def initialize(container, passenger)
    @container = container
    @passenger = passenger
    @column = 0
    @total_row = 0
    @passenger_seat = []
    @result = []

  end

  def arange_seat
    index = 0
    container.each do |column_size, row_size|
      max_column_size = @column + column_size

      for row in 1 .. row_size
        if index == 0
          @result.push([row, 1, "2-Window Seat"], [row, column_size, "1-Aisle Seat"])
        elsif index == (container.length - 1)
          @result.push([row, (@column + 1), "1-Aisle Seat"], [row, max_column_size, "2-Window Seat"])
        else
          @result.push([row, (@column + 1), "1-Aisle Seat"], [row, max_column_size, "1-Aisle Seat"])
        end
      end

      if column_size > 2
        for row in 1 .. row_size
          for column in (@column + 2) .. (max_column_size - 1 )
            @result.push([row,column, "3-Middle Seat"])
          end
        end
      end
      sort_record()
      @column += column_size
      index = index + 1
    end

    allocate_seat(passenger)
    return @passenger_seat
  end

  def allocate_seat(passenger_count)
    for i in 0 .. (passenger_count - 1)
      @passenger_seat.push(@result[i])
    end
  end

  def sort_record
    @result = @result.sort_by{|row,column,location| [row]}
    @result = @result.sort_by{|row,column,location| [location.chars.first.chomp.to_i]}
  end
end