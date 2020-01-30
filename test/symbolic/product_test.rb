# frozen_string_literal: true

require 'test_helper'

require 'symbolic/fraction'
require 'symbolic/power'
require 'symbolic/product'
require 'symbolic/sum'

module Symbolic
  class ProductTest
    class OperatorTest < ActiveSupport::TestCase
      test '(x * y).base = x * y' do
        assert_equal Product(:x, :y), Product(:x, :y).base
      end

      test '(x * y).exponent = 1' do
        assert_equal 1, Product(:x, :y).exponent
      end

      test '(2 * x * y * z).term = x * y * z' do
        assert_equal Product(:x, :y, :z), Product(2, :x, :y, :z).term
      end

      test '(1/3 * x * y * z).term = x * y * z' do
        assert_equal Product(:x, :y, :z), Product(Fraction(1, 3), :x, :y, :z).term
      end

      test '(x * y * z).term = x * y * z' do
        assert_equal Product(:x, :y, :z), Product(:x, :y, :z).term
      end

      test '(2 * x * y * z).const = 2' do
        assert_equal 2, Product(2, :x, :y, :z).const
      end

      test '(1/3 * x * y * z).const = 1/3' do
        assert_equal Fraction(1, 3), Product(Fraction(1, 3), :x, :y, :z).const
      end

      test '(x * y * z).const = 1' do
        assert_equal 1, Product(:x, :y, :z).const
      end

      test '(a·b).compare(a·c) = true' do
        assert Product(:a, :b).compare(Product(:a, :c))
      end

      test '(a·c·d).compare(b·c·d) = true' do
        assert Product(:a, :c, :d).compare(Product(:b, :c, :d))
      end

      test '(c·d).compare(b·c·d) = true' do
        assert Product(:c, :d).compare(Product(:b, :c, :d))
      end

      test '(a·x^2).compare(x^3) = true' do
        assert Product(:a, Power(:x, 2)).compare(Power(:x, 3))
      end
    end

    class SimplificationTest < ActiveSupport::TestCase
      test 'SPRD-1: (1/0)·2 → Undefined·2 → Undefined' do
        assert_equal :Undefined, Product(Fraction(1, 0), 2).simplify
      end

      test 'SPRD-2: x·0 → 0' do
        assert_equal 0, Product(:x, 0).simplify
      end

      test 'SPRD-3: ·2 → 2' do
        assert_equal 2, Product(2).simplify
      end

      test '(c·2·b·c·a) → 2·a·b·c^2' do
        assert_equal Product(2, :a, :b, Power(:c, 2)), Product(:c, 2, :b, :c, :a).simplify
      end

      test '(2·a·c·e)·(3·b·d·e) → 6·a·b·c·d·e^2' do
        assert_equal Product(6, :a, :b, :c, :d, Power(:e, 2)), Product(Product(2, :a, :c, :e), Product(3, :b, :d, :e)).simplify
      end

      test '(a·b)·b·c → a·b^2·c' do
        Product(Product(:a, :b), :b, :c).simplify
      end
    end
  end
end
