# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RxGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Rx(θ)|0> = cos(θ/2)|0> - isin(θ/2)|1>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Cos[:θ/2] * Qubit['0'] - (1i * Sin[:θ/2]) * Qubit['1'], circuit.rx(0, theta: :θ).state
    end

    test 'Rx(θ)|1> = cos(θ/2)|1> - isin(θ/2)|0>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal Cos[:θ/2] * Qubit['1'] - (1i * Sin[:θ/2]) * Qubit['0'], circuit.rx(0, theta: :θ).state
    end

    test 'Rx(2π)|0> = cos(π)|0> - isin(π)|1> = -|0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal(-Qubit['0'], circuit.rx(0, theta: 2 * PI).state)
    end

    test 'Rx(2π)|1> = cos(π)|1> - isin(π)|0> = -|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal(-Qubit['1'], circuit.rx(0, theta: 2 * PI).state)
    end

    test 'Rx(2π, 1)|00> = -|00>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal(-Qubit['00'], circuit.rx(1, theta: 2 * PI).state)
    end
  end
end
