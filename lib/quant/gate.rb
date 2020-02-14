# frozen_string_literal: true

require 'symbo'

module Quant
  class Gate
    using Symbo

    def apply(qubits, target)
      qubits.dup.tap do |qs|
        qs[target] = Qubit[*(matrix * qs[target].ket.t).map(&:simplify).column_vectors[0].to_a]
      end
    end
  end
end
