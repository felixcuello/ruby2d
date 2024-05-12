# frozen_string_literal: true

require "ruby2d"
require_relative "./vector"

set title: "2D RayCasting"

class Wall
  attr_accessor :p1, :p2

  def initialize(a_row, a_col, b_row, b_col)
    @p1 = Vector.new(a_row, a_col)
    @p2 = Vector.new(b_row, b_col)
  end

  def show
    Line.new(x1: @p1.x, y1: @p1.y,
             x2: @p2.x, y2: @p2.y,
             width: 2,
             color: '#FFFFFF')
  end
end

class Ray
  def initialize(pos, angle)
    @pos = pos
    @dir = Vector.from_angle(angle)
    @line = nil
  end

  def show
    @line.remove if @line
    @line = Line.new(x1: @pos.x, y1: @pos.y,
                     x2: @pos.x + @dir.x * 10, y2: @pos.y + @dir.y * 10,
                     width: 1,
                     color: '#FFFFA0')
  end

  def look_at(x,y)
    @dir.x = x - @pos.x
    @dir.y = y - @pos.y
    @dir.normalize!
  end

  def cast(wall)
    x1 = wall.p1.x
    y1 = wall.p1.y
    x2 = wall.p2.x
    y2 = wall.p2.y

    x3 = @pos.x
    y3 = @pos.y
    x4 = @pos.x + @dir.x
    y4 = @pos.y + @dir.y

    den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)

    return nil if den.zero?

    t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)).to_f / den.to_f
    u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)).to_f / den.to_f

    if(t > 0 && t < 1 && u > 0)
      ptx = x1 + t * (x2 - x1)
      pty = y1 + t * (y2 - y1)
      return Vector.new(ptx, pty)
    end

    return nil
  end
end

class Particle
  def initialize
    @pos = Vector.new(Window.width / 2, Window.height / 2)
    @rays = []
    @lines = []

    120.times do |angle|
      @rays << Ray.new(@pos, angle * 3)
      @lines << nil
    end
  end

  def show
    @rays.each { |ray| ray.show }
  end

  def look(wall)
    @rays.count.times do |i|
      @lines[i].remove unless @lines[i].nil?
      pt = @rays[i].cast(wall)
      unless pt.nil?
        @lines[i] = Line.new(x1: @pos.x, y1: @pos.y,
                             x2: pt.x, y2: pt.y,
                             width: 1,
                             color: '#FFFF00')
      end
    end
  end

  def update(x, y)
    @pos.set(x, y)
  end
end

x1 = Random.new.rand(Window.width)
y1 = Random.new.rand(Window.height)
x2 = Random.new.rand(Window.width)
y2 = Random.new.rand(Window.height)
wall1 = Wall.new(x1, y1, x2, y2)
particle = Particle.new

update do
  wall1.show
  particle.show
  particle.update(Window.mouse_x, Window.mouse_y)
  particle.look(wall1)
end

show
