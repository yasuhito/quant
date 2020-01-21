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
      else
        simplify_rec_result = simplify_rec(*@elements)
        if simplify_rec_result.size == 1
          simplify_rec_result[0]
        end
      end
    end

    private

    def simplify_rec(*elements)
      if elements.size == 2 && elements[0].is_a?(Numeric) && elements[1].is_a?(Numeric)
        list_or_null_if_1 elements[0] * elements[1]
      elsif elements.size == 2 && elements[0] == 1
        [elements[1]]
      elsif elements.size == 2 && elements[1] == 1
        [elements[0]]
      end
    end

    def list_or_null_if_1(x)
      if x == 1
        []
      else
        [x]
      end
    end
  end
end

def Prod(*elements) # rubocop:disable Naming/MethodName
  Symbolic::Product.new(*elements).simplify
end
