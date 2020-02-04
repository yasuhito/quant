# frozen_string_literal: true

require 'symbo/expression'

module Symbo
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
  Symbo::Quot.new(*operands)
end
