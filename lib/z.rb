# frozen_string_literal: true

# パウリ Z ゲート
module Kernel
  # rubocop:disable Naming/MethodName
  def Z(qubit)
    matrix = Matrix[[1, 0], [0, -1]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
