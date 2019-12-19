# ローテーションゲート Z
class RzGate
  include Math

  def initialize(qubits)
    @qubits = qubits.dup
  end

  def apply(target, theta)
    @qubits.tap do |qs|
      qs[target].state = (matrix(theta) * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix(theta)
    Matrix[[E**(-1i * theta / 2), 0], [0, E**(-1i * theta / 2)]]
  end
end
