# frozen_string_literal: true

require 'test_helper'

require 'symbolic/refinement/integer'

module Symbolic
  class IntegerTest < ActiveSupport::TestCase
    using Symbolic::Refinement

    test '#base = Undefined' do
      assert_equal :Undefined, 1.base
    end

    test '#exponent = Undefined' do
      assert_equal :Undefined, 1.exponent
    end

    test '#term = Undefined' do
      assert_equal :Undefined, 1.term
    end

    test '#const = Undefined' do
      assert_equal :Undefined, 1.const
    end
  end
end
