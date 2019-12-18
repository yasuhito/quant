# frozen_string_literal: true

# パウリ Y ゲート
module Kernel
  # rubocop:disable Naming/MethodName
  def Y(qubit)
    matrix = Matrix[[0, Complex(0, -1)], [Complex(0, 1), 0]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
