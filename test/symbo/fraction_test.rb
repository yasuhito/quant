# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class FractionTest < ActiveSupport::TestCase
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Fraction#base # => UNDEFINED' do
        assert_equal UNDEFINED, (1/3).base
      end

      test 'Fraction#exponent # => UNDEFINED' do
        assert_equal UNDEFINED, (1/3).exponent
      end
    end

    test '(1/3)#term = Undefined' do
      assert_equal UNDEFINED, Fraction(1, 3).term
    end

    test '(1/3)#const = Undefined' do
      assert_equal UNDEFINED, Fraction(1, 3).const
    end
  end
end
