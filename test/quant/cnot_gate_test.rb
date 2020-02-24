# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CnotGateTest < ActiveSupport::TestCase
    test 'CNOT|00> = |00>' do
      circuit = Circuit.new(Qubit['0'], Qubit['0'])

      assert_equal [Qubit['0'], Qubit['0']], circuit.cnot(1, control: 0).state
    end

    test 'CNOT|01> = |01>' do
      circuit = Circuit.new(Qubit['0'], Qubit['1'])

      assert_equal [Qubit['0'], Qubit['1']], circuit.cnot(1, control: 0).state
    end

    test 'CNOT|10> = |11>' do
      circuit = Circuit.new(Qubit['1'], Qubit['0'])

      assert_equal [Qubit['1'], Qubit['1']], circuit.cnot(1, control: 0).state
    end

    test 'CNOT|11> = |10>' do
      circuit = Circuit.new(Qubit['1'], Qubit['1'])

      assert_equal [Qubit['1'], Qubit['0']], circuit.cnot(1, control: 0).state
    end
  end
end
