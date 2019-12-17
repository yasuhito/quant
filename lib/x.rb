# frozen_string_literal: true

# パウリ X ゲート
class X
  def self.*(multi_qubit)
    matrix = Matrix[[0, 1], [1, 0]]
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
end
