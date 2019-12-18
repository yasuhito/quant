# frozen_string_literal: true

# パウリ X ゲート
module Kernel
  # rubocop:disable Naming/MethodName
  def X(qubit)
    matrix = Matrix[[0, 1], [1, 0]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
