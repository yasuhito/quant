# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class HTest < ActiveSupport::TestCase
  # include Symbolic

  # test 'H|0> = |+>' do
  #   circuit = Circuit.new(1)
  #   result = circuit.h(0)

  #   assert_equal [Qubit['+']], result.state
  # end

  # test 'H|1> = |->' do
  #   circuit = Circuit.new(Qubit[1])
  #   result = circuit.h(0)

  #   assert_equal [Qubit['-']], result.state
  # end

  # test 'H|+> = |0>' do
  #   circuit = Circuit.new(Qubit['+'])
  #   result = circuit.h(0)

  #   assert_equal [Qubit[0]], result.state
  # end

  # test 'H|-> = |1>' do
  #   circuit = Circuit.new(Qubit['-'])
  #   result = circuit.h(0)

  #   assert_equal [Qubit[1]], result.state
  # end

  # test 'H|i> = e^{iπ/4}|-i>' do
  #   circuit = Circuit.new(Qubit['i'])
  #   result = circuit.h(0)

  #   assert_equal [Qubit['-i'] * E**(1i * PI / 4)], result.state
  # end

  # test 'H|-i> = e^{-iπ/4}|i>' do
  #   skip '計算をシンボリックにする'

  #   circuit = Circuit.new(Qubit['-i'])
  #   result = circuit.h(0)

  #   assert_equal [Qubit['i'] * E**(-1i * PI / 4)], result.state
  # end
end
