# frozen_string_literal: true

require 'symbo/refinement/integer'
require 'symbo/refinement/symbol'

module Symbo
  # シンボリックな階乗
  class Factorial
    using Symbo::Refinement

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def base
      self
    end

    def exponent
      1
    end

    def term
      Product(self)
    end

    def const
      1
    end

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
