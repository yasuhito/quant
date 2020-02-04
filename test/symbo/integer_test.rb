# frozen_string_literal: true

require 'test_helper'

require 'symbo/integer'

module Symbo
  class IntegerTest < ActiveSupport::TestCase
    using Symbo

    test '#base = Undefined' do
      assert_equal UNDEFINED, 1.base
    end

    test '#exponent = Undefined' do
      assert_equal UNDEFINED, 1.exponent
    end

    test '#term = Undefined' do
      assert_equal UNDEFINED, 1.term
    end

    test '#const = Undefined' do
      assert_equal UNDEFINED, 1.const
    end

    test '2#compare(5/2) = true' do
      assert 2.compare(Fraction(5, 2))
    end
  end
end
