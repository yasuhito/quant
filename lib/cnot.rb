# frozen_string_literal: true

# CNOT ゲート
module CNOT
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Naming/MethodName
  def CNOT(control)
    matrix = Matrix[[1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 0, 1],
                    [0, 0, 1, 0]]
    qubits = control.tensor_product(self)
    result = matrix * qubits

    @state = if result == Matrix[[1], [0], [0], [0]]
               [1, 0]
             elsif result == Matrix[[0], [1], [0], [0]]
               [0, 1]
             elsif result == Matrix[[0], [0], [0], [1]]
               [1, 0]
             elsif result == Matrix[[0], [0], [1], [0]]
               [1, 0]
             end
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/MethodLength
end
