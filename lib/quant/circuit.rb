# frozen_string_literal: true

require 'quant/cnot_gate'
require 'quant/h_gate'
require 'quant/i_gate'
require 'quant/qubit'
require 'quant/r1_gate'
require 'quant/rx_gate'
require 'quant/ry_gate'
require 'quant/rz_gate'
require 'quant/s_gate'
require 'quant/swap_gate'
require 'quant/t_gate'
require 'quant/x_gate'
require 'quant/y_gate'
require 'quant/z_gate'

module Quant
  class Circuit
    using Symbo

    def initialize(*qubits)
      @qubits = if qubits.first.is_a?(Qubit)
                  qubits
                elsif qubits.first.is_a?(Array)
                  qubits.first
                else
                  Array.new(qubits.first) { Qubit[1, 0] }
                end
    end

    def i(target)
      self.class.new IGate.new.apply(@qubits, target)
    end

    def x(target)
      self.class.new XGate.new.apply(@qubits, target)
    end

    def y(target)
      self.class.new YGate.new.apply(@qubits, target)
    end

    def z(target)
      self.class.new ZGate.new.apply(@qubits, target)
    end

    def h(target)
      self.class.new HGate.new.apply(@qubits, target)
    end

    def s(target)
      self.class.new SGate.new.apply(@qubits, target)
    end

    def t(target)
      self.class.new TGate.new.apply(@qubits, target)
    end

    def rx(target, theta:)
      self.class.new RxGate.new(theta).apply(@qubits, target)
    end

    def ry(target, theta:)
      self.class.new RyGate.new(theta).apply(@qubits, target)
    end

    def rz(target, theta:)
      self.class.new RzGate.new(theta).apply(@qubits, target)
    end

    def r1(target, theta:)
      self.class.new R1Gate.new(theta).apply(@qubits, target)
    end

    def cnot(target, control:)
      self.class.new CnotGate.new.apply(@qubits, target, control)
    end

    def swap(qubit1, qubit2)
      self.class.new SwapGate.new.apply(@qubits, qubit1, qubit2)
    end

    def state
      @qubits.map(&:state)
    end

    def controlled(gate, target, control:)
      return dup if @qubits[control] == Qubit['0']

      matrix = Matrix.hstack(Matrix.vstack(Matrix.I(2), Matrix.build(2) { 0 }),
                             Matrix.vstack(Matrix.build(2) { 0 }, gate.matrix))
      qs = @qubits[control].tensor_product(@qubits[target])
      result = matrix * qs
      qubits = @qubits.dup.tap do |obj|
        obj[target] = Qubit[result[2, 0], result[3, 0]]
      end
      self.class.new qubits
    end

    def to_s
      @qubits.map(&:to_s).join
    end
  end
end
