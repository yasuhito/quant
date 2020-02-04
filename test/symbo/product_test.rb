# frozen_string_literal: true

require 'test_helper'

require 'symbo/fraction'
require 'symbo/power'
require 'symbo/product'
require 'symbo/sum'

module Symbo
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
        assert_equal UNDEFINED, Product(Fraction(1, 0), 2).simplify
      end

      test 'SPRD-2: x·0 → 0' do
        assert_equal 0, Product(:x, 0).simplify
      end

      test 'SPRD-3: ·2 → 2' do
        assert_equal 2, Product(2).simplify
      end

      test 'SPRD-4-1: a^(-1)·b·a → b' do
        assert_equal :b, Product(Power(:a, -1), :b, :a).simplify
      end

      test 'SPRD-4-2: (c·2·b·c·a) → 2·a·b·c^2' do
        assert_equal Product(2, :a, :b, Power(:c, 2)),
                     Product(:c, 2, :b, :c, :a).simplify
      end

      test 'SPRD-4-3: a^(-1)·a → 1' do
        assert_equal 1, Product(Power(:a, -1), :a).simplify
      end

      test 'SPRDREC-2: (2·a·c·e)·(3·b·d·e) → 6·a·b·c·d·e^2' do
        assert_equal Product(6, :a, :b, :c, :d, Power(:e, 2)),
                     Product(Product(2, :a, :c, :e), Product(3, :b, :d, :e)).simplify
      end

      test 'SPRDREC-3-1 and SPRDREC-1-4: (a·b)·c·b → a·b^2·c' do
        assert_equal Product(:a, Power(:b, 2), :c),
                     Product(Product(:a, :b), :c, :b).simplify
      end

      test '(a·c·e)·(a·c^(-1)·d·f) → a^2·d·e·f' do
        assert_equal Product(Power(:a, 2), :d, :e, :f),
                     Product(Product(:a, :c, :e), Product(:a, Power(:c, -1), :d, :f)).simplify
      end
    end
  end
end
