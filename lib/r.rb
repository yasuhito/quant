# frozen_string_literal: true

# ローテーションゲート
module R
  include Math

  # rubocop:disable Metrics/AbcSize
  def rx(target, theta)
    matrix = Matrix[[cos(theta / 2), -1i * sin(theta / 2)], [-1i * sin(theta / 2), cos(theta / 2)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def ry(target, theta)
    matrix = Matrix[[cos(theta / 2), -1 * sin(theta / 2)], [sin(theta / 2), cos(theta / 2)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def rz(target, theta)
    matrix = Matrix[[E**(-1i * theta / 2), 0], [0, E**(-1i * theta / 2)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def r1(target, theta)
    matrix = Matrix[[1, 0], [0, E**(1i * theta)]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
  # rubocop:enable Metrics/AbcSize
end
