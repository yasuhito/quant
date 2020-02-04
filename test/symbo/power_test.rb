# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class PowerTest
    class OperatorTest < ActiveSupport::TestCase
      test 'x^2.base = x' do
        assert_equal :x, Power(:x, 2).base
      end

      test 'x^2.exponent = 2' do
        assert_equal 2, Power(:x, 2).exponent
      end

      test 'x^2.term = ·x^2' do
        assert_equal Product(Power(:x, 2)), Power(:x, 2).term
      end

      test 'x^2.const = 1' do
        assert_equal 1, Power(:x, 2).const
      end

      test '((1+x)^2).compare((1+x)^3) = true' do
        assert Power(Sum(1, :x), 2).compare(Power(Sum(1, :x), 3))
      end

      test '((1+x)^3).compare((1+y)^2) = true' do
        assert Power(Sum(1, :x), 3).compare(Power(Sum(1, :y), 2))
      end

      test '((1+x)^3).compare(1+y) = true' do
        assert Power(Sum(1, :x), 3).compare(Sum(1, :y))
      end
    end

    class SimplificationTest < ActiveSupport::TestCase
      using Symbo

      test '((1/0)^2).simplify = Undefined' do
        assert_equal UNDEFINED, Power(1/0, 2).simplify
      end

      test '(2^(1/0)).simplify = Undefined' do
        assert_equal UNDEFINED, Power(2, 1/0).simplify
      end

      test '(0^2).simplify = 1' do
        assert_equal 1, Power(0, 2).simplify
      end

      test '(0^(1/2)).simplify = 1' do
        assert_equal 1, Power(0, 1/2).simplify
      end

      test '(0^(-1)).simplify = Undefined' do
        assert_equal UNDEFINED, Power(0, -1).simplify
      end

      test '(1^x).simplify = 1' do
        assert_equal 1, Power(1, :x).simplify
      end

      test '(2^2).simplify = 4' do
        assert_equal 4, Power(2, 2).simplify
      end

      test '(2^0).simplify = 1' do
        assert_equal 1, Power(2, 0).simplify
      end

      test '(2^1).simplify = 2' do
        assert_equal 2, Power(2, 1).simplify
      end

      test '(((x^(1/2))^(1/2))^8).simplify = x^2' do
        assert_equal Power(:x, 2), Power(Power(Power(:x, 1/2), 1/2), 8).simplify
      end

      test '(((x·y)^(1/2)·z^2)^2).simplify = x·y·z^4' do
        assert_equal Product(:x, :y, Power(:z, 4)),
                     Power(Product(Power(Product(:x, :y), 1/2), Power(:z, 2)), 2).simplify
      end
    end
  end
end
