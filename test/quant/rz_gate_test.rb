# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RzGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Rz(θ)|0> = e^{-iθ/2}|0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal (E**(-1i * :θ/2)) * Qubit['0'], circuit.rz(0, theta: :θ).state
    end

    test 'Rz(θ)|1> = e^{iθ/2}|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal (E**(1i * :θ/2)) * Qubit['1'], circuit.rz(0, theta: :θ).state
    end

    test 'Rz(2π)|0> = e^{-iπ}|0> = -|0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal(-Qubit['0'], circuit.rz(0, theta: 2 * PI).state)
    end

    test 'Rz(2π)|1> = e^{iπ}|1> = -|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal(-Qubit['1'], circuit.rz(0, theta: 2 * PI).state)
    end

    test 'Rz(θ, 1)|00> = e^{-iθ/2}|00>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal (E**(-1i * :θ/2)) * Qubit['00'], circuit.rz(1, theta: :θ).state
    end
  end
end
