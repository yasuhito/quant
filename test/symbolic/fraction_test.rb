# frozen_string_literal: true

require 'test_helper'

require 'symbolic/fraction'

module Symbolic
  class FractionTest < ActiveSupport::TestCase
    test '(1/3)#base = Undefined' do
      assert_equal :Undefined, Fraction(1, 3).base
    end

    test '(1/3)#exponent = Undefined' do
      assert_equal :Undefined, Fraction(1, 3).exponent
    end

    test '(1/3)#term = Undefined' do
      assert_equal :Undefined, Fraction(1, 3).term
    end

    test '(1/3)#const = Undefined' do
      assert_equal :Undefined, Fraction(1, 3).const
    end
  end
end
