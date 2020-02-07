# frozen_string_literal: true

require 'symbo/function'

module Symbo
  # 三角関数のシンボリック演算
  class TrigonometricFunction < Function
    using Symbo

    def x
      @operands[0]
    end

    def simplify
      self.class.new(x.simplify)._simplify
    end

    def ==(other)
      return false unless other.is_a?(self.class)

      x == other.x
    end
  end
end
