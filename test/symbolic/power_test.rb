# frozen_string_literal: true

require 'test_helper'

require 'symbolic/power'

module Symbolic
  class PowerTest < ActiveSupport::TestCase
    test '0^w = 0' do
      pow = Pow(0, :w)

      assert_equal 0, pow
    end

    test '1^w = 1' do
      pow = Pow(1, :w)

      assert_equal 1, pow
    end

    test 'v^0 = 1' do
      pow = Pow(:v, 0)

      assert_equal 1, pow
    end

    test 'v^1 = v' do
      pow = Pow(:v, 1)

      assert_equal :v, pow
    end

    test '2^3 = 8' do
      pow = Pow(2, 3)

      assert_equal 2**3, pow
    end

    test '(r^s)^Int = r^(s*Int)' do
      pow = Pow(Pow(:r, :s), 2)

      assert_equal :r, pow.v
      assert_equal [:*, :s, 2], pow.w
    end

    test '(x*y*z)^Int = x^Int * y^Int * z^Int' do
      pow = Pow(%i[* x y z], 2)

      assert_equal [:*, Pow(:x, 2), Pow(:y, 2), Pow(:z, 2)], pow
    end
  end
end
