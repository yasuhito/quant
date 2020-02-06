# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  # シンボリックな階乗
  class Factorial
    using Symbo

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    # :section: Power Transformation Methods

    # See Symbo::Expression#base
    def base
      dup
    end

    # See Symbo::Expression#exponent
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # See Symbo::Expression#term
    def term
      Product(self)
    end

    # See Symbo::Expression#const
    def const
      1
    end

    # :section:

    def compare(v)
      case v
      when Factorial
        @operands[0].compare v.operands[0]
      when Function, Symbol
        if @operands[0] == v
          false
        else
          compare Factorial(v)
        end
      end
    end

    def ==(other)
      @operands == other.operands
    end
  end
end

def Factorial(*operands) # rubocop:disable Naming/MethodName
  Symbo::Factorial.new(*operands)
end
