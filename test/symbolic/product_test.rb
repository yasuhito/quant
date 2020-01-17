# frozen_string_literal: true

require 'test_helper'

require 'symbolic/pi'
require 'symbolic/product'
require 'symbolic/sqrt'
require 'symbolic/sum'

module Symbolic
  class ProductTest < ActiveSupport::TestCase
    test '1' do
      result = Product.new(1).simplify

      assert_equal 1, result
    end

    test '1*1' do
      result = Product.new(1, 1).simplify

      assert_equal 1, result
    end

    test '1*2*√3' do
      result = Product.new(1, 2, Sqrt(3)).simplify

      assert_equal '2√3', result.to_s
    end

    test '0*√2' do
      result = Product.new(0, Sqrt(2)).simplify

      assert_equal 0, result
    end

    test '1*√0' do
      result = Product.new(1, Sqrt(0)).simplify

      assert_equal 0, result
    end

    test '1*2*√3*√3' do
      result = Product.new(1, 2, Sqrt(3), Sqrt(3)).simplify

      assert_equal 6, result
    end

    test '2*π' do
      result = 2 * PI

      assert_equal Product.new(2, PI), result
    end
  end
end
