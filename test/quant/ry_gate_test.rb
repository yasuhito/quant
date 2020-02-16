# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RyGateTest < ActiveSupport::TestCase
    include Symbo

    test 'Ry|0>' do
      circuit = Circuit.new(1).ry(0, theta: 2 * PI)

      assert_equal [[Cos[PI], Sin[PI]].map(&:simplify)], circuit.state
    end

    test 'Ry|1>' do
      circuit = Circuit.new(1).x(0).ry(0, theta: 2 * PI)

      assert_equal [[-1 * Sin[PI], Cos[PI]].map(&:simplify)], circuit.state
    end
  end
end
