# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックな階乗
  class Factorial
    using Symbolic::Refinement

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
      return unless v.is_a?(Factorial)

      @operands[0].compare v.operands[0]
    end

    def ==(other)
      @operands == other.operands
    end
  end
end

def Factorial(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Factorial.new(*operands)
end
