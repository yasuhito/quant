# frozen_string_literal: true

require 'symbo'

module Quant
  class CnotGate
    include Symbo

    using Symbo

    # rubocop:disable Metrics/AbcSize
    def apply(qubits, target, control)
      qs = TensorProduct[qubits[control], qubits[target]]
      result = (matrix * qs).simplify

      qubits.dup.tap do |obj|
        obj[target] = if result == Matrix[[1], [0], [0], [0]]
                        Qubit[1, 0]
                      elsif result == Matrix[[0], [1], [0], [0]]
                        Qubit[0, 1]
                      elsif result == Matrix[[0], [0], [1], [0]]
                        Qubit[1, 0]
                      elsif result == Matrix[[0], [0], [0], [1]]
                        Qubit[0, 1]
                      end
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def matrix
      Matrix[[1, 0, 0, 0],
             [0, 1, 0, 0],
             [0, 0, 0, 1],
             [0, 0, 1, 0]]
    end
  end
end
