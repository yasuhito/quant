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
  end
end
