# frozen_string_literal: true

require 'test_helper'

require 'symbolic/product'

module Symbolic
  class ProductTest < ActiveSupport::TestCase
    test 'Prod(x) = x' do
      prod = Prod(:x)

      assert_equal :x, prod
    end

    test 'Prod(a1, a2, ..., 0, ...an) = 0' do
      prod = Prod(:x, :y, :z, 0)

      assert_equal 0, prod
    end
  end
end
