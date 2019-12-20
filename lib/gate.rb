# frozen_string_literal: true

# 量子ゲート
class Gate
  include Math

  def apply(qubits, target)
    qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
  end
end
