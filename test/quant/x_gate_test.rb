# frozen_string_literal: true

require 'test_helper'
require 'quant/circuit'

module Quant
  class XGateTest < ActiveSupport::TestCase
    test 'X|0> = |1>' do
      circuit = Circuit.new(1)

      assert_equal [Qubit[1]], circuit.x(0).state
    end

    test 'X|1> = |0>' do
      circuit = Circuit.new(Qubit[1])

      assert_equal [Qubit[0]], circuit.x(0).state
    end

    test 'X|+> = |+>' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal [Qubit['+']], circuit.x(0).state
    end

    test 'X|-> = -|->' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal [Qubit['-'] * -1], circuit.x(0).state
    end

    test 'X|i> = i|-i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal [Qubit['-i'] * 1i], circuit.x(0).state
    end

    test 'X|-i> = -i|i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal [Qubit['i'] * -1i], circuit.x(0).state
    end
  end
end
