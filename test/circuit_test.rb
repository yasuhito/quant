# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

class CircuitTest < ActiveSupport::TestCase
  # test 'R1|0>' do
  #   circuit = Circuit.new(1).r1(0, theta: 2 * PI)

  #   assert_equal '|0>', circuit.to_s
  # end

  # test 'R1|1>' do
  #   circuit = Circuit.new(1).x(0).r1(0, theta: 2 * PI)

  #   assert_equal [[0, E**(2i * PI)]], circuit.state
  # end

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

  #   assert_equal [Qubit[1], [cos(PI), -1i * sin(PI)]], circuit.state
  # end

  # test 'Controlled(Rx(theta), 1, control: 0)|11>' do
  #   circuit = Circuit.new(2).x(0).x(1).controlled(Rx.new(2 * PI), 1, control: 0)

  #   assert_equal [Qubit[1], [-1i * sin(PI), cos(PI)]], circuit.state
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

  #   assert_equal [Qubit[1], [cos(PI), sin(PI)]], circuit.state
  # end

  # test 'Controlled(Ry(theta), 1, control: 0)|11>' do
  #   circuit = Circuit.new(2).x(0).x(1).controlled(Ry.new(2 * PI), 1, control: 0)

  #   assert_equal [Qubit[1], [-1 * sin(PI), cos(PI)]], circuit.state
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

  #   assert_equal [Qubit[1], [E**(-1i * PI), 0]], circuit.state
  # end

  # test 'Controlled(Rz(theta), 1, control: 0)|11>' do
  #   circuit = Circuit.new(2).x(0).x(1).controlled(Rz.new(2 * PI), 1, control: 0)

  #   assert_equal [Qubit[1], [0, E**(-1i * PI)]], circuit.state
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

  #   assert_equal [Qubit[1], [0, E**(2i * PI)]], circuit.state
  # end
end
