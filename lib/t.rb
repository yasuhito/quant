# frozen_string_literal: true

# フェーズシフトゲート T
module T
  # rubocop:disable Naming/MethodName
  def T
    matrix = Matrix[[1, 0], [0, Math::E**(1i * Math::PI / 4)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
