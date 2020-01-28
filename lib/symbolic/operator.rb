# frozen_string_literal: true

module Symbolic
  UNDEFINED = :Undefined

  # Symbolic computation operators
  module Operator
    # Returns the base of an ASAE
    #
    # base(u) = | u  when u is a symbol, product, sum, factorial, or function,
    #           | operand(u, 1)  when u is a power,
    #           | Undefined  when u is an integer or fraction
    #
    # Examples:
    #   base(x^2) = x
    #   base(x) = x
    def base(u)
      return u if u.is_a?(Symbol)
      return u if u.is_a?(Array) && u[0] == :*
      return u if u.is_a?(Array) && u[0] == :+
      return u if u.is_a?(Array) && u[0] == :!
      return u if u.is_a?(Array) && u[0] == :f

      return operand(u, 1) if u.is_a?(Array) && u[0] == :^

      return UNDEFINED if u.is_a?(Integer)
      return UNDEFINED if u.is_a?(Array) && u[0] == :fraction
    end

    # Returns the exponent of an ASAE
    #
    # exponent(u) = | 1  when u is a symbol, product, sum, factorial, or function,
    #               | operand(u, 2)  when u is a power,
    #               | Undefined  when u is an integer or fraction
    #
    # Examples:
    #   exponent(x^2) = 2
    #   exponent(x) = 1
    def exponent(u)
      return 1 if u.is_a?(Symbol)
      return 1 if u.is_a?(Array) && u[0] == :*
      return 1 if u.is_a?(Array) && u[0] == :+
      return 1 if u.is_a?(Array) && u[0] == :!
      return 1 if u.is_a?(Array) && u[0] == :f

      return operand(u, 2) if u.is_a?(Array) && u[0] == :^

      return UNDEFINED if u.is_a?(Integer)
      return UNDEFINED if u.is_a?(Array) && u[0] == :fraction
    end

    def operand(u, i)
      u[i]
    end
  end
end
