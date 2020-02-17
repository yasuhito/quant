# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class R1GateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'R1(θ)|0> = |0>' do
      circuit = Circuit.new(Qubit[0]).r1(0, theta: :θ)

      assert_equal [[1, 0]], circuit.state
    end

    test 'R1(θ)|1> = e^{iθ}|1>' do
      circuit = Circuit.new(Qubit[1]).r1(0, theta: :θ)

      assert_equal [[0, (E**(1i * :θ)).simplify]], circuit.state
    end

    test 'R1(π)|0> = |0>' do
      circuit = Circuit.new(Qubit[0]).r1(0, theta: PI)

      assert_equal [Qubit[0]], circuit.state
    end

    test 'R1(π)|1> = e^{iπ}|1> = -|1>' do
      circuit = Circuit.new(Qubit[1]).r1(0, theta: PI)

      assert_equal [-Qubit[1]], circuit.state
    end
  end
end
