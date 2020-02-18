# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RzGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Rz(θ)|0> = e^{-iθ/2}|0>' do
      circuit = Circuit.new(Qubit['0']).rz(0, theta: :θ)

      assert_equal [(E**(-1i * :θ/2)) * Qubit['0']], circuit.state
    end

    test 'Rz(θ)|1> = e^{iθ/2}|1>' do
      circuit = Circuit.new(Qubit['1']).rz(0, theta: :θ)

      assert_equal [(E**(1i * :θ/2)) * Qubit['1']], circuit.state
    end

    test 'Rz(2π)|0> = e^{-iπ}|0> = -|0>' do
      circuit = Circuit.new(Qubit['0']).rz(0, theta: 2 * PI)

      assert_equal [-Qubit['0']], circuit.state
    end

    test 'Rz(2π)|1> = e^{iπ}|1> = -|1>' do
      circuit = Circuit.new(Qubit['1']).rz(0, theta: 2 * PI)

      assert_equal [-Qubit['1']], circuit.state
    end
  end
end
