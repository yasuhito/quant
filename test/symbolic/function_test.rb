# frozen_string_literal: true

require 'test_helper'

require 'symbolic/function'

module Symbolic
  class FunctionTest < ActiveSupport::TestCase
    test 'f(x)#base = f(x)' do
      assert_equal Function(:f, :x), Function(:f, :x).base
    end

    test 'f(x)#exponent = 1' do
      assert_equal 1, Function(:f, :x).exponent
    end

    test 'f(x)#term = ·f(x)' do
      assert_equal Product(Function(:f, :x)), Function(:f, :x).term
    end

    test 'f(x)#const = 1' do
      assert_equal 1, Function(:f, :x).const
    end
  end
end
