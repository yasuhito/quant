# frozen_string_literal: true

require 'symbolic'

# 量子ゲート
class Gate
  using Symbolic

  def apply(qubits, target)
    qubits.dup.tap do |qs|
      qs[target] = Qubit[*(matrix * qs[target].ket.t).column_vectors[0].to_a]
    end
  end
end
