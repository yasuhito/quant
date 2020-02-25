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

    # test 'Controlled(Rx(theta), 1, control: 0)|00>' do
    #   circuit = Circuit.new(2).controlled(Rx.new(2 * PI), 1, control: 0)

    #   assert_equal '|00>', circuit.to_s
    # end

    # test 'Controlled(Rx(theta), 1, control: 0)|01>' do
    #   circuit = Circuit.new(2).x(1).controlled(Rx.new(2 * PI), 1, control: 0)

    #   assert_equal '|01>', circuit.to_s
    # end

    # test 'Controlled(Rx(theta), 1, control: 0)|10>' do
    #   circuit = Circuit.new(2).x(0).controlled(Rx.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [cos(PI), -1i * sin(PI)]], circuit.state
    # end

    # test 'Controlled(Rx(theta), 1, control: 0)|11>' do
    #   circuit = Circuit.new(2).x(0).x(1).controlled(Rx.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [-1i * sin(PI), cos(PI)]], circuit.state
    # end

    # test 'Controlled(Ry(theta), 1, control: 0)|00>' do
    #   circuit = Circuit.new(2).controlled(Ry.new(2 * PI), 1, control: 0)

    #   assert_equal '|00>', circuit.to_s
    # end

    # test 'Controlled(Ry(theta), 1, control: 0)|01>' do
    #   circuit = Circuit.new(2).x(1).controlled(Ry.new(2 * PI), 1, control: 0)

    #   assert_equal '|01>', circuit.to_s
    # end

    # test 'Controlled(Ry(theta), 1, control: 0)|10>' do
    #   circuit = Circuit.new(2).x(0).controlled(Ry.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [cos(PI), sin(PI)]], circuit.state
    # end

    # test 'Controlled(Ry(theta), 1, control: 0)|11>' do
    #   circuit = Circuit.new(2).x(0).x(1).controlled(Ry.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [-1 * sin(PI), cos(PI)]], circuit.state
    # end

    # test 'Controlled(Rz(theta), 1, control: 0)|00>' do
    #   circuit = Circuit.new(2).controlled(Rz.new(2 * PI), 1, control: 0)

    #   assert_equal '|00>', circuit.to_s
    # end

    # test 'Controlled(Rz(theta), 1, control: 0)|01>' do
    #   circuit = Circuit.new(2).x(1).controlled(Rz.new(2 * PI), 1, control: 0)

    #   assert_equal '|01>', circuit.to_s
    # end

    # test 'Controlled(Rz(theta), 1, control: 0)|10>' do
    #   circuit = Circuit.new(2).x(0).controlled(Rz.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [E**(-1i * PI), 0]], circuit.state
    # end

    # test 'Controlled(Rz(theta), 1, control: 0)|11>' do
    #   circuit = Circuit.new(2).x(0).x(1).controlled(Rz.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [0, E**(-1i * PI)]], circuit.state
    # end

    # test 'Controlled(R1(theta), 1, control: 0)|00>' do
    #   circuit = Circuit.new(2).controlled(R1.new(2 * PI), 1, control: 0)

    #   assert_equal '|00>', circuit.to_s
    # end

    # test 'Controlled(R1(theta), 1, control: 0)|01>' do
    #   circuit = Circuit.new(2).x(1).controlled(R1.new(2 * PI), 1, control: 0)

    #   assert_equal '|01>', circuit.to_s
    # end

    # test 'Controlled(R1(theta), 1, control: 0)|10>' do
    #   circuit = Circuit.new(2).x(0).controlled(R1.new(2 * PI), 1, control: 0)

    #   assert_equal '|10>', circuit.to_s
    # end

    # test 'Controlled(R1(theta), 1, control: 0)|11>' do
    #   circuit = Circuit.new(2).x(0).x(1).controlled(R1.new(2 * PI), 1, control: 0)

    #   assert_equal [Qubit['1'], [0, E**(2i * PI)]], circuit.state
    # end
  end
end
