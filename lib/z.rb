# frozen_string_literal: true

# パウリ Z ゲート
class Z
  def self.*(multi_qubit)
    matrix = Matrix[[1, 0], [0, -1]]
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
end
