# frozen_string_literal: true

# パウリ X ゲート
module X
  # rubocop:disable Naming/MethodName
  def X
    matrix = Matrix[[0, 1], [1, 0]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
