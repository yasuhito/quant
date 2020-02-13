# frozen_string_literal: true

module Quant
  class Vector
    def self.[](*elements)
      new(*elements)
    end

    def initialize(*elements)
      @elements = elements
    end

    def to_a
      @elements
    end

    alias to_ary to_a
  end
end
