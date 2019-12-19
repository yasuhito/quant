# frozen_string_literal: true

# ローテーションゲート
class R1Gate
  include Math

  def apply(qubits, target, theta)
    qubits.dup.tap do |qs|
      qs[target].state = (matrix(theta) * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix(theta)
    Matrix[[1, 0], [0, E**(1i * theta)]]
  end
end
