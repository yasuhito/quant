# frozen_string_literal: true

require 'symbolic/expression'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # 三角関数のシンボリック演算
  class TrigonometricFunction
    using Symbolic::Refinement

    attr_reader :x

    def initialize(x)
      @x = x
    end

    def simplify
      self.class.new(@x.simplify)._simplify
    end

    def ==(other)
      return false unless other.is_a?(self.class)

      @x == other.x
    end
  end
end
