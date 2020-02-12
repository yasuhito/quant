# frozen_string_literal: true

require 'matrix'

class ColumnVector
  using Symbo

  attr_reader :elements

  def self.[](*elements)
    new(*elements)
  end

  def initialize(*elements)
    @elements = elements
  end

  def +(other)
    ColumnVector.new(*((@elements.zip other.elements).map { |each| each.inject(:+) }))
  end

  def *(other)
    (@elements.zip other.elements).map { |each| each.inject(:*) }.inject(:+)
  end

  def simplify
    ColumnVector.new(*@elements.map(&:simplify))
  end

  def length
    Sqrt(Sum(*(@elements.map { |each| Power(each, 2) }))).simplify
  end

  def to_a
    @elements
  end

  def undefined?
    false
  end

  def zero?
    false
  end

  def product?
    false
  end

  def constant?
    false
  end

  def base
    self
  end

  def compare(_other)
    false
  end

  def map(&block)
    ColumnVector.new(*@elements.map(&block))
  end
end

class Ket < ColumnVector
end

class RowVector
  def self.[](*elements)
    new(*elements)
  end

  def initialize(*elements)
    @elements = elements
  end

  def to_a
    @elements
  end
end
