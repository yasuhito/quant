# frozen_string_literal: true

require 'test_helper'

require 'symbolic/sum'

module Symbolic
  class SumTest < ActiveSupport::TestCase
    test '(x + y)#base = x + y' do
      assert_equal Sum(:x, :y), Sum(:x, :y).base
    end

    test '(x + y)#exponent = 1' do
      assert_equal 1, Sum(:x, :y).exponent
    end

    test '(x + y)#term = ·(x + y)' do
      assert_equal Product(Sum(:x, :y)), Sum(:x, :y).term
    end

    test '(x + y)#const = 1' do
      assert_equal 1, Sum(:x, :y).const
    end

    test '(a + b)#compare(a + c) = true' do
      assert Sum(:a, :b).compare(Sum(:a, :c))
    end

    test '(a + c + d)#compare(b + c + d) = true' do
      assert Sum(:a, :c, :d).compare(Sum(:b, :c, :d))
    end

    test '(c + d)#compare(b + c + d) = true' do
      assert Sum(:c, :d).compare(Sum(:b, :c, :d))
    end

    # test 'Sum(x) = x' do
    #   sum = Sum(:x)

    #   assert_equal :x, sum
    # end

    # test 'Sum() = 0' do
    #   sum = Sum()

    #   assert_equal 0, sum
    # end

    # test 'Sum(x, 0) = x' do
    #   sum = Sum(:x, 0)

    #   assert_equal :x, sum
    # end

    # test 'Sum(0, x) = x' do
    #   sum = Sum(0, :x)

    #   assert_equal :x, sum
    # end

    # test 'Sum(Num1, Num2) = Num1 * Num2' do
    #   sum = Sum(2, 3)

    #   assert_equal 5, sum
    # end

    # test 'Sum(Sum(:a, :b), Sum(:x, :y)) = Sum(:a, :b, :x, :y)' do
    #   sum = Sum(Sum(:a, :b), Sum(:x, :y))

    #   assert_equal %i[a b x y], sum.expressions.sort
    # end
  end
end
