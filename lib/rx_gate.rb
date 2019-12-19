# frozen_string_literal: true

# ローテーションゲート
class RxGate
  include Math

  def apply(qubits, target, theta)
    qubits.dup.tap do |qs|
      qs[target].state = (matrix(theta) * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix(theta)
    Matrix[[cos(theta / 2), -1i * sin(theta / 2)], [-1i * sin(theta / 2), cos(theta / 2)]]
  end
end
