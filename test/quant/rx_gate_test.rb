# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RxGateTest < ActiveSupport::TestCase
    include Symbo

    test 'Rx|0>' do
      circuit = Circuit.new(1).rx(0, theta: 2 * PI)

      assert_equal [[Cos[PI], -1i * Sin(PI)].map(&:simplify)], circuit.state
    end

    test 'Rx|1>' do
      circuit = Circuit.new(1).x(0).rx(0, theta: 2 * PI)

      assert_equal [[-1i * Sin(PI), Cos[PI]].map(&:simplify)], circuit.state
    end
  end
end
