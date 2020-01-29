# frozen_string_literal: true

require 'test_helper'

require 'symbolic/power'

module Symbolic
  class PowerTest < ActiveSupport::TestCase
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

    # test '0^w = 0' do
    #   pow = Power(0, :w)

    #   assert_equal 0, pow
    # end

    # test '1^w = 1' do
    #   pow = Power(1, :w)

    #   assert_equal 1, pow
    # end

    # test 'v^0 = 1' do
    #   pow = Power(:v, 0)

    #   assert_equal 1, pow
    # end

    # test 'v^1 = v' do
    #   pow = Power(:v, 1)

    #   assert_equal :v, pow
    # end

    # test '2^3 = 8' do
    #   pow = Power(2, 3)

    #   assert_equal 2**3, pow
    # end

    # test '(r^s)^Int = r^(s*Int)' do
    #   pow = Power(Power(:r, :s), 2)

    #   assert_equal :r, pow.v
    #   assert_equal [:*, :s, 2], pow.w
    # end

    # test '(x*y*z)^Int = x^Int * y^Int * z^Int' do
    #   pow = Power(%i[* x y z], 2)

    #   assert_equal [:*, Power(:x, 2), Power(:y, 2), Power(:z, 2)], pow
    # end
  end
end
