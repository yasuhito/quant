# frozen_string_literal: true

# アダマールゲート
class H
  # rubocop:disable AbcSize
  def self.*(multi_qubit)
    matrix = Matrix[[1 / Math.sqrt(2), 1 / Math.sqrt(2)],
                    [1 / Math.sqrt(2), -1 / Math.sqrt(2)]]
    MultiQubit[*(matrix * multi_qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable AbcSize
end
