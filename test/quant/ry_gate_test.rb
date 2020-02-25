# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RyGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Ry(θ)|0> = cos(θ/2)|0> + sin(θ/2)|1>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Cos[:θ/2] * Qubit['0'] + Sin[:θ/2] * Qubit['1'], circuit.ry(0, theta: :θ).state
    end

    test 'Ry(θ)|1> = cos(θ/2)|1> - sin(θ/2)|0>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal Cos[:θ/2] * Qubit['1'] - Sin[:θ/2] * Qubit['0'], circuit.ry(0, theta: :θ).state
    end

    test 'Ry(2π)|0> = cos(π)|0> + sin(π)|1> = -|0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal(-Qubit['0'], circuit.ry(0, theta: 2 * PI).state)
    end

    test 'Ry(2π)|1> = cos(π)|1> - sin(π)|0> = -|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal(-Qubit['1'], circuit.ry(0, theta: 2 * PI).state)
    end

    test 'Ry(2π, 1)|00> = -|00>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal(-Qubit['00'], circuit.ry(1, theta: 2 * PI).state)
    end
  end
end
