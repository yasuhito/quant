# frozen_string_literal: true

# パウリ Y ゲート
class Y
  def self.*(multi_qubit)
    matrix = Matrix[[0, Complex(0, -1)], [Complex(0, 1), 0]]
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
end
