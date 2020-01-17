# frozen_string_literal: true

require 'test_helper'

require 'symbolic/numeric'

class NumericTest < ActiveSupport::TestCase
  test '1 + 1' do
    result = (Symbolic::Numeric.new(1) + Symbolic::Numeric.new(1)).simplify

    assert_equal 2, result
  end

  test '3 * 3' do
    result = (Symbolic::Numeric.new(3) * Symbolic::Numeric.new(3)).simplify

    assert_equal 9, result
  end
end
