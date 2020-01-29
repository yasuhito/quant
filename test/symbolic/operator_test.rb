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

    class TermTest < ActiveSupport::TestCase
      include Operator

      test 'term(u) = ·u when u is a symbol' do
        assert_equal %i[* x], term(:x)
      end

      test 'term(u) = ·u when u is a sum' do
        assert_equal [:*, %i[+ x y]], term(%i[+ x y])
      end

      test 'term(u) = ·u when u is a power' do
        assert_equal [:*, [:^, :x, 2]], term([:^, :x, 2])
      end

      test 'term(u) = ·u when u is a factorial' do
        assert_equal [:*, %i[! x]], term(%i[! x])
      end

      test 'term(u) = ·u when u is a function' do
        assert_equal [:*, %i[f f x]], term(%i[f f x])
      end

      test 'term(u) = u2···un when u = u1···un is a product and u1 is constant' do
        assert_equal %i[* x y z], term([:*, 2, :x, :y, :z])
        assert_equal %i[* x y z], term([:*, [:fraction, 1, 3], :x, :y, :z])
      end

      test 'term(u) = u when u = u1···un is a product and u1 is not constant' do
        assert_equal %i[* x y z], term(%i[* x y z])
      end

      test 'term(u) = Undefined when u is an integer' do
        assert_equal :Undefined, term(1)
      end

      test 'term(u) = Undefined when u is a fraction' do
        assert_equal :Undefined, term([:fraction, 1, 3])
      end
    end

    class ConstTest < ActiveSupport::TestCase
      include Operator

      test 'const(u) = 1 when u is a symbol' do
        assert_equal 1, const(:x)
      end

      test 'const(u) = 1 when u is a sum' do
        assert_equal 1, const(%i[+ x y])
      end

      test 'const(u) = 1 when u is a power' do
        assert_equal 1, const([:^, :x, 2])
      end

      test 'const(u) = 1 when u is a factorial' do
        assert_equal 1, const(%i[! x])
      end

      test 'const(u) = 1 when u is a function' do
        assert_equal 1, const(%i[f f x])
      end

      test 'const(u) = u1 when u = u1···un is a product and u1 is constant' do
        assert_equal 2, const([:*, 2, :x, :y, :z])
        assert_equal [:fraction, 1, 3], const([:*, [:fraction, 1, 3], :x, :y, :z])
      end

      test 'const(u) = u1 when u = u1···un is a product and u1 is not constant' do
        assert_equal 1, const(%i[* x y z])
      end

      test 'const(u) = Undefined when u is an integer' do
        assert_equal :Undefined, const(1)
      end

      test 'const(u) = Undefined when u is a fraction' do
        assert_equal :Undefined, const([:fraction, 1, 3])
      end
    end
  end
end
