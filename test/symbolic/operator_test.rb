# frozen_string_literal: true

require 'test_helper'

require 'symbolic/factorial'
require 'symbolic/fraction'
require 'symbolic/function'
require 'symbolic/operator'
require 'symbolic/power'
require 'symbolic/product'
require 'symbolic/sum'

module Symbolic
  module Operator
    class CompareTest < ActiveSupport::TestCase
      include Operator

      test 'compare(2, 5/2) = true' do
        assert compare(2, Fraction(5, 2))
      end

      test 'compare(a, b) = true' do
        assert compare(:a, :b)
      end

      test 'compare(v1, v2) = true' do
        assert compare(:v1, :v2)
      end

      test 'compare(x1, xa) = true' do
        assert compare(:x1, :xa)
      end

      test 'compare(a + b, a + c) = true' do
        assert compare(Sum(:a, :b), Sum(:a, :c))
      end

      test 'compare(a + c + d, b + c + d) = true' do
        assert compare(Sum(:a, :c, :d), Sum(:b, :c, :d))
      end

      test 'compare(c + d, b + c + d) = true' do
        assert compare(Sum(:c, :d), Sum(:b, :c, :d))
      end

      test 'compare(a·b, a·c) = true' do
        assert compare(Product(:a, :b), Product(:a, :c))
      end

      test 'compare(a·c·d, b·c·d) = true' do
        assert compare(Product(:a, :c, :d), Product(:b, :c, :d))
      end

      test 'compare(c·d, b·c·d) = true' do
        assert compare(Product(:c, :d), Product(:b, :c, :d))
      end

      test 'compare((1+x)^2, (1+x)^3) = true' do
        assert compare(Power(Sum(1, :x), 2), Power(Sum(1, :x), 3))
      end

      test 'compare((1+x)^3, (1+y)^2) = true' do
        assert compare(Power(Sum(1, :x), 3), Power(Sum(1, :y), 2))
      end
    end
  end
end
