# frozen_string_literal: true

require 'test_helper'

require 'symbolic/pi'
require 'symbolic/sin'

module Symbolic
  class SinTest < ActiveSupport::TestCase
    test 'Sin(-1) = -Sin(1)' do
      sin = Sin(-1)

      assert_equal(-Sin(1), sin)
    end

    test 'Sin(-1 * 2 * 3) = -Sin(6)' do
      sin = Sin([:*, -1, 2, 3])

      assert_equal(-Sin(6), sin)
    end

    test 'Sin(0) = 0' do
      sin = Sin(0)

      assert_equal 0, sin
    end

    test 'Sin(π) = 0' do
      sin = Sin(Pi)

      assert_equal 0, sin
    end

    test 'Sin(0π/1) = 0' do
      sin = Sin([:*, Rational(0, 1), Pi])

      assert_equal 0, sin
    end

    test 'Sin(π/6) = 1/2' do
      sin = Sin([:*, Rational(1, 6), Pi])

      assert_equal Rational(1, 2), sin
    end

    test 'Sin(π/4) = 1/√2' do
      sin = Sin([:*, Rational(1, 4), Pi])

      assert_equal Rational(1, Sqrt(2)), sin
    end

    test 'Sin(π/3) = √3/2' do
      sin = Sin([:*, Rational(1, 3), Pi])

      assert_equal Rational(Sqrt(3), 2), sin
    end

    test 'Sin(π/2) = 1' do
      sin = Sin([:*, Rational(1, 2), Pi])

      assert_equal 1, sin
    end

    test 'Sin(2π/3) = √3/2' do
      sin = Sin([:*, Rational(2, 3), Pi])

      assert_equal Rational(Sqrt(3), 2), sin
    end

    test 'Sin(3π/4) = 1/√2' do
      sin = Sin([:*, Rational(3, 4), Pi])

      assert_equal Rational(1, Sqrt(2)), sin
    end

    test 'Sin(5π/6) = 1/2' do
      sin = Sin([:*, Rational(5, 6), Pi])

      assert_equal Rational(1, 2), sin
    end

    test 'Sin(1π/1) = 0' do
      sin = Sin([:*, Rational(1, 1), Pi])

      assert_equal(0, sin)
    end

    test 'Sin(7π/6) = -1/2' do
      sin = Sin([:*, Rational(7, 6), Pi])

      assert_equal Rational(-1, 2), sin.simplify
    end

    test 'Sin(5π/4) = -1/√2' do
      sin = Sin([:*, Rational(5, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), sin
    end

    test 'Sin(4π/3) = -√3/2' do
      sin = Sin([:*, Rational(4, 3), Pi])

      assert_equal Rational(-Sqrt(3), 2), sin
    end

    test 'Sin(3π/2) = -1' do
      sin = Sin([:*, Rational(3, 2), Pi])

      assert_equal(-1, sin)
    end

    test 'Sin(5π/3) = -√3/2' do
      sin = Sin([:*, Rational(5, 3), Pi])

      assert_equal Rational(-Sqrt(3), 2), sin
    end

    test 'Sin(7π/4) = -1/√2' do
      sin = Sin([:*, Rational(7, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), sin.simplify
    end

    test 'Sin(11π/6) = -1/2' do
      sin = Sin([:*, Rational(11, 6), Pi])

      assert_equal Rational(-1, 2), sin
    end

    test 'Sin(2π/1) = 0' do
      sin = Sin([:*, Rational(2, 1), Pi])

      assert_equal 0, sin
    end

    test 'Sin(-π/6) = -1/2' do
      sin = Sin([:*, Rational(-1, 6), Pi])

      assert_equal Rational(-1, 2), sin
    end

    test 'Sin(-π/4) = -1/√2' do
      sin = Sin([:*, Rational(-1, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), sin
    end

    test 'Sin(-π/3) = -√3/2' do
      sin = Sin([:*, Rational(-1, 3), Pi])

      assert_equal Rational(-Sqrt(3), 2), sin
    end

    test 'Sin(-π/2) = -1' do
      sin = Sin([:*, Rational(-1, 2), Pi])

      assert_equal(-1, sin)
    end

    test 'Sin(-2π/3) = -√3/2' do
      sin = Sin([:*, Rational(-2, 3), Pi])

      assert_equal Rational(-Sqrt(3), 2), sin
    end

    test 'Sin(-3π/4) = -1/√2' do
      sin = Sin([:*, Rational(-3, 4), Pi])

      assert_equal Rational(-1, Sqrt(2)), sin
    end

    test 'Sin(-5π/6) = -1/2' do
      sin = Sin([:*, Rational(-5, 6), Pi])

      assert_equal Rational(-1, 2), sin
    end

    test 'Sin(-π/1) = 0' do
      sin = Sin([:*, Rational(-1, 1), Pi])

      assert_equal 0, sin
    end
  end
end
