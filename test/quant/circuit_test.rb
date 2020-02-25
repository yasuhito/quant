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
  end
end
