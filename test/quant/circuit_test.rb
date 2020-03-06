# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CircuitTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'State flip: |0> to |1> and vice versa' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])
      state = circuit.x(0).state

      assert_equal :α * Qubit['1'] + :β * Qubit['0'], state
      assert_equal 'β|0> + α|1>', state.to_s
    end

    test 'Basis change: |0> to |+> and |1> to |−> (and vice versa)' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])
      state = circuit.h(0).state

      assert_equal :α * Qubit['+'] + :β * Qubit['-'], state
      assert_equal '(2^(-1/2)*α + 2^(-1/2)*β)|0> + (2^(-1/2)*α - 2^(-1/2)*β)|1>', state.to_s
    end

    test 'Sign flip: |+> to |−> and vice versa' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])
      state = circuit.z(0).state

      assert_equal :α * Qubit['0'] - :β * Qubit['1'], state
      assert_equal 'α|0> - β|1>', state.to_s
    end

    test 'Amplitude change: |0> to cos(α)|0⟩ + sin(α)|1⟩' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])
      state = circuit.ry(0, theta: 2 * :α).state

      assert_equal (:β * Cos[:α] + (-:γ * Sin[:α])) * Qubit['0'] + (:β * Sin[:α] + :γ * Cos[:α]) * Qubit['1'], state
      assert_equal '(cos(α)*β - cos(α)*γ)|0> + (cos(α)*β + cos(α)*γ)|1>', state.to_s
    end

    test 'Phase flip: α|0> + β|1> → α|0> + iβ|1>' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])
      state = circuit.s(0).state

      assert_equal :α * Qubit['0'] + 1i * :β * Qubit['1'], state
      assert_equal 'α|0> + β*i|1>', state.to_s
    end

    test 'Phase change: β|0> + γ|1> → β|0> + e^(αi)γ|1>' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])
      state = circuit.r1(0, theta: :α).state

      assert_equal :β * Qubit['0'] + E**(1i * :α) * :γ * Qubit['1'], state
      assert_equal 'β|0> + E^(α*i)*γ|1>', state.to_s
    end

    test 'Global phase change: β|0> + γ|1> → -β|0> - γ|1>' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])
      state = circuit.x(0).z(0).x(0).z(0).state

      assert_equal(-:β * Qubit['0'] - :γ * Qubit['1'], state)
      assert_equal '-β|0> - γ|1>', state.to_s
    end

    test 'Bell state change - 1: |Φ+> → |Φ-> (1/√2|00> + 1/√2|11> → 1/√2|00> - 1/√2|11>)' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])
      state = circuit.x(0).z(0).x(1).state

      assert_equal (1/√(2))*Qubit['00'] - (1/√(2)) * Qubit['11'], state
      assert_equal '2^(-1/2)|00> - 2^(-1/2)|11>', state.to_s
    end

    test 'Bell state change - 2: |Φ+> → |Ψ+> (1/√2|00> + 1/√2|11> → 1/√2|01> + 1/√2|10>)' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])
      state = circuit.x(0).state

      assert_equal (1/√(2))*Qubit['01'] + (1/√(2)) * Qubit['10'], state
      assert_equal '2^(-1/2)|01> + 2^(-1/2)|10>', state.to_s
    end

    test 'Bell state change - 3: |Φ+> → |Ψ-> (1/√2|00> + 1/√2|11> → 1/√2|01> - 1/√2|10>)' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])
      state = circuit.x(0).x(0).z(0).x(1).state

      assert_equal (1/√(2))*Qubit['01'] - (1/√(2)) * Qubit['10'], state
      assert_equal '2^(-1/2)|01> - 2^(-1/2)|10>', state.to_s
    end

    test 'Two-qubit gate - 1: α|00> + β|10> → α|00> + iβ|11>' do
      circuit = Circuit.new(:α * Qubit['00'] + :β * Qubit['10'])
      state = circuit.cnot(0 => 1).state

      assert_equal :α * Qubit['00'] + :β * Qubit['11'], state
      assert_equal 'α|00> + β|11>', state.to_s
    end

    test 'Two-qubit gate - 2: 1/2|00> + 1/2|01> + 1/2|10> + 1/2|11> → 1/2|00> + 1/2|01> + 1/2|10> - 1/2|11>' do
      circuit = Circuit.new(1/2 * Qubit['00'] + 1/2 * Qubit['01'] + 1/2 * Qubit['10'] + 1/2 * Qubit['11'])
      state = circuit.controlled(ZGate.new, 0 => 1).state

      assert_equal 1/2 * Qubit['00'] + 1/2 * Qubit['01'] + 1/2 * Qubit['10'] - 1/2 * Qubit['11'], state
      assert_equal '1/2|00> + 1/2|01> + 1/2|10> - 1/2|11>', state.to_s
    end

    test 'Two-qubit gate - 3: α|00> + β|01> + γ|10> + δ|11> → α|00> + γ|01> + β|10> + δ|11>' do
      circuit = Circuit.new(:α * Qubit['00'] + :β * Qubit['01'] + :γ * Qubit['10'] + :δ * Qubit['11'])
      state = circuit.cnot(0 => 1).cnot(1 => 0).cnot(0 => 1).state

      assert_equal :α * Qubit['00'] + :γ * Qubit['01'] + :β * Qubit['10'] + :δ * Qubit['11'], state
      assert_equal 'α|00> + γ|01> + β|10> + δ|11>', state.to_s
    end

    test 'Toffoli gate' do
      circuit = Circuit.new(:α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :η * Qubit['110'] + :θ * Qubit['111'])

      assert_equal :α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :θ * Qubit['110'] + :η * Qubit['111'],
                   circuit.ccnot([0, 1] => 2).state
    end

    test 'Fredkin gate' do
      skip 'SWAP ゲートを new(qubit1, qubit2) できるようにしてから'
      circuit = Circuit.new(:α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :η * Qubit['110'] + :θ * Qubit['111'])
    end
  end
end
