# frozen_string_literal: true

# CNOT ゲート
module CNOT
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def cnot(target, control:)
    matrix = Matrix[[1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 0, 1],
                    [0, 0, 1, 0]]
    qubits = @qubits[control].tensor_product(@qubits[target])
    result = matrix * qubits

    qubits = @qubits.dup.tap do |qs|
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
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
