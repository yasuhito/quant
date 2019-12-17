class MultiQubit
  def self.[](*qubit_state)
    new(*qubit_state)
  end

  def initialize(*qubit_state)
    @qubit_state = qubit_state
  end

  def to_s
    "|#{@qubit_state.join}>"
  end

  def length
    @qubit_state.length
  end
end
