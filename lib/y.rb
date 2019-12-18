# frozen_string_literal: true

# パウリ Y ゲート
module Y
  # rubocop:disable Naming/MethodName
  def Y
    matrix = Matrix[[0, Complex(0, -1)], [Complex(0, 1), 0]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
