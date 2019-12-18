# frozen_string_literal: true

# CNOT ゲート
module Kernel
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Naming/MethodName
  def CNOT(control, target)
    matrix = Matrix[[1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 0, 1],
                    [0, 0, 1, 0]]
    qubits = control.tensor_product(target)
    result = matrix * qubits

    if result == Matrix[[1], [0], [0], [0]]
      Qubits[0, 0]
    elsif result == Matrix[[0], [1], [0], [0]]
      Qubits[0, 1]
    elsif result == Matrix[[0], [0], [0], [1]]
      Qubits[1, 1]
    elsif result == Matrix[[0], [0], [1], [0]]
      Qubits[1, 0]
    end
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/MethodLength
end
