# frozen_string_literal: true

require 'test_helper'

require 'symbo/factorial'

module Symbo
  class FactorialTest < ActiveSupport::TestCase
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Factorial#base # => Factorial' do
        assert_equal Factorial(:x), Factorial(:x).base
      end

      test 'Factorial#exponent # => 1' do
        assert_equal 1, Factorial(:x).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Factorial#term # => Product(Factorial)' do
        assert_equal Product(Factorial(:x)), Factorial(:x).term
      end

      test 'Factorial#const # => 1' do
        assert_equal 1, Factorial(:x).const
      end
    end

    test '(m!).compare(n) = true' do
      assert Factorial(:m).compare(:n)
    end
  end
end
