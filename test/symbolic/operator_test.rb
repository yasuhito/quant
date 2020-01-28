# frozen_string_literal: true

require 'test_helper'

require 'symbolic/operator'

module Symbolic
  module Operator
    class BaseTest < ActiveSupport::TestCase
      include Operator

      test 'base(u) = u when u is a symbol' do
        assert_equal :x, base(:x)
      end

      test 'base(u) = u when u is a product' do
        assert_equal %i[* x y], base(%i[* x y])
      end

      test 'base(u) = u when u is a sum' do
        assert_equal %i[+ x y], base(%i[+ x y])
      end

      test 'base(u) = u when u is a factorial' do
        assert_equal %i[! x], base(%i[! x])
      end

      test 'base(u) = u when u is a function' do
        assert_equal %i[f f x], base(%i[f f x])
      end

      test 'base(u) = operand(u, 1) when u is a power' do
        assert_equal :x, base([:^, :x, 2])
      end

      test 'base(u) = Undefined when u is an integer' do
        assert_equal :Undefined, base(1)
      end

      test 'base(u) = Undefined when u is a fraction' do
        assert_equal :Undefined, base([:fraction, 1, 3])
      end
    end

    class ExponentTest < ActiveSupport::TestCase
      include Operator

      test 'exponent(u) = 1 when u is a symbol' do
        assert_equal 1, exponent(:x)
      end

      test 'exponent(u) = 1 when u is a product' do
        assert_equal 1, exponent(%i[* x y])
      end

      test 'exponent(u) = 1 when u is a sum' do
        assert_equal 1, exponent(%i[+ x y])
      end

      test 'exponent(u) = 1 when u is a factorial' do
        assert_equal 1, exponent(%i[! x])
      end

      test 'exponent(u) = 1 when u is a function' do
        assert_equal 1, exponent(%i[f f x])
      end

      test 'exponent(u) = operand(u, 2) when u is a power' do
        assert_equal 2, exponent([:^, :x, 2])
      end

      test 'exponent(u) = Undefined when u is an integer' do
        assert_equal :Undefined, exponent(1)
      end

      test 'exponent(u) = Undefined when u is a fraction' do
        assert_equal :Undefined, exponent([:fraction, 1, 3])
      end
    end
  end
end
