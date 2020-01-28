# frozen_string_literal: true

require 'test_helper'

require 'symbolic/operator'

module Symbolic
  class OperatorTest < ActiveSupport::TestCase
    include Operator

    test 'base(u) = u when u is a symbol' do
      assert_equal :x, base(:x)
    end

    test 'base(u) = u when u is a product' do
      assert_equal %i[* x y], base(%i[* x y])
    end

    test 'base(u) = u when u is a sum' do
      assert_equal %i[+ x y], base(%i[+ x y])
    end

    test 'base(u) = u when u is a factorial' do
      assert_equal %i[! x], base(%i[! x])
    end

    test 'base(u) = u when u is a function' do
      assert_equal %i[f f x], base(%i[f f x])
    end

    test 'base(u) = operand(u, 1) when u is a power' do
      assert_equal :x, base([:^, :x, 2])
    end

    test 'base(u) = Undefined when u is an integer' do
      assert_equal :Undefined, base(1)
    end

    test 'base(u) = Undefined when u is a fraction' do
      assert_equal :Undefined, base([:fraction, 1, 3])
    end
  end
end
