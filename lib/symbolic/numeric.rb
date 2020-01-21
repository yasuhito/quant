# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/sum'

module Symbolic
  # シンボリックな数
  class Numeric < Base
    def initialize(value)
      @value = value
    end

    def +(other)
      Sum.new(self, other)
    end

    def *(other)
      Product.new(self, other)
    end

    def conj
      Numeric.new(@value.conj)
    end

    def simplify
      @value.is_a?(Base) ? @value.simplify : @value
    end
  end
end
