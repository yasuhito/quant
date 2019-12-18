# frozen_string_literal: true

# フェーズシフトゲート S
module S
  # rubocop:disable Naming/MethodName
  def S
    matrix = Matrix[[1, 0], [0, Complex(0, 1)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
