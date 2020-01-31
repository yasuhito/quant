# frozen_string_literal: true

require 'test_helper'

require 'symbolic/diff'
require 'symbolic/quot'
require 'symbolic/rational_number_expression'

module Symbolic
  class RationalNumberExpressionTest < ActiveSupport::TestCase
    include RationalNumberExpression

    test '2/3 + 3/4 → 17/12' do
      assert_equal Rational(17, 12), simplify_rational_number_expression(Sum(Fraction(2, 3), Fraction(3, 4)))
    end

    test '(4/2)^3 → 8' do
      assert_equal 8, simplify_rational_number_expression(Power(Fraction(4, 2), 3))
    end

    test '1/(2/4 - 1/2) → Undefined' do
      assert_equal UNDEFINED, simplify_rational_number_expression(Quot(1, Diff(Fraction(2, 4), Fraction(1, 2))))
    end
  end
end
