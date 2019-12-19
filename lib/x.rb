# frozen_string_literal: true

# Pauli-X gate
module X
  def x(target)
    matrix = Matrix[[0, 1], [1, 0]]
    qubits = @qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
    self.class.new(*qubits)
  end
end
