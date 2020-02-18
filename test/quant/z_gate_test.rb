# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class ZGateTest < ActiveSupport::TestCase
    test 'Z|0> = |0>' do
      circuit = Circuit.new(Qubit[0])

      assert_equal [Qubit[0]], circuit.z(0).state
    end

    test 'Z|1> = -|1>' do
      circuit = Circuit.new(Qubit[1])

      assert_equal [-Qubit[1]], circuit.z(0).state
    end

    test 'Z|+> = |->' do
      circuit = Circuit.new(Qubit['+'])

      assert_equal [Qubit['-']], circuit.z(0).state
    end

    test 'Z|-> = |+>' do
      circuit = Circuit.new(Qubit['-'])

      assert_equal [Qubit['+']], circuit.z(0).state
    end

    test 'Z|i> = |-i>' do
      circuit = Circuit.new(Qubit['i'])

      assert_equal [Qubit['-i']], circuit.z(0).state
    end

    test 'Z|-i> = |i>' do
      circuit = Circuit.new(Qubit['-i'])

      assert_equal [Qubit['i']], circuit.z(0).state
    end
  end
end
