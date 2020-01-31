# frozen_string_literal: true

require 'symbolic/rational_number_expression'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  UNDEFINED = :undefined

  # General expression interface
  class Expression
    using Symbolic::Refinement

    include RationalNumberExpression

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      self.class.new(*@operands.map(&:simplify))._simplify
    end

    def base
      raise NotImplementedError
    end

    def exponent
      raise NotImplementedError
    end

    def term
      raise NotImplementedError
    end

    def const
      raise NotImplementedError
    end

    def compare(_v)
      raise NotImplementedError
    end

    def length
      @operands.length
    end

    def [](n)
      @operands[n]
    end

    protected

    def _simplify
      raise NotImplementedError
    end
  end
end
