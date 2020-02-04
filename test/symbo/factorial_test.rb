# frozen_string_literal: true

require 'test_helper'

require 'symbo/factorial'

module Symbo
  class FactorialTest < ActiveSupport::TestCase
    test 'x!#base = x!' do
      assert_equal Factorial(:x), Factorial(:x).base
    end

    test 'x!#exponent = 1' do
      assert_equal 1, Factorial(:x).exponent
    end

    test 'x!#term = ·x!' do
      assert_equal Product(Factorial(:x)), Factorial(:x).term
    end

    test 'x!#const = 1' do
      assert_equal 1, Factorial(:x).const
    end

    test '(m!).compare(n) = true' do
      assert Factorial(:m).compare(:n)
    end
  end
end
