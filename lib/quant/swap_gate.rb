# frozen_string_literal: true

module Quant
  class SwapGate
    using Symbo

    # rubocop:disable Metrics/AbcSize
    def apply(qubits, qubit1, qubit2)
      qs = qubits[qubit1].tensor_product(qubits[qubit2])
      result = (matrix * qs).simplify

      qubits.dup.tap do |obj|
        if result == Matrix[[1], [0], [0], [0]]
          obj[qubit1] = Qubit['0']
          obj[qubit2] = Qubit['0']
        elsif result == Matrix[[0], [1], [0], [0]]
          obj[qubit1] = Qubit['0']
          obj[qubit2] = Qubit['1']
        elsif result == Matrix[[0], [0], [1], [0]]
          obj[qubit1] = Qubit['1']
          obj[qubit2] = Qubit['0']
        elsif result == Matrix[[0], [0], [0], [1]]
          obj[qubit1] = Qubit['1']
          obj[qubit2] = Qubit['1']
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def matrix
      Matrix[[1, 0, 0, 0],
             [0, 0, 1, 0],
             [0, 1, 0, 0],
             [0, 0, 0, 1]]
    end
  end
end
