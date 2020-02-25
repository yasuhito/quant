# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class R1GateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'R1(θ)|0> = |0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['0'], circuit.r1(0, theta: :θ).state
    end

    test 'R1(θ)|1> = e^{iθ}|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal E**(1i * :θ) * Qubit['1'], circuit.r1(0, theta: :θ).state
    end

    test 'R1(π)|0> = |0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['0'], circuit.r1(0, theta: PI).state
    end

    test 'R1(π)|1> = e^{iπ}|1> = -|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal(-Qubit['1'], circuit.r1(0, theta: PI).state)
    end

    test 'R1(θ, 1)|01> = e^{iθ}|01>' do
      circuit = Circuit.new(Qubit['01'])

      assert_equal E**(1i * :θ) * Qubit['01'], circuit.r1(1, theta: :θ).state
    end
  end
end
