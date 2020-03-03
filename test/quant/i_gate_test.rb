# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class IGateTest < ActiveSupport::TestCase
    include Symbo

    test 'I|0> = |0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['0'], circuit.i(0).state
    end

    test 'I|1> = |1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal Qubit['1'], circuit.i(0).state
    end

    test 'I|+> = |+>' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal Qubit['+'], circuit.i(0).state
    end

    test 'I|-> = |->' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal Qubit['-'], circuit.i(0).state
    end

    test 'I|i> = |i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal Qubit['i'], circuit.i(0).state
    end

    test 'I|-i> = |-i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal Qubit['-i'], circuit.i(0).state
    end

    test 'I(1)|00> = |00' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal Qubit['00'], circuit.i(1).state
    end
  end
end
