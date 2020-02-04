# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  class Diff < Expression
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
  end
end

def Diff(*operands) # rubocop:disable Naming/MethodName
  Symbo::Diff.new(*operands)
end
