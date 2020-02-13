# frozen_string_literal: true

require 'test_helper'
require 'quant/circuit'

module Quant
  class HGateTest < ActiveSupport::TestCase
    include Symbo

    test 'H|0> = |+>' do
      circuit = Circuit.new(1)

      assert_equal [Qubit['+']], circuit.h(0).state
    end

    test 'H|1> = |->' do
      circuit = Circuit.new(Qubit[1])

      assert_equal [Qubit['-']], circuit.h(0).state
    end

    test 'H|+> = |0>' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal [Qubit[0]], circuit.h(0).state
    end

    test 'H|-> = |1>' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal [Qubit[1]], circuit.h(0).state
    end

    test 'H|i> = e^{iπ/4}|-i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal [[Fraction(1 + 1i, 2), Fraction(1 - 1i, 2)]], circuit.h(0).state
    end

    test 'H|-i> = e^{-iπ/4}|i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal [[Fraction(1 - 1i, 2), Fraction(1 + 1i, 2)]], circuit.h(0).state
    end
  end
end
