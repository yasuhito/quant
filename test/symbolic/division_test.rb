# frozen_string_literal: true

require 'test_helper'

require 'symbolic/division'

module Symbolic
  class DivisionTest < ActiveSupport::TestCase
    test 'Div(1/2, 3) = Div(1 * 2^(-1), 3)' do
      div = Div(Div(1, 2), 3)

      assert_equal [:*, 1, [:^, 2, -1]], div.u
      assert_equal 3, div.v
    end
  end
end
