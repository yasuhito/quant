# frozen_string_literal: true

# 単位行列
module I
  # rubocop:disable Naming/MethodName
  def I
    matrix = Matrix.I(2)
    Qubit[*(matrix * ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
