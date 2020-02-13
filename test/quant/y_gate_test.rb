# frozen_string_literal: true

require 'test_helper'
require 'quant/circuit'

module Quant
  class YGateTest < ActiveSupport::TestCase
    test 'Y|0> = i|1>' do
      circuit = Circuit.new(1)

      assert_equal [Qubit[1] * 1i], circuit.y(0).state
    end

    test 'Y|1> = -i|0>' do
      circuit = Circuit.new(Qubit[1])

      assert_equal [Qubit[0] * -1i], circuit.y(0).state
    end

    test 'Y|+> = -i|->' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal [Qubit['-'] * -1i], circuit.y(0).state
    end

    test 'Y|-> = i|+>' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal [Qubit['+'] * 1i], circuit.y(0).state
    end

    test 'Y|i> = |i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal [Qubit['i']], circuit.y(0).state
    end

    test 'Y|-i> = -|-i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal [Qubit['-i'] * -1], circuit.y(0).state
    end
  end
end