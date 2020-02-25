# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class SwapGateTest < ActiveSupport::TestCase
    test 'SWAP(0, 1)|00> = |00>' do
      circuit = Circuit.new(Qubit['00'])

      assert_equal Qubit['00'], circuit.swap(0, 1).state
    end

    test 'SWAP(0, 1)|01> = |10>' do
      circuit = Circuit.new(Qubit['01'])

      assert_equal Qubit['10'], circuit.swap(0, 1).state
    end

    test 'SWAP(0, 1)|10> = |01>' do
      circuit = Circuit.new(Qubit['10'])

      assert_equal Qubit['01'], circuit.swap(0, 1).state
    end

    test 'SWAP(0, 1)|11> = |11>' do
      circuit = Circuit.new(Qubit['11'])

      assert_equal Qubit['11'], circuit.swap(0, 1).state
    end

    test 'SWAP(0, 1)|001> = |100>' do
      circuit = Circuit.new(Qubit['001'])

      assert_equal Qubit['100'], circuit.swap(0, 2).state
    end
  end
end
