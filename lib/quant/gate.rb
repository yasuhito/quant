# frozen_string_literal: true

require 'symbo'

module Quant
  class Gate
    def apply(qubits, target)
      qubits.dup.tap do |qs|
        qs[target] = Qubit[*(matrix * qs[target].ket.t).column_vectors[0].to_a]
      end
    end
  end
end
