# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CnotGateTest < ActiveSupport::TestCase
    include Symbo

    test 'CNOT0→1|00> = |00>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal Qubit['00'], circuit.cnot(0 => 1).state
    end

    test 'CNOT0→1|01> = |01>' do
      circuit = Circuit.new(Qubit['01'])

      assert_equal Qubit['01'], circuit.cnot(0 => 1).state
    end

    test 'CNOT0→1|10> = |11>' do
      circuit = Circuit.new(Qubit['10'])

      assert_equal Qubit['11'], circuit.cnot(0 => 1).state
    end

    test 'CNOT0→1|11> = |10>' do
      circuit = Circuit.new(Qubit['11'])

      assert_equal Qubit['10'], circuit.cnot(0 => 1).state
    end

    test 'CNOT0→2|101> = |100>' do
      circuit = Circuit.new(Qubit['101'])

      assert_equal Qubit['100'], circuit.cnot(0 => 2).state
    end
  end
end
