# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class SuperpositionKataTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'Plus state: |0⟩ → |+⟩' do
      circuit = Circuit.new(Qubit['0'])
      state = circuit.h(0).state

      assert_equal Qubit['+'], state
      assert_equal '2^(-1/2)|0⟩ + 2^(-1/2)|1⟩', state.to_s
    end

    test 'Minus state: |0⟩ → |-⟩' do
      circuit = Circuit.new(Qubit['0'])
      state = circuit.x(0).h(0).state

      assert_equal Qubit['-'], state
      assert_equal '2^(-1/2)|0⟩ - 2^(-1/2)|1⟩', state.to_s
    end

    test 'Unequal superposition: |0⟩ → cos α|0⟩ + sin α|1⟩' do
      circuit = Circuit.new(Qubit['0'])
      state = circuit.ry(0, theta: 2 * :α).state

      assert_equal Cos[:α] * Qubit['0'] + Sin[:α] * Qubit['1'], state
      assert_equal 'cos(α)|0⟩ + sin(α)|1⟩', state.to_s
    end

    test 'Superposition of all basis vectors on two qubits: |00⟩ → 1/2|00⟩ + 1/2|01⟩ + 1/2|10⟩ + 1/2|11⟩' do
      circuit = Circuit.new(Qubit['00'])
      state = circuit.h(0).h(1).state

      assert_equal (1/2 * Qubit['00'] + 1/2 * Qubit['01'] + 1/2 * Qubit['10'] + 1/2 * Qubit['11']).simplify, state
      assert_equal '1/2|00⟩ + 1/2|01⟩ + 1/2|10⟩ + 1/2|11⟩', state.to_s
    end

    test 'Superposition of basis vectors with phases: |00⟩ → 1/2|00⟩ + i/2|01⟩ - 1/2|10⟩ - i/2|11⟩' do
      circuit = Circuit.new(Qubit['00'])
      state = circuit.h(0).h(1).s(1).z(0).state

      assert_equal (1/2 * Qubit['00'] + 1/2 * 1i * Qubit['01'] - 1/2 * Qubit['10'] - 1/2 * 1i * Qubit['11']).simplify, state
      assert_equal '1/2|00⟩ + i/2|01⟩ - 1/2|10⟩ - 1i/2|11⟩', state.to_s # FIXME: 1i を 1 にする
    end

    test 'Bell state |Φ+⟩: |00⟩ → |Φ+⟩ (1/√2|00⟩ + 1/√2|11⟩)' do
      circuit = Circuit.new(Qubit['00'])
      state = circuit.h(0).cnot(0 => 1).state

      assert_equal 1/√(2) * Qubit['00'] + 1/√(2) * Qubit['11'], state
      assert_equal '2^(-1/2)|00⟩ + 2^(-1/2)|11⟩', state.to_s
    end

    test 'All Bell states' do
      # |Φ+⟩ (1/√2|00⟩ + 1/√2|11⟩)
      circuit = Circuit.new(Qubit['00']).h(0).cnot(0 => 1)

      # |Φ-⟩ (1/√2|00⟩ - 1/√2|11⟩)
      state = circuit.dup.z(0).state
      assert_equal (1/√(2)) * Qubit['00'] - (1/√(2)) * Qubit['11'], state
      assert_equal '2^(-1/2)|00⟩ - 2^(-1/2)|11⟩', state.to_s

      # |Ψ+⟩ (1/√2|01⟩ + 1/√2|10⟩)
      state = circuit.dup.x(0).state
      assert_equal (1/√(2)) * Qubit['01'] + (1/√(2)) * Qubit['10'], state
      assert_equal '2^(-1/2)|01⟩ + 2^(-1/2)|10⟩', state.to_s

      # |Ψ-⟩ (1/√2|01⟩ - 1/√2|10⟩)
      state = circuit.dup.x(0).z(0).state
      assert_equal (1/√(2))*Qubit['01'] - (1/√(2)) * Qubit['10'], state
      assert_equal '2^(-1/2)|01⟩ - 2^(-1/2)|10⟩', state.to_s
    end

    test 'Greenberger–Horne–Zeilinger state: |0…0⟩ → 1/√2(|0…0⟩ + |1…1⟩)' do
      nqubits = rand(11)
      circuit = Circuit.new(Qubit['0' * nqubits])

      circuit = circuit.h(0)
      circuit = (0...nqubits).inject(circuit) { |result, each| result.cnot(each => each.plus(1)) }

      assert_equal (1/√(2)) * Qubit['0' * nqubits] + (1/√(2)) * Qubit['1' * nqubits], circuit.state
      assert_equal "2^(-1/2)|#{'0' * nqubits}⟩ + 2^(-1/2)|#{'1' * nqubits}⟩", circuit.state.to_s
    end
  end
end
