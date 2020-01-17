# frozen_string_literal: true

# CNOT ゲート
class CnotGate
  def apply(qubits, target, control)
    qs = qubits[control].tensor_product(qubits[target])
    result = matrix * qs

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

  private

  def matrix
    Matrix[[1, 0, 0, 0],
           [0, 1, 0, 0],
           [0, 0, 0, 1],
           [0, 0, 1, 0]]
  end
end
