# frozen_string_literal: true

module Symbolic
  # シンボリックな積
  class Product
    def initialize(*elements)
      @elements = elements
    end

    def simplify
      if @elements.size == 1
        @elements[0]
      elsif @elements.any? { |each| each.is_a?(Numeric) && each.zero? }
        0
      end
    end
  end
end

def Prod(*elements) # rubocop:disable Naming/MethodName
  Symbolic::Product.new(*elements).simplify
end
