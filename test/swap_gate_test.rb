# frozen_string_literal: true

require 'test_helper'
require 'quant/circuit'

class SwapGateTest < ActiveSupport::TestCase
  # test 'SWAP|00> = |00>' do
  #   circuit = Circuit.new([Qubit[0], Qubit[0]])
  #   result = circuit.swap(0, 1)

  #   assert_equal [Qubit[0], Qubit[0]], result.state
  # end

  # test 'SWAP|01> = |10>' do
  #   circuit = Circuit.new([Qubit[0], Qubit[1]])
  #   result = circuit.swap(0, 1)

  #   assert_equal [Qubit[1], Qubit[0]], result.state
  # end

  # test 'SWAP|10> = |01>' do
  #   circuit = Circuit.new([Qubit[1], Qubit[0]])
  #   result = circuit.swap(0, 1)

  #   assert_equal [Qubit[0], Qubit[1]], result.state
  # end

  # test 'SWAP|11> = |11>' do
  #   circuit = Circuit.new([Qubit[1], Qubit[1]])
  #   result = circuit.swap(0, 1)

  #   assert_equal [Qubit[1], Qubit[1]], result.state
  # end
end
