# frozen_string_literal: true

# アダマールゲート
module H
  include Math

  # rubocop:disable Metrics/AbcSize
  def h(target)
    matrix = Matrix[[1 / sqrt(2), 1 / sqrt(2)], [1 / sqrt(2), -1 / sqrt(2)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize
end
