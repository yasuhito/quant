# frozen_string_literal: true

require 'symbo'

module Quant
  class Circuit
    include Symbo

    using Symbo

    def initialize(state)
      @state = state
    end

    def i(target)
      self.class.new(IGate.new.apply(@state, target))
    end

    def x(target)
      self.class.new(XGate.new.apply(@state, target))
    end

    def y(target)
      self.class.new(YGate.new.apply(@state, target))
    end

    def z(target)
      self.class.new(ZGate.new.apply(@state, target))
    end

    def h(target)
      self.class.new(HGate.new.apply(@state, target))
    end

    def s(target)
      self.class.new(SGate.new.apply(@state, target))
    end

    def t(target)
      self.class.new(TGate.new.apply(@state, target))
    end

    def rx(target, theta:)
      self.class.new(RxGate.new(theta).apply(@state, target))
    end

    def ry(target, theta:)
      self.class.new(RyGate.new(theta).apply(@state, target))
    end

    def rz(target, theta:)
      self.class.new(RzGate.new(theta).apply(@state, target))
    end

    def r1(target, theta:)
      self.class.new(R1Gate.new(theta).apply(@state, target))
    end

    def cnot(control_target)
      controlled XGate.new, control_target
    end

    def swap(qubit1, qubit2)
      self.class.new(SwapGate.new.apply(@state, qubit1, qubit2))
    end

    def ccnot(control_target)
      self.class.new(Ccnot(qubit_length, control_target) * @state)
    end

    def controlled(gate, control_target)
      control = control_target.keys.first
      target = control_target.values.first

      self.class.new(ControlledGate.new(gate.matrix).apply(@state, target, control))
    end

    def state
      @state.map(&:simplify)
    end

    def to_s
      @state.map(&:to_s).join
    end

    private

    def qubit_length
      Math.log2(@state.row_size).to_i
    end
  end
end
