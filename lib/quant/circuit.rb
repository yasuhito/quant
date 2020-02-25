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
      self.class.new(CnotGate.new.apply(@state, target, control))
    end

    def swap(qubit1, qubit2)
      self.class.new(SwapGate.new.apply(@state, qubit1, qubit2))
    end

    def state
      @state.map(&:simplify)
    end

    def to_s
      @state.map(&:to_s).join
    end
  end
end
