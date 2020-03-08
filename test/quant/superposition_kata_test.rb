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
      nqubits = rand(4).plus(1)
      circuit = Circuit.new(Qubit['0' * nqubits])

      circuit = circuit.h(0)
      circuit = (0...nqubits).inject(circuit) { |result, each| result.cnot(each => each.plus(1)) }

      assert_equal (1/√(2)) * Qubit['0' * nqubits] + (1/√(2)) * Qubit['1' * nqubits], circuit.state
      assert_equal "2^(-1/2)|#{'0' * nqubits}⟩ + 2^(-1/2)|#{'1' * nqubits}⟩", circuit.state.to_s
    end

    test 'Superposition of all basis vectors: |0…0⟩ → 1/√2^n(|0…0⟩ + |1…1⟩)' do
      circuit = Circuit.new(Qubit['0000'])

      circuit = (0...4).inject(circuit) { |result, each| result.h(each) }

      assert_equal (1/4) * Qubit['0000'] + (1/4) * Qubit['0001'] + (1/4) * Qubit['0010'] + (1/4) * Qubit['0011'] + (1/4) * Qubit['0100'] + (1/4) * Qubit['0101'] + (1/4) * Qubit['0110'] + (1/4) * Qubit['0111'] + (1/4) * Qubit['1000'] + (1/4) * Qubit['1001'] + (1/4) * Qubit['1010'] + (1/4) * Qubit['1011'] + (1/4) * Qubit['1100'] + (1/4) * Qubit['1101'] + (1/4) * Qubit['1110'] + (1/4) * Qubit['1111'], circuit.state
      assert_equal '1/4|0000⟩ + 1/4|0001⟩ + 1/4|0010⟩ + 1/4|0011⟩ + 1/4|0100⟩ + 1/4|0101⟩ + 1/4|0110⟩ + 1/4|0111⟩ + 1/4|1000⟩ + 1/4|1001⟩ + 1/4|1010⟩ + 1/4|1011⟩ + 1/4|1100⟩ + 1/4|1101⟩ + 1/4|1110⟩ + 1/4|1111⟩', circuit.state.to_s
    end

    test 'Superposition of all even numbers' do
      circuit = Circuit.new(Qubit['00000'])

      circuit = (0..3).inject(circuit) { |result, each| result.h(each) }

      assert_equal (1/4) * Qubit['00000'] + (1/4) * Qubit['00010'] + (1/4) * Qubit['00100'] + (1/4) * Qubit['00110'] + (1/4) * Qubit['01000'] + (1/4) * Qubit['01010'] + (1/4) * Qubit['01100'] + (1/4) * Qubit['01110'] + (1/4) * Qubit['10000'] + (1/4) * Qubit['10010'] + (1/4) * Qubit['10100'] + (1/4) * Qubit['10110'] + (1/4) * Qubit['11000'] + (1/4) * Qubit['11010'] + (1/4) * Qubit['11100'] + (1/4) * Qubit['11110'], circuit.state
      assert_equal '1/4|00000⟩ + 1/4|00010⟩ + 1/4|00100⟩ + 1/4|00110⟩ + 1/4|01000⟩ + 1/4|01010⟩ + 1/4|01100⟩ + 1/4|01110⟩ + 1/4|10000⟩ + 1/4|10010⟩ + 1/4|10100⟩ + 1/4|10110⟩ + 1/4|11000⟩ + 1/4|11010⟩ + 1/4|11100⟩ + 1/4|11110⟩', circuit.state.to_s
    end

    test 'Superposition of all odd numbers' do
      circuit = Circuit.new(Qubit['00000'])

      circuit = (0..3).inject(circuit) { |result, each| result.h(each) }
      circuit = circuit.x(4)

      assert_equal (1/4) * Qubit['00001'] + (1/4) * Qubit['00011'] + (1/4) * Qubit['00101'] + (1/4) * Qubit['00111'] + (1/4) * Qubit['01001'] + (1/4) * Qubit['01011'] + (1/4) * Qubit['01101'] + (1/4) * Qubit['01111'] + (1/4) * Qubit['10001'] + (1/4) * Qubit['10011'] + (1/4) * Qubit['10101'] + (1/4) * Qubit['10111'] + (1/4) * Qubit['11001'] + (1/4) * Qubit['11011'] + (1/4) * Qubit['11101'] + (1/4) * Qubit['11111'], circuit.state
      assert_equal '1/4|00001⟩ + 1/4|00011⟩ + 1/4|00101⟩ + 1/4|00111⟩ + 1/4|01001⟩ + 1/4|01011⟩ + 1/4|01101⟩ + 1/4|01111⟩ + 1/4|10001⟩ + 1/4|10011⟩ + 1/4|10101⟩ + 1/4|10111⟩ + 1/4|11001⟩ + 1/4|11011⟩ + 1/4|11101⟩ + 1/4|11111⟩', circuit.state.to_s
    end
  end
end
