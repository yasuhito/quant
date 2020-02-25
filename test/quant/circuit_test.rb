# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CircuitTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'State flip: |0> to |1> and vice versa' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])

      assert_equal :α * Qubit['1'] + :β * Qubit['0'], circuit.x(0).state
      assert_equal 'β|0> + α|1>', circuit.x(0).state.to_s
    end

    test 'Basis change: |0> to |+> and |1> to |−> (and vice versa)' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])

      assert_equal :α * Qubit['+'] + :β * Qubit['-'], circuit.h(0).state
      assert_equal '(2^(-1/2)*α + 2^(-1/2)*β)|0> + (2^(-1/2)*α - 2^(-1/2)*β)|1>', circuit.h(0).state.to_s
    end

    test 'Sign flip: |+> to |−> and vice versa' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])

      assert_equal :α * Qubit['0'] - :β * Qubit['1'], circuit.z(0).state
      assert_equal 'α|0> - β|1>', circuit.z(0).state.to_s
    end

    test 'Amplitude change: |0> to cos(α)|0⟩ + sin(α)|1⟩' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])

      assert_equal (:β * Cos[:α] + (-:γ * Sin[:α])) * Qubit['0'] + (:β * Sin[:α] + :γ * Cos[:α]) * Qubit['1'],
                   circuit.ry(0, theta: 2 * :α).state
      assert_equal '(cos(α)*β - cos(α)*γ)|0> + (cos(α)*β + cos(α)*γ)|1>', circuit.ry(0, theta: 2 * :α).state.to_s
    end

    test 'Phase flip' do
      circuit = Circuit.new(:α * Qubit['0'] + :β * Qubit['1'])

      assert_equal :α * Qubit['0'] + 1i * :β * Qubit['1'], circuit.s(0).state
      assert_equal 'α|0> + β*i|1>', circuit.s(0).state.to_s
    end

    test 'Phase change' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])

      assert_equal :β * Qubit['0'] + E**(1i * :α) * :γ * Qubit['1'], circuit.r1(0, theta: :α).state
      assert_equal 'β|0> + E^(α*i)*γ|1>', circuit.r1(0, theta: :α).state.to_s
    end

    test 'Global phase change' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])

      assert_equal(-:β * Qubit['0'] + (-:γ * Qubit['1']), circuit.x(0).z(0).x(0).z(0).state)
      assert_equal '-β|0> - γ|1>', circuit.x(0).z(0).x(0).z(0).state.to_s
    end

    test 'Bell state change - 1' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])

      assert_equal (1/√(2))*Qubit['00'] - (1/√(2)) * Qubit['11'], circuit.x(0).z(0).x(1).state
      assert_equal '(2^(-1/2))|00> - 2^(-1/2)|11>', circuit.x(0).z(0).x(1).state.to_s
    end

    test 'Bell state change - 2' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])

      assert_equal (1/√(2))*Qubit['01'] + (1/√(2)) * Qubit['10'], circuit.x(0).state
      assert_equal '(2^(-1/2))|01> + (2^(-1/2))|10>', circuit.x(0).state.to_s
    end

    test 'Bell state change - 3' do
      circuit = Circuit.new(1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'])

      assert_equal (1/√(2))*Qubit['01'] - (1/√(2)) * Qubit['10'], circuit.x(0).x(0).z(0).x(1).state
      assert_equal '(2^(-1/2))|01> - 2^(-1/2)|10>', circuit.x(0).x(0).z(0).x(1).state.to_s
    end

    test 'Two-qubit gate - 1' do
      circuit = Circuit.new(:α * Qubit['00'] + :β * Qubit['10'])

      assert_equal :α * Qubit['00'] + :β * Qubit['11'], circuit.cnot(1, control: 0).state
      assert_equal 'α|00> + β|11>', circuit.cnot(1, control: 0).state.to_s
    end

    test 'Two-qubit gate - 2' do
      circuit = Circuit.new(1/2 * Qubit['00'] + 1/2 * Qubit['01'] + 1/2 * Qubit['10'] + 1/2 * Qubit['11'])

      assert_equal 1/2 * Qubit['00'] + 1/2 * Qubit['01'] + 1/2 * Qubit['10'] - 1/2 * Qubit['11'], circuit.controlled(ZGate.new, 1, control: 0).state
      assert_equal '1/2|00> + 1/2|01> + 1/2|10> - 1/2|11>', circuit.controlled(ZGate.new, 1, control: 0).state.to_s
    end

    test 'Two-qubit gate - 3' do
      circuit = Circuit.new(:α * Qubit['00'] + :β * Qubit['01'] + :γ * Qubit['10'] + :δ * Qubit['11'])

      assert_equal :α * Qubit['00'] + :γ * Qubit['01'] + :β * Qubit['10'] + :δ * Qubit['11'], circuit.cnot(1, control: 0).cnot(0, control: 1).cnot(1, control: 0).state
      assert_equal 'α|00> + γ|01> + β|10> + δ|11>', circuit.cnot(1, control: 0).cnot(0, control: 1).cnot(1, control: 0).state.to_s
    end

    test 'Toffoli gate' do
      skip 'Cnot クラスを復活させてから'
      circuit = Circuit.new(:α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :η * Qubit['110'] + :θ * Qubit['111'])
    end

    test 'Fredkin gate' do
      skip 'SWAP ゲートを new(qubit1, qubit2) できるようにしてから'
      circuit = Circuit.new(:α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :η * Qubit['110'] + :θ * Qubit['111'])
    end
  end
end
