# frozen_string_literal: true

# フェーズシフトゲート S
module Kernel
  # rubocop:disable Naming/MethodName
  def S(multi_qubit)
    matrix = Matrix[[1, 0], [0, Complex(0, 1)]]
    Qubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
