# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  UNDEFINED = :undefined

  # General expression interface
  class Expression
    using Symbo

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

    def constant?
      false
    end

    def product?
      false
    end

    def integer?
      false
    end

    def zero?
      false
    end

    protected

    def _simplify
      raise NotImplementedError
    end
  end
end
