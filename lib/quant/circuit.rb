# frozen_string_literal: true

require 'quant/controlled_gate'
require 'quant/r1_gate'
require 'quant/rx_gate'
require 'quant/ry_gate'
require 'quant/rz_gate'
require 'quant/swap_gate'
require 'symbo/expressions/h_gate'
require 'symbo/expressions/i_gate'
require 'symbo/expressions/s_gate'
require 'symbo/expressions/t_gate'
require 'symbo/expressions/x_gate'
require 'symbo/expressions/y_gate'
require 'symbo/expressions/z_gate'

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

    def cnot(target, control:)
      controlled XGate.new, target, control: control
    end

    def swap(qubit1, qubit2)
      self.class.new(SwapGate.new.apply(@state, qubit1, qubit2))
    end

    def controlled(gate, target, control:)
      self.class.new(ControlledGate.new(gate).apply(@state, target, control))
    end

    def state
      @state.map(&:simplify)
    end

    def to_s
      @state.map(&:to_s).join
    end
  end
end
