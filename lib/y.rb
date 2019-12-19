# frozen_string_literal: true

# パウリ Y ゲート
module Y
  # rubocop:disable Metrics/AbcSize
  def y(target)
    matrix = Matrix[[0, Complex(0, -1)], [Complex(0, 1), 0]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize
end
