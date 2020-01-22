# frozen_string_literal: true

require 'test_helper'

require 'symbolic/product'

module Symbolic
  class ProductTest < ActiveSupport::TestCase
    test 'Prod(x) = x' do
      prod = Prod(:x)

      assert_equal :x, prod
    end

    test 'Prod(x, y) = Prod(x, y)' do
      prod = Prod(:x, :y)

      assert_equal %i[y x], prod.expressions
    end

    test 'Prod(a1, a2, ..., 0, ...an) = 0' do
      prod = Prod(:x, :y, :z, 0)

      assert_equal 0, prod
    end

    test 'Prod(Num1, Num2) = Num1 * Num2' do
      prod = Prod(2, 3)

      assert_equal 6, prod
    end

    test 'Prod(1, x) = x' do
      prod = Prod(1, :x)

      assert_equal :x, prod
    end

    test 'Prod(x, 1) = x' do
      prod = Prod(:x, 1)

      assert_equal :x, prod
    end

    test 'Prod(Prod(:a, :b), Prod(:x, :y)) = Prod(:a, :b, :x, :y)' do
      prod = Prod(Prod(:a, :b), Prod(:x, :y))

      assert_equal %i[a b x y], prod.expressions.sort
    end
  end
end
