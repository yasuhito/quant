# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックなべき乗
  class Power
    using Symbolic::Refinement

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def base
      @operands[0]
    end

    def exponent
      @operands[1]
    end

    def term
      Product(self)
    end

    def const
      1
    end

    def compare(v)
      case v
      when Power
        return base.compare(v.base) if base != v.base

        exponent.compare(v.exponent)
      when Sum, Factorial, Function, Symbol
        compare Power(v, 1)
      end
    end

    def [](n)
      @operands[n]
    end

    def ==(other)
      @operands == other.operands
    end

    # def simplify
    #   if @v.is_a?(Numeric) && @v.zero?
    #     0
    #   elsif @v == 1
    #     1
    #   elsif @w.is_a?(Numeric) && @w.zero?
    #     1
    #   elsif @w == 1
    #     @v
    #   elsif @v.is_a?(Numeric) && @w.is_a?(Integer)
    #     @v**@w
    #   elsif @v.is_a?(Power) && @w.is_a?(Integer)
    #     Pow(@v.v, [:*, @v.w, @w])
    #   elsif @v.is_a?(Array) && @v[0] == :* && @w.is_a?(Integer)
    #     [:*] + @v[1..-1].map { |each| Pow(each, @w) }
    #   else
    #     self
    #   end
    # end

    # def ==(other)
    #   other.is_a?(Power) && @v == other.v && @w == other.w
    # end
  end
end

def Power(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Power.new(*operands)
end
