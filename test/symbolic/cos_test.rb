# frozen_string_literal: true

require 'test_helper'

require 'symbolic/cos'

module Symbolic
  class CosTest < ActiveSupport::TestCase
    test 'Cos(0) = 1' do
      cos = Cos(0)

      assert_equal 1, cos
    end

    test 'Cos(π) = 0' do
      cos = Cos(Pi)

      assert_equal 0, cos
    end

    test 'Cos(0π/1) = 1' do
      cos = Cos([:*, Rational(0, 1), Pi])

      assert_equal 1, cos
    end

    test 'Cos(π/6) = √3/2' do
      cos = Cos([:*, Rational(1, 6), Pi])

      assert_equal Rational(Sqrt(3), 2), cos
    end

    test 'Cos(π/4) = 1/√2' do
      cos = Cos([:*, Rational(1, 4), Pi])

      assert_equal Rational(1, Sqrt(2)), cos
    end

    test 'Cos(π/3) = 1/2' do
      cos = Cos([:*, Rational(1, 3), Pi])

      assert_equal Rational(1, 2), cos
    end

    test 'Cos(π/2) = 0' do
      cos = Cos([:*, Rational(1, 2), Pi])

      assert_equal 0, cos
    end

    test 'Cos(2π/3) = -1/2' do
      cos = Cos([:*, Rational(2, 3), Pi])

      assert_equal Rational(-1, 2), cos.simplify
    end

    test 'Cos(3π/4) = -1/√2' do
      cos = Cos([:*, Rational(3, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), cos
    end

    test 'Cos(5π/6) = -√3/2' do
      cos = Cos([:*, Rational(5, 6), Pi])

      assert_equal Rational(-Sqrt(3), 2), cos
    end

    test 'Cos(1π/1) = -1' do
      cos = Cos([:*, Rational(1, 1), Pi])

      assert_equal(-1, cos)
    end

    test 'Cos(7π/6) = -√3/2' do
      cos = Cos([:*, Rational(7, 6), Pi])

      assert_equal Rational(-Sqrt(3), 2), cos
    end

    test 'Cos(5π/4) = -√2/2' do
      cos = Cos([:*, Rational(5, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), cos
    end

    test 'Cos(4π/3) = -1/2' do
      cos = Cos([:*, Rational(4, 3), Pi])

      assert_equal Rational(-1, 2), cos
    end

    test 'Cos(3π/2) = 0' do
      cos = Cos([:*, Rational(3, 2), Pi])

      assert_equal 0, cos
    end

    test 'Cos(5π/3) = 0' do
      cos = Cos([:*, Rational(5, 3), Pi])

      assert_equal Rational(1, 2), cos
    end

    test 'Cos(7π/4) = 1/√2' do
      cos = Cos([:*, Rational(7, 4), Pi])

      assert_equal Rational(1, Sqrt(2)), cos
    end

    test 'Cos(11π/6) = √3/2' do
      cos = Cos([:*, Rational(11, 6), Pi])

      assert_equal Rational(Sqrt(3), 2), cos
    end

    test 'Cos(2π/1) = 1' do
      cos = Cos([:*, Rational(2, 1), Pi])

      assert_equal 1, cos
    end

    test 'Cos(-π/6) = √3/2' do
      cos = Cos([:*, Rational(-1, 6), Pi])

      assert_equal Sqrt(3) / 2, cos
    end

    test 'Cos(-π/4) = 1/√2' do
      cos = Cos([:*, Rational(-1, 4), Pi])

      assert_equal Rational(1, Sqrt(2)), cos
    end

    test 'Cos(-π/3) = 1/2' do
      cos = Cos([:*, Rational(-1, 3), Pi])

      assert_equal Rational(1, 2), cos
    end

    test 'Cos(-π/2) = 0' do
      cos = Cos([:*, Rational(-1, 2), Pi])

      assert_equal 0, cos
    end

    test 'Cos(-2π/3) = -1/2' do
      cos = Cos([:*, Rational(-2, 3), Pi])

      assert_equal Rational(-1, 2), cos
    end

    test 'Cos(-3π/4) = -1/√2' do
      cos = Cos([:*, Rational(-3, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), cos
    end

    test 'Cos(-5π/6) = -√3/2' do
      cos = Cos([:*, Rational(-5, 6), Pi])

      assert_equal Rational(-Sqrt(3), 2), cos
    end

    test 'Cos(-π/1) = -1' do
      cos = Cos([:*, Rational(-1, 1), Pi])

      assert_equal(-1, cos)
    end
  end
end
