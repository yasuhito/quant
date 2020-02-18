# frozen_string_literal: true

require 'symbo'

module Quant
  class Gate
    using Symbo

    def apply(qubits, target)
      qubits.dup.tap do |qs|
        qs[target] = Qubit[*(matrix * qs[target]).to_a.map(&:first)]
      end
    end
  end
end
