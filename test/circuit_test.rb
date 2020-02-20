# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class CircuitTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'circuit (-β|0> - γ|1>) in String' do
      circuit = Circuit.new(:β * Qubit['0'] + :γ * Qubit['1'])

      assert_equal '-β|0> - γ|1>', circuit.x(0).z(0).x(0).z(0).to_s
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
