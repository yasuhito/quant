# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/product'

module Symbolic
  # 分数のシンボリック演算
  class Rational < Base
    attr_reader :numerator
    attr_reader :denominator

    def initialize(numerator, denominator)
      @numerator = numerator
      @denominator = denominator
    end

    def *(other)
      if other.is_a?(Integer)
        Rational.new(Product.new(@numerator, other), @denominator)
      elsif other.is_a?(Rational)
        Rational.new(Product.new(@numerator, other.numerator),
                     Product.new(@denominator, other.denominator))
      else
        Product.new(self, other)
      end
    end

    def zero?
      @numerator.zero?
    end

    def ==(other)
      @numerator == other.numerator && @denominator == other.denominator
      # # a/b と c/d の比較
      # # → ad/bd と bc/bd の比較
      # if other.is_a?(Rational)
      #   Product.new(@numerator, other.denominator).simplify ==
      #     Product.new(other.numerator, @denominator).simplify
      # else
      #   false
      # end
    end

    def simplify
      numerator = @numerator.is_a?(Base) ? @numerator.simplify : @numerator
      denominator = @denominator.is_a?(Base) ? @denominator.simplify : @denominator

      return 1 if numerator.class == denominator.class && numerator == denominator
      return 0 if numerator.zero?

      self.class.new(numerator, denominator)
    end

    def eql?(other)
      self.==(other)
    end

    def hash
      [@numerator, @denominator].hash
    end
  end
end

def Rational(numerator, denominator) # rubocop:disable Naming/MethodName
  Symbolic::Rational.new(numerator, denominator)
end
