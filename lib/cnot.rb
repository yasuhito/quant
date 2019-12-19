# frozen_string_literal: true

# CNOT ゲート
module CNOT
  # rubocop:disable Metrics/MethodLength
  def cnot(control:, target:)
    matrix = Matrix[[1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 0, 1],
                    [0, 0, 1, 0]]
    qubits = @qubits[control].tensor_product(@qubits[target])
    result = matrix * qubits

    @qubits[target].state = if result == Matrix[[1], [0], [0], [0]]
                              [1, 0]
                            elsif result == Matrix[[0], [1], [0], [0]]
                              [0, 1]
                            elsif result == Matrix[[0], [0], [0], [1]]
                              [1, 0]
                            elsif result == Matrix[[0], [0], [1], [0]]
                              [1, 0]
                            end
  end
  # rubocop:enable Metrics/MethodLength
end
