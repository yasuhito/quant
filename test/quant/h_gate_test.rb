# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class HGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'H|0> = |+>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['+'], circuit.h(0).state
    end

    test 'H|1> = |->' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal Qubit['-'], circuit.h(0).state
    end

    test 'H|+> = |0>' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal Qubit['0'], circuit.h(0).state
    end

    test 'H|-> = |1>' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal Qubit['1'], circuit.h(0).state
    end

    test 'H|i> = e^{iπ/4}|-i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal (E**(1i * PI/4) * Qubit['-i']).state, circuit.h(0).state
    end

    test 'H|-i> = e^{-iπ/4}|i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal (E**(-1i * PI/4) * Qubit['i']).state, circuit.h(0).state
    end

    test 'H(1)|00> = 1/√2|00> + 1/√2|01>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal (1/√(2) * Qubit['00'] + 1/√(2) * Qubit['01']), circuit.h(1).state
    end
  end
end
