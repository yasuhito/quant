# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class TGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'T|0> = |0>' do
      circuit = Circuit.new(Qubit['0'])

      assert_equal Qubit['0'], circuit.t(0).state
    end

    test 'T|1> = e^{iπ/4}|1>' do
      circuit = Circuit.new(Qubit['1'])

      assert_equal E**(1i * PI/4) * Qubit['1'], circuit.t(0).state
    end

    test 'T(1)|01> = e^{iπ/4}|01>' do
      circuit = Circuit.new(Qubit['01'])

      assert_equal E**(1i * PI/4) * Qubit['01'], circuit.t(1).state
    end
  end
end
