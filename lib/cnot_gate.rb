# frozen_string_literal: true

# CNOT ゲート
class CnotGate
  # rubocop:disable Metrics/MethodLength
  def apply(qubits, target, control)
    qs = qubits[control].tensor_product(qubits[target])
    result = matrix * qs

    qubits.dup.tap do |obj|
      obj[target].state = if result == Matrix[[1], [0], [0], [0]]
                            [1, 0]
                          elsif result == Matrix[[0], [1], [0], [0]]
                            [0, 1]
                          elsif result == Matrix[[0], [0], [0], [1]]
                            [1, 0]
                          elsif result == Matrix[[0], [0], [1], [0]]
                            [1, 0]
                          end
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def matrix
    Matrix[[1, 0, 0, 0],
           [0, 1, 0, 0],
           [0, 0, 0, 1],
           [0, 0, 1, 0]]
  end
end
