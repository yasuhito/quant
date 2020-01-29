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

    test 'f(x)#compare(g(x)) = true' do
      assert Function(:f, :x).compare(Function(:g, :x))
    end

    test 'f(x)#compare(f(y)) = true' do
      assert Function(:f, :x).compare(Function(:f, :y))
    end

    test 'g(x)#compare(g(x, y)) = true' do
      assert Function(:g, :x).compare(Function(:g, :x, :y))
    end
  end
end
