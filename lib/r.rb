# frozen_string_literal: true

# ローテーションゲート
module Kernel
  # rubocop:disable Naming/MethodName
  # rubocop:disable Metrics/AbcSize
  def Rx(theta, qubit)
    matrix = Matrix[[Math.cos(theta / 2), -1i * Math.sin(theta / 2)],
                    [-1i * Math.sin(theta / 2), Math.cos(theta / 2)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Naming/MethodName
  # rubocop:disable Metrics/AbcSize
  def Ry(theta, qubit)
    matrix = Matrix[[Math.cos(theta / 2), -1 * Math.sin(theta / 2)],
                    [Math.sin(theta / 2), Math.cos(theta / 2)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Naming/MethodName
  def Rz(theta, qubit)
    matrix = Matrix[[Math::E**(-1i * theta / 2), 0],
                    [0, Math::E**(-1i * theta / 2)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName

  # rubocop:disable Naming/MethodName
  def R1(theta, qubit)
    matrix = Matrix[[1, 0], [0, Math::E**(1i * theta)]]
    Qubit[*(matrix * qubit.ket.t).column_vectors[0].to_a]
  end
  # rubocop:enable Naming/MethodName
end
