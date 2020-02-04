# frozen_string_literal: true

require 'symbo/sum'

module Symbo
  # シンボリックな数
  class Numeric
    def initialize(value)
      @value = value
    end

    def +(other)
      Sum.new(self, other)
    end

    def *(other)
      Product(self, other)
    end

    def conj
      Numeric.new(@value.conj)
    end

    def simplify
      @value.is_a?(Base) ? @value.simplify : @value
    end
  end
end
