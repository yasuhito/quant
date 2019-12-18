# frozen_string_literal: true

# ローテーションゲート
module R
  include Math

  # rubocop:disable Naming/MethodName
  # rubocop:disable Metrics/AbcSize
  def Rx(theta)
    matrix = Matrix[[cos(theta / 2), -1i * sin(theta / 2)], [-1i * sin(theta / 2), cos(theta / 2)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Naming/MethodName
  # rubocop:disable Metrics/AbcSize
  def Ry(theta)
    matrix = Matrix[[cos(theta / 2), -1 * sin(theta / 2)], [sin(theta / 2), cos(theta / 2)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Naming/MethodName
  def Rz(theta)
    matrix = Matrix[[E**(-1i * theta / 2), 0], [0, E**(-1i * theta / 2)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName

  # rubocop:disable Naming/MethodName
  def R1(theta)
    matrix = Matrix[[1, 0], [0, E**(1i * theta)]]
    @state = (matrix * ket.t).column_vectors[0].to_a
  end
  # rubocop:enable Naming/MethodName
end
