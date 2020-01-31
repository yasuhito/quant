# frozen_string_literal: true

require 'symbolic/expression'

module Symbolic
  class Quot < Expression
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
      false
    end

    def quot?
      true
    end
  end
end

def Quot(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Quot.new(*operands)
end
