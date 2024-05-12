class Vector
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def normalize!
    norm = Math.sqrt(@x*@x + @y*@y)
    @x /= norm
    @y /= norm
  end

  def set(x,y)
    @x = x
    @y = y
  end

  def self.from_angle(angle)
    radians = angle * Math::PI / 180 
    self.from_radians(radians)
  end

  def self.from_radians(radians)
    Vector.new(Math.cos(radians),
               Math.sin(radians))
  end
end
