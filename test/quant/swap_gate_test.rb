# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class SwapGateTest < ActiveSupport::TestCase
    test 'SWAP|00> = |00>' do
      circuit = Circuit.new([Qubit[0], Qubit[0]])

      assert_equal [Qubit[0], Qubit[0]], circuit.swap(0, 1).state
    end

    test 'SWAP|01> = |10>' do
      circuit = Circuit.new([Qubit[0], Qubit[1]])

      assert_equal [Qubit[1], Qubit[0]], circuit.swap(0, 1).state
    end

    test 'SWAP|10> = |01>' do
      circuit = Circuit.new([Qubit[1], Qubit[0]])

      assert_equal [Qubit[0], Qubit[1]], circuit.swap(0, 1).state
    end

    test 'SWAP|11> = |11>' do
      circuit = Circuit.new([Qubit[1], Qubit[1]])

      assert_equal [Qubit[1], Qubit[1]], circuit.swap(0, 1).state
    end
  end
end
