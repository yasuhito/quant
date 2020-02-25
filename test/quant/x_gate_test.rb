# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class XGateTest
    class BasicQubitTransitionTest < ActiveSupport::TestCase
      using Symbo

      test 'X|0> = |1>' do
        circuit = Circuit.new(Qubit['0'])

        assert_equal Qubit['1'], circuit.x(0).state
      end

      test 'X|1> = |0>' do
        circuit = Circuit.new(Qubit['1'])

        assert_equal Qubit['0'], circuit.x(0).state
      end

      test 'X|+> = |+>' do
        circuit = Circuit.new(Qubit['+'])

        assert_equal Qubit['+'], circuit.x(0).state
      end

      test 'X|-> = -|->' do
        circuit = Circuit.new(Qubit['-'])

        assert_equal(-Qubit['-'], circuit.x(0).state)
      end

      test 'X|i> = i|-i>' do
        circuit = Circuit.new(Qubit['i'])

        assert_equal 1i * Qubit['-i'], circuit.x(0).state
      end

      test 'X|-i> = -i|i>' do
        circuit = Circuit.new(Qubit['-i'])

        assert_equal (-1i) * Qubit['i'], circuit.x(0).state
      end

      test 'X(1)|00> = |01>' do
        circuit = Circuit.new(Qubit['00'])

        assert_equal Qubit['01'], circuit.x(1).state
      end
    end
  end
end
