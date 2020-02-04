# frozen_string_literal: true

require 'test_helper'

require 'symbolic'

module Symbolic
  class CosTest < ActiveSupport::TestCase
    using Symbolic::Refinement

    test 'Cos(-1) → Cos(1)' do
      assert_equal Cos(1), Cos(-1).simplify
    end

    test 'Cos(-1 * 2 * 3) → Cos(6)' do
      assert_equal Cos(6), Cos(Product(-1, 2, 3)).simplify
    end

    test 'Cos(0) → 1' do
      assert_equal 1, Cos(0).simplify
    end

    test 'Cos(0π/1) → 1' do
      assert_equal 1, Cos(Product(0 / 1, PI)).simplify
    end

    test 'Cos(π/6) → √3/2' do
      assert_equal Fraction(Sqrt(3), 2), Cos(Product(1 / 6, PI)).simplify
    end

    test 'Cos(π/4) → 1/√2' do
      assert_equal 1 / Sqrt(2), Cos(Product(1 / 4, PI)).simplify
    end

    test 'Cos(π/3) → 1/2' do
      assert_equal 1 / 2, Cos(Product(1 / 3, PI)).simplify
    end

    test 'Cos(π/2) → 0' do
      assert_equal 0, Cos(Product(1 / 2, PI)).simplify
    end

    test 'Cos(2π/3) → -1/2' do
      assert_equal (-1 / 2), Cos(Product(2 / 3, PI)).simplify
    end

    test 'Cos(3π/4) → -1/√2' do
      assert_equal (-1 / Sqrt(2)), Cos(Product(3 / 4, PI)).simplify
    end

    test 'Cos(5π/6) → -√3/2' do
      assert_equal Product(-1, Fraction(Sqrt(3), 2)), Cos(Product(5 / 6, PI)).simplify
    end

    test 'Cos(1π/1) → -1' do
      assert_equal(-1, Cos(Product(1 / 1, PI)).simplify)
    end

    test 'Cos(π) → -1' do
      assert_equal(-1, Cos(PI).simplify)
    end

    test 'Cos(7π/6) → -√3/2' do
      assert_equal Product(-1, Fraction(Sqrt(3), 2)), Cos(Product(7 / 6, PI)).simplify
    end

    test 'Cos(5π/4) → -1/√2' do
      assert_equal (-1 / Sqrt(2)), Cos(Product(5 / 4, PI)).simplify
    end

    test 'Cos(4π/3) → -1/2' do
      assert_equal Fraction(-1, 2), Cos(Product(4 / 3, PI)).simplify
    end

    test 'Cos(3π/2) → 0' do
      assert_equal 0, Cos(Product(3 / 2, PI)).simplify
    end

    test 'Cos(5π/3) → 1/2' do
      assert_equal 1 / 2, Cos(Product(5 / 3, PI)).simplify
    end

    test 'Cos(7π/4) → 1/√2' do
      assert_equal 1 / Sqrt(2), Cos(Product(7 / 4, PI)).simplify
    end

    test 'Cos(11π/6) → √3/2' do
      assert_equal Fraction(Sqrt(3), 2), Cos(Product(11 / 6, PI)).simplify
    end

    test 'Cos(2π/1) → 1' do
      assert_equal 1, Cos(Product(2 / 1, PI)).simplify
    end

    test 'Cos(2π) → 1' do
      assert_equal 1, Cos(Product(2, PI)).simplify
    end

    test 'Cos(-π/6) → √3/2' do
      assert_equal Fraction(Sqrt(3), 2), Cos(Product(-1, Product(1 / 6, PI))).simplify
    end

    test 'Cos(-π/4) → 1/√2' do
      assert_equal 1 / Sqrt(2), Cos(Product(-1, Product(1 / 4, PI))).simplify
    end

    test 'Cos(-π/3) → 1/2' do
      assert_equal 1 / 2, Cos(Product(-1, Product(1 / 3, PI))).simplify
    end

    test 'Cos(-π/2) → 0' do
      assert_equal 0, Cos(Product(-1, Product(1 / 2, PI))).simplify
    end

    test 'Cos(-2π/3) → -1/2' do
      assert_equal (-1 / 2), Cos(Product(-1, Product(2 / 3, PI))).simplify
    end

    test 'Cos(-3π/4) → -1/√2' do
      assert_equal (-1 / Sqrt(2)), Cos(Product(-1, Product(3 / 4, PI))).simplify
    end

    test 'Cos(-5π/6) → -√3/2' do
      assert_equal Product(-1, Fraction(Sqrt(3), 2)), Cos(Product(-1, Product(5 / 6, PI))).simplify
    end

    test 'Cos(-π/1) → -1' do
      assert_equal(-1, Cos(Product((-1 / 1), PI)).simplify)
    end

    test 'Cos(-π) → -1' do
      assert_equal(-1, Cos(Product(-1, PI)).simplify)
    end
  end
end
