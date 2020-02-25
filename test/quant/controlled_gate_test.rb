# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CircuitTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Controlled(Rx(theta), 1, control: 0)|00>' do
      circuit = Circuit.new(Qubit['00']).controlled(RxGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['00'], circuit.state
    end

    test 'Controlled(Rx(theta), 1, control: 0)|01>' do
      circuit = Circuit.new(Qubit['01']).controlled(RxGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['01'], circuit.state
    end

    test 'Controlled(Rx(theta), 1, control: 0)|10>' do
      circuit = Circuit.new(Qubit['10']).controlled(RxGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['10'], circuit.state)
    end

    test 'Controlled(Rx(theta), 1, control: 0)|11>' do
      circuit = Circuit.new(Qubit['11']).controlled(RxGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['11'], circuit.state)
    end

    test 'Controlled(Ry(theta), 1, control: 0)|00>' do
      circuit = Circuit.new(Qubit['00']).controlled(RyGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['00'], circuit.state
    end

    test 'Controlled(Ry(theta), 1, control: 0)|01>' do
      circuit = Circuit.new(Qubit['01']).controlled(RyGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['01'], circuit.state
    end

    test 'Controlled(Ry(theta), 1, control: 0)|10>' do
      circuit = Circuit.new(Qubit['10']).controlled(RyGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['10'], circuit.state)
    end

    test 'Controlled(Ry(theta), 1, control: 0)|11>' do
      circuit = Circuit.new(Qubit['11']).controlled(RyGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['11'], circuit.state)
    end

    test 'Controlled(Rz(theta), 1, control: 0)|00>' do
      circuit = Circuit.new(Qubit['00']).controlled(RzGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['00'], circuit.state
    end

    test 'Controlled(Rz(theta), 1, control: 0)|01>' do
      circuit = Circuit.new(Qubit['01']).controlled(RzGate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['01'], circuit.state
    end

    test 'Controlled(Rz(theta), 1, control: 0)|10>' do
      circuit = Circuit.new(Qubit['10']).controlled(RzGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['10'], circuit.state)
    end

    test 'Controlled(Rz(theta), 1, control: 0)|11>' do
      circuit = Circuit.new(Qubit['11']).controlled(RzGate.new(2 * PI), 1, control: 0)

      assert_equal(-Qubit['11'], circuit.state)
    end

    test 'Controlled(R1(theta), 1, control: 0)|00>' do
      circuit = Circuit.new(Qubit['00']).controlled(R1Gate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['00'], circuit.state
    end

    test 'Controlled(R1(theta), 1, control: 0)|01>' do
      circuit = Circuit.new(Qubit['01']).controlled(R1Gate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['01'], circuit.state
    end

    test 'Controlled(R1(theta), 1, control: 0)|10>' do
      circuit = Circuit.new(Qubit['10']).controlled(R1Gate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['10'], circuit.state
    end

    test 'Controlled(R1(theta), 1, control: 0)|11>' do
      circuit = Circuit.new(Qubit['11']).controlled(R1Gate.new(2 * PI), 1, control: 0)

      assert_equal Qubit['11'], circuit.state
    end
  end
end
