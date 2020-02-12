# frozen_string_literal: true

module Symbo
  # シンボリックな除算
  class Div
    attr_reader :u
    attr_reader :v

    def initialize(u, v)
      @u = u
      @v = v
    end

    def simplify_quotinent
      if @u.is_a?(Div)
        Div([:*, @u.u, [:^, @u.v, -1]], @v)
      else
        self
      end
    end
  end
end

def Div(u, v) # rubocop:disable Naming/MethodName
  Symbo::Div.new(u, v).simplify_quotinent
end
