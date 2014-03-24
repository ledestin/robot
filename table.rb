require './direction'

class Robot
  class Table
    attr_reader :width, :height

    def initialize width, height
      @width, @height = width, height
    end

    def inside? x, y
      x >= 0 && x <= @width && y >= 0 && y <= @height
    end
  end
end
