# frozen_string_literal: true

require 'test_helper'

require 'symbolic/product'

module Symbolic
  class ProductTest < ActiveSupport::TestCase
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

    # test 'Product(x) = x' do
    #   prod = Product(:x)

    #   assert_equal :x, prod
    # end

    # test 'Product(x, y) = Product(x, y)' do
    #   prod = Product(:x, :y)

    #   assert_equal %i[y x], prod.expressions
    # end

    # test 'Product(a1, a2, ..., 0, ...an) = 0' do
    #   prod = Product(:x, :y, :z, 0)

    #   assert_equal 0, prod
    # end

    # test 'Product(Num1, Num2) = Num1 * Num2' do
    #   prod = Product(2, 3)

    #   assert_equal 6, prod
    # end

    # test 'Product(1, x) = x' do
    #   prod = Product(1, :x)

    #   assert_equal :x, prod
    # end

    # test 'Product(x, 1) = x' do
    #   prod = Product(:x, 1)

    #   assert_equal :x, prod
    # end

    # test 'Product(Product(:a, :b), Product(:x, :y)) = Product(:a, :b, :x, :y)' do
    #   prod = Product(Product(:a, :b), Product(:x, :y))

    #   assert_equal %i[a b x y], prod.expressions.sort
    # end
  end
end
