# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class FractionTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Fraction#base # => UNDEFINED' do
        assert_equal UNDEFINED, (1/3).base
      end

      test 'Fraction#exponent # => UNDEFINED' do
        assert_equal UNDEFINED, (1/3).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Fraction#term # => UNDEFINED' do
        assert_equal UNDEFINED, (1/3).term
      end

      test 'Fraction#const = UNDEFINED' do
        assert_equal UNDEFINED, (1/3).const
      end
    end
  end
end
