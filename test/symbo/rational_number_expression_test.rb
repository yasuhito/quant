# frozen_string_literal: true

require 'test_helper'

require 'symbo/diff'
require 'symbo/quot'

module Symbo
  class RationalNumberExpressionTest < ActiveSupport::TestCase
    using Symbo

    test '2/3 + 3/4 → 17/12' do
      assert_equal Fraction(17, 12), Sum(Fraction(2, 3), Fraction(3, 4)).evaluate.simplify_rational_number
    end

    test '(4/2)^3 → 8' do
      assert_equal 8, ((4/2)**3).evaluate.simplify_rational_number
    end

    test '1/(2/4 - 1/2) → Undefined' do
      assert_equal UNDEFINED, Quot(1, Diff(Fraction(2, 4), Fraction(1, 2))).evaluate.simplify_rational_number
    end
  end
end
