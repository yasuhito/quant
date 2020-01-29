# frozen_string_literal: true

require 'test_helper'

require 'symbolic/product'
require 'symbolic/refinement/symbol'

module Symbolic
  class SymbolTest < ActiveSupport::TestCase
    using Symbolic::Refinement

    test 'x#base = x' do
      assert_equal :x, :x.base
    end

    test 'x#exponent = 1' do
      assert_equal 1, :x.exponent
    end

    test 'x#term = ·x' do
      assert_equal Product(:x), :x.term
    end

    test 'x#const = 1' do
      assert_equal 1, :x.const
    end

    test 'a.compare(b) = true' do
      assert :a.compare(:b)
    end

    test 'compare(v1, v2) = true' do
      assert :v1.compare(:v2)
    end

    test 'compare(x1, xa) = true' do
      assert :x1.compare(:xa)
    end
  end
end
