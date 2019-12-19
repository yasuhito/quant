# frozen_string_literal: true

# Pauli-X gate
module X
  def x(target)
    matrix = Matrix[[0, 1], [1, 0]]
    @qubits[target].state = (matrix * @qubits[target].ket.t).column_vectors[0].to_a
  end
end
