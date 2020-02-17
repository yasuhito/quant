# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # Symbolic difference
  class Diff < Expression
    def self.[](*operands)
      new(*operands)
    end

    def integer?
      false
    end

    def fraction?
      false
    end

    def sum?
      false
    end

    def product?
      false
    end

    def diff?
      true
    end

    def evaluate
      v = @operands[0].evaluate

      if length == 1
        if v == UNDEFINED
          UNDEFINED
        else
          Product(-1, v).evaluate
        end
      elsif length == 2
        w = @operands[1].evaluate

        if v == UNDEFINED || w == UNDEFINED
          UNDEFINED
        else
          v.rational - w.rational
        end
      end
    end
  end
end
