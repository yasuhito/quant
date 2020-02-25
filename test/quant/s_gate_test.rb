# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class SGateTest < ActiveSupport::TestCase
    test 'S|0> = |0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['0'], circuit.s(0).state
    end

    test 'S|1> = i|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal 1i * Qubit['1'], circuit.s(0).state
    end

    test 'S|+> = |i>' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal Qubit['i'], circuit.s(0).state
    end

    test 'S|-> = |-i>' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal Qubit['-i'], circuit.s(0).state
    end

    test 'S|i> = |->' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal Qubit['-'], circuit.s(0).state
    end

    test 'S|-i> = |+>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal Qubit['+'], circuit.s(0).state
    end

    test 'S(1)|01> = i|1>' do
      circuit = Circuit.new(Qubit['01'])

      assert_equal 1i * Qubit['01'], circuit.s(1).state
    end
  end
end
