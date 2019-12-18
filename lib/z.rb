# frozen_string_literal: true

# パウリ Z ゲート
module Z
  # rubocop:disable Naming/MethodName
  def Z
    matrix = Matrix[[1, 0], [0, -1]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
