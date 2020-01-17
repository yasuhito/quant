# frozen_string_literal: true

require 'symbolic/base'

module Symbolic
  # シンボリックな π
  class Pi < Base
    def zero?
      false
    end

    def *(other)
      Product.new(self, other)
    end

    def /(other)
      Rational.new(self, other)
    end

    def ==(other)
      other.is_a?(Pi)
    end

    def simplify
      dup
    end

    def to_s
      'π'
    end
  end

  PI = Pi.new
end
