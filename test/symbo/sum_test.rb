# frozen_string_literal: true

require 'test_helper'

require 'symbo/fraction'
require 'symbo/power'
require 'symbo/sum'

module Symbo
  class SumTest
    class OperatorTest < ActiveSupport::TestCase
      test '(x + y).base = x + y' do
        assert_equal Sum(:x, :y), Sum(:x, :y).base
      end

      test '(x + y).exponent = 1' do
        assert_equal 1, Sum(:x, :y).exponent
      end

      test '(x + y).term = ·(x + y)' do
        assert_equal Product(Sum(:x, :y)), Sum(:x, :y).term
      end

      test '(x + y).const = 1' do
        assert_equal 1, Sum(:x, :y).const
      end

      test '(a + b).compare(a + c) = true' do
        assert Sum(:a, :b).compare(Sum(:a, :c))
      end

      test '(a + c + d).compare(b + c + d) = true' do
        assert Sum(:a, :c, :d).compare(Sum(:b, :c, :d))
      end

      test '(c + d).compare(b + c + d) = true' do
        assert Sum(:c, :d).compare(Sum(:b, :c, :d))
      end

      test '(1 + x).compare(y) = true' do
        assert Sum(1, :x).compare(:y)
      end
    end

    class SimplificationTest < ActiveSupport::TestCase
      test '1/0 + 2 → Undefined + 2 → Undefined' do
        assert_equal UNDEFINED, Sum(Fraction(1, 0), 2).simplify
      end

      test '+2 → 2' do
        assert_equal 2, Sum(2).simplify
      end

      test '1 + 1 → 2' do
        assert_equal 2, Sum(1, 1).simplify
      end

      test 'a + b - a → b' do
        assert_equal :b, Sum(:a, :b, Product(-1, :a)).simplify
      end

      test 'c + 2 + b + c + a → 2 + a + b + 2c' do
        assert_equal Sum(2, :a, :b, Product(2, :c)),
                     Sum(:c, 2, :b, :c, :a).simplify
      end

      test '(2 + a + c + e) + (3 + b + d + e) → 6 + a + b + c + d + 2e' do
        assert_equal Sum(5, :a, :b, :c, :d, Product(2, :e)),
                     Sum(Sum(2, :a, :c, :e), Sum(3, :b, :d, :e)).simplify
      end

      test '(a + b) + c + b → a + 2b + c' do
        assert_equal Sum(:a, Product(2, :b), :c), Sum(Sum(:a, :b), :c, :b).simplify
      end

      test '(a + c + e) + (a - c + d + f) → 2a + d + e + f' do
        assert_equal Sum(Product(2, :a), :d, :e, :f),
                     Sum(Sum(:a, :c, :e), Sum(:a, Product(-1, :c), :d, :f)).simplify
      end
    end
  end
end
