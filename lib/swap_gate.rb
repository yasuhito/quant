# frozen_string_literal: true

# SWAP ゲート
class SwapGate
  def apply(qubits, qubit1, qubit2)
    qs = qubits[qubit1].tensor_product(qubits[qubit2])
    result = matrix * qs

    qubits.dup.tap do |obj|
      if result == Matrix[[1], [0], [0], [0]]
        obj[qubit1] = Qubit[0]
        obj[qubit2] = Qubit[0]
      elsif result == Matrix[[0], [1], [0], [0]]
        obj[qubit1] = Qubit[0]
        obj[qubit2] = Qubit[1]
      elsif result == Matrix[[0], [0], [1], [0]]
        obj[qubit1] = Qubit[1]
        obj[qubit2] = Qubit[0]
      elsif result == Matrix[[0], [0], [0], [1]]
        obj[qubit1] = Qubit[1]
        obj[qubit2] = Qubit[1]
      end
    end
  end

  private

  def matrix
    Matrix[[1, 0, 0, 0],
           [0, 0, 1, 0],
           [0, 1, 0, 0],
           [0, 0, 0, 1]]
  end
end
