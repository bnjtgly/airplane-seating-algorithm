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
        if index.eql?0
          @result << [row, 1, "2-WS"] << [row, column_size, "1-AS"]
        elsif index.eql?(container.length - 1)
          @result << [row, (@column + 1), "1-AS"] << [row, max_column_size, "2-WS"]
        else
          @result << [row, (@column + 1), "1-AS"] << [row, max_column_size, "1-AS"]
        end
      end

      if column_size > 2
        for row in 1 .. row_size
          for column in (@column + 2) .. (max_column_size - 1 )
            @result << [row,column, "3-MS"]
          end
        end
      end
      sort_record()
      @column += column_size
      index += 1
    end

    allocate_seat(passenger)
    return @passenger_seat
  end

  def allocate_seat(passenger_count)
    for i in 0 .. (passenger_count - 1)
      @passenger_seat << @result[i]
    end
  end

  def sort_record
    @result = @result.sort_by{|row,column,location| [row]}
    @result = @result.sort_by{|row,column,location| [location.chars.first.chomp.to_i]}
  end
end