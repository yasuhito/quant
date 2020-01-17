# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/sum'

# 整数のシンボリック演算
module Symbolic
  refine Integer do
    # def +(other)
    #   p other
    # end

    def /(other)
      Symbolic::Rational.new(self, other)
    end
  end
end

# Matrix の中でなぜか refine した Integer のメソッドが呼び出されないので、
# とりあえずモンキーパッチを当てる
class Integer
  alias original_plus +
  alias original_multiply *

  def +(other)
    if other.is_a?(Symbolic::Base)
      Symbolic::Sum.new(self, other)
    else
      original_plus other
    end
  end

  def *(other)
    if other.is_a?(Symbolic::Base)
      Symbolic::Product.new(self, other)
    else
      original_multiply other
    end
  end

  def simplify
    self
  end
end
