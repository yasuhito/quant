# frozen_string_literal: true

# 単位行列
module Kernel
  # rubocop:disable Naming/MethodName
  def I(multi_qubit)
    matrix = Matrix.I(2)
    Qubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
