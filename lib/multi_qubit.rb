class MultiQubit
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
