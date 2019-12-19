# frozen_string_literal: true

# CNOT ゲート
class CnotGate
  def initialize(qubits)
    @qubits = qubits.dup
  end

  # rubocop:disable Metrics/MethodLength
  def apply(target, control)
    qubits = @qubits[control].tensor_product(@qubits[target])
    result = matrix * qubits

    @qubits.dup.tap do |qs|
      qs[target].state = if result == Matrix[[1], [0], [0], [0]]
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
