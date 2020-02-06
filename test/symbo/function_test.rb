# frozen_string_literal: true

require 'test_helper'

require 'symbo/function'
require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  class FunctionTest < ActiveSupport::TestCase
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Function#base # => Function' do
        assert_equal Function(:f, :x), Function(:f, :x).base
      end

      test 'Function#exponent # => 1' do
        assert_equal 1, Function(:f, :x).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Function#term = Product(Function)' do
        assert_equal Product(Function(:f, :x)), Function(:f, :x).term
      end

      test 'Function#const = 1' do
        assert_equal 1, Function(:f, :x).const
      end
    end

    test 'f(x).compare(g(x)) = true' do
      assert Function(:f, :x).compare(Function(:g, :x))
    end

    test 'f(x).compare(f(y)) = true' do
      assert Function(:f, :x).compare(Function(:f, :y))
    end

    test 'g(x).compare(g(x, y)) = true' do
      assert Function(:g, :x).compare(Function(:g, :x, :y))
    end

    test 'x.compare(x(t)) = true' do
      assert :x.compare(Function(:x, :t))
    end

    test 'x.compare(y(t)) = true' do
      assert :x.compare(Function(:y, :t))
    end
  end
end
