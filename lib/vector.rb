# frozen_string_literal: true

require 'matrix'

class RowVector
  using Symbo

  def self.[](*elements)
    new(*elements)
  end

  def initialize(*elements)
    @elements = elements
  end

  def *(other)
    product = to_matrix * other.to_matrix
    product[0, 0].simplify
  end

  def to_matrix
    Matrix[@elements.map(&:simplify)]
  end

  def to_a
    @elements
  end
end

class Bra < RowVector
  using Symbo

  def self.[](*values)
    case values[0]
    when Integer, Symbo::Expression
      super(*values)
    when String
      if values == ['↑']
        super 1, 0
      elsif values == ['↓']
        super 0, 1
      elsif values == ['→']
        super 1/√(2), -1/√(2)
      elsif values == ['←']
        super 1/√(2), 1/√(2)
      elsif values == ['↗']
        super 1/2, -√(3)/2
      elsif values == ['↙']
        super √(3)/2, 1/2
      else
        raise values[0].inspect
      end
    else
      raise values[0].inspect
    end
  end
end

class ColumnVector
  using Symbo

  attr_reader :elements

  def self.[](*elements)
    new(*elements)
  end

  def initialize(*elements)
    @elements = elements
  end

  def to_matrix
    Matrix[*(@elements.map { |each| [each.simplify] })]
  end

  def bra
    Bra[*@elements]
  end

  def ket
    Ket[*@elements]
  end

  def +(other)
    elements = ((@elements.zip other.elements).map { |each| each.inject(:+) })
    ColumnVector.new(*elements).simplify
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
  using Symbo

  def self.[](*values)
    case values[0]
    when Integer, Symbo::Expression
      super(*values)
    when String
      if values == ['↑']
        super 1, 0
      elsif values == ['↓']
        super 0, 1
      elsif values == ['→']
        super 1/√(2), -1/√(2)
      elsif values == ['←']
        super 1/√(2), 1/√(2)
      elsif values == ['↗']
        super 1/2, -√(3)/2
      elsif values == ['↙']
        super √(3)/2, 1/2
      else
        raise values[0].inspect
      end
    else
      raise values[0].inspect
    end
  end
end
