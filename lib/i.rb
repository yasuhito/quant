# frozen_string_literal: true

# 単位行列
class I
  def self.*(multi_qubit)
    matrix = Matrix.I(2)
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
end
