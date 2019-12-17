# frozen_string_literal: true

# 単位行列
class I
  def self.*(multi_qubit)
    matrix = Matrix.I(multi_qubit.length)
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
end
