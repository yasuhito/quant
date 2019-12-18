# frozen_string_literal: true

# フェーズシフトゲート T
module Kernel
  # rubocop:disable Naming/MethodName
  def T(qubit)
    matrix = Matrix[[1, 0], [0, Math::E**(1i * Math::PI / 4)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
