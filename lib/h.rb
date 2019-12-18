# frozen_string_literal: true

# アダマールゲート
module Kernel
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Naming/MethodName
  def H(qubit)
    matrix = Matrix[[1 / Math.sqrt(2), 1 / Math.sqrt(2)],
                    [1 / Math.sqrt(2), -1 / Math.sqrt(2)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Naming/MethodName
end
