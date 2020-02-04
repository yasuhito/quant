# frozen_string_literal: true

require 'test_helper'

require 'symbo/product'
require 'symbo/refinement/symbol'

module Symbo
  class SymbolTest < ActiveSupport::TestCase
    using Symbo::Refinement

    test 'x.base = x' do
      assert_equal :x, :x.base
    end

    test 'x.exponent = 1' do
      assert_equal 1, :x.exponent
    end

    test 'x.term = ·x' do
      assert_equal Product(:x), :x.term
    end

    test 'x.const = 1' do
      assert_equal 1, :x.const
    end

    test 'a.compare(b) = true' do
      assert :a.compare(:b)
    end

    test 'vi.compare(v2) = true' do
      assert :v1.compare(:v2)
    end

    test 'x1.compare(xa) = true' do
      assert :x1.compare(:xa)
    end

    test 'x.compare(x^2) = true' do
      assert :x.compare(Power(:x, 2))
    end
  end
end