# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class IGateTest < ActiveSupport::TestCase
    test 'I|0> = |0>' do
      circuit = Circuit.new(1)
      state = circuit.i(0).state

      assert_equal [Qubit[0]], state
    end

    test 'I|1> = |1>' do
      circuit = Circuit.new(Qubit[1])
      state = circuit.i(0).state

      assert_equal [Qubit[1]], state
    end

    test 'I|+> = |+>' do
      circuit = Circuit.new(Qubit['+'])
      state = circuit.i(0).state

      assert_equal [Qubit['+']], state
    end

    test 'I|-> = |->' do
      circuit = Circuit.new(Qubit['-'])
      state = circuit.i(0).state

      assert_equal [Qubit['-']], state
    end

    test 'I|i> = |i>' do
      circuit = Circuit.new(Qubit['i'])
      state = circuit.i(0).state

      assert_equal [Qubit['i']], state
    end

    test 'I|-i> = |-i>' do
      circuit = Circuit.new(Qubit['-i'])
      state = circuit.i(0).state

      assert_equal [Qubit['-i']], state
    end
  end
end
