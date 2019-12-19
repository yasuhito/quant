# frozen_string_literal: true

# フェーズシフトゲート T
module T
  include Math

  # rubocop:disable Metrics/AbcSize
  def t(target)
    matrix = Matrix[[1, 0], [0, E**(1i * PI / 4)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize
end
