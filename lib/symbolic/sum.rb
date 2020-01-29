# frozen_string_literal: true

require 'symbolic/product'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックな和
  class Sum
    using Symbolic::Refinement

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def base
      self
    end

    def exponent
      1
    end

    def term
      Product(self)
    end

    def const
      1
    end

    def compare(v)
      case v
      when Sum
        return @operands.last.compare(v.operands.last) if @operands.last != v.operands.last

        m = length
        n = v.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(v[n - j - 2]) if @operands[m - j - 1] == v[n - j - 1] && @operands[m - j - 2] != v[n - j - 2]
          end
        end

        m.compare(n)
      when Factorial, Function, Symbol
        compare Sum(v)
      end
    end

    def length
      @operands.length
    end

    def [](n)
      @operands[n]
    end

    def ==(other)
      other.is_a?(Sum) && @operands == other.operands
    end

    # # (define (simplify-sum u)
    # #  (match u
    # #   ( ('+ x) x )
    # #   ( ('+ . elts)
    # #     (match (simplify-sum-rec elts)
    # #      ( () 0 )
    # #      ( (x) x )
    # #      ( xs `(+ ,@xs) )) )))
    # def simplify
    #   p "simplify: @operands=#{@operands.inspect}"

    #   # ('+ x) x
    #   return @operands[0] if @operands.size == 1

    #   simplify_rec_result = simplify_rec(@operands)

    #   # () 0
    #   return 0 if simplify_rec_result.empty?

    #   # (x) x
    #   return simplify_rec_result[0] if simplify_rec_result.size == 1

    #   raise "Not implemented yet: operands=#{@operands.inspect}"
    # end

    # private

    # # (define (simplify-sum-rec elts)
    # #  (match elts
    # #   ( (('+ . p-elts) ('+ . q-elts)) (merge-sums p-elts q-elts)       )
    # #   ( (('+ . p-elts) q)             (merge-sums p-elts (list q))     )
    # #   ( (p ('+ . q-elts))             (merge-sums (list p) q-elts)     )
    # #   ( ((? number? p) (? number? q)) (list-or-null-if-0 (rnrs:+ p q)) )
    # #   ( (0 x) (list x) )
    # #   ( (x 0) (list x) )
    # #   ( (p q) (cond ((equal? (term p) (term q))
    # #                  (list-or-null-if-0
    # #                   (* (term p)
    # #                      (+ (const p)
    # #                         (const q)))))
    # #
    # #                 ((order-relation q p)
    # #                  (list q p))
    # #
    # #                 (else (list p q))) )
    # #   ( (('+ . ps) . qs) (merge-sums ps       (simplify-sum-rec qs)) )
    # #   ( (x         . xs) (merge-sums (list x) (simplify-sum-rec xs)) )))
    # def simplify_rec(operands)
    #   p "simplify_rec(#{operands.inspect})"

    #   # ((? number? p) (? number? q)) (list-or-null-if-0 (rnrs:+ p q))
    #   return list_or_null_if_0(operands[0] + operands[1]) if operands.size == 2 && operands[0].is_a?(Numeric) && operands[1].is_a?(Numeric)

    #   # (0 x) (list x)
    #   return [operands[1]] if operands.size == 2 && operands[0] == 0

    #   # (x 0) (list x)
    #   return [operands[0]] if operands.size == 2 && operands[1] == 0

    #   #   ( (p q) (cond ((equal? (term p) (term q))
    #   #                  (list-or-null-if-0
    #   #                   (* (term p)
    #   #                      (+ (const p)
    #   #                         (const q)))))
    #   #
    #   #                 ((order-relation q p)
    #   #                  (list q p))
    #   #
    #   #                 (else (list p q))) )
    #   if operands.size == 2
    #     p = operands[0]
    #     q = operands[1]

    #     if term(p) == term(q)
    #       list_or_null_if_0(Prod(term(p), Sum(const(p), const(q))))
    #     else
    #       raise 'Not implemented yet: (p q) (cond ...)'
    #     end
    #   end

    #   # (x . xs) (merge-sums (list x) (simplify-sum-rec xs))
    #   if operands.size >= 1
    #     p "(x . xs) operands=#{operands.inspect}"
    #     p "x = #{operands[0].inspect}"
    #     p "xs = #{operands[1..-1].inspect}"

    #     return merge_sums([operands[0]], simplify_rec(operands[1..-1]))
    #   end

    #   raise
    #   # [] # raise "Not implemented yet: simplify_rec(#{operands.inspect})"
    # end

    # # (define (merge-sums p-elts q-elts)
    # #  (match (list p-elts q-elts)
    # #   ( (() x) x )
    # #   ( (x ()) x )
    # #   ( ((p . ps) (q . qs))
    # #     (match (simplify-sum-rec (list p q))
    # #      ( ()                                (merge-sums ps qs)      )
    # #      ( (x)                       (cons x (merge-sums ps qs))     )
    # #      ( (? (equal-to (list p q))) (cons p (merge-sums ps q-elts)) )
    # #      ( (? (equal-to (list q p))) (cons q (merge-sums p-elts qs)) )) )))
    # def merge_sums(p_elements, q_elements)
    #   raise unless p_elements
    #   raise unless q_elements

    #   # (x ()) x
    #   return p_elements if q_elements.empty?

    #   if p_elements.is_a?(Array) && p_elements.size >= 1 && q_elements.is_a?(Array) && q_elements.size >= 1
    #     p = p_elements[0]
    #     ps = p_elements[1..-1]
    #     q = q_elements[0]
    #     qs = q_elements[1..-1]

    #     match = simplify_rec([p, q])

    #     raise "Not implemented yet: match=#{match.inspect}"
    #   end

    #   raise "Not implemented yet: p_elements=#{p_elements.inspect}, q_elements=#{q_elements.inspect}"
    # end

    # def list_or_null_if_0(x)
    #   if x == 0
    #     []
    #   else
    #     [x]
    #   end
    # end

    # # Mathematical Methods 3.2
    # #
    # # term(u) =
    # #   u         (when u is a Sybol, Sum, Power, Factorial, or Function),
    # #   u_2...u_n (when u = u_1...u_n is a Product and u_1 is constant),
    # #   u         (when u = u_1...u_n is a Product and u_1 is not constant),
    # #   undefined (when u is an Integer or Fraction)
    # #
    # # (define (term u)
    # #   (match u
    # #     ( (? number?) #f )
    # #     ( (and ('* u1 . u-rest)
    # #            (? (lambda (_)
    # #                 (number? u1))))
    # #       `(* ,@u-rest) )
    # #     ( ('* . u-elts) u )
    # #     ( else `(* ,u) )))
    # def term(u)
    #   return false if u.is_a?(Numeric)

    #   Prod(u)
    # end

    # # Mathematical Methods 3.2
    # #
    # # const(u) =
    # #   1         (when u is a Sybol, Sum, Power, Factorial, or Function),
    # #   u_1       (when u = u_1...u_n is a Product and u_1 is constant),
    # #   1         (when u = u_1...u_n is a Product and u_1 is not constant),
    # #   undefined (when u is an Integer or Fraction)
    # #
    # # (define (const u)
    # #   (match u
    # #     ( (? number?) #f )
    # #     ( (and ('* u1 . u-rest)
    # #            (? (lambda (_)
    # #                 (number? u1))))
    # #       u1 )
    # #     ( ('* . u-elts) 1 )
    # #     ( else 1 )))
    # def const(u)
    #   return false if u.is_a?(Numeric)
    #   return u.elements[0] if u.is_a?(Product) && u.elements[0].is_a?(Numeric)
    #   return 1 if u.is_a?(Product)

    #   1
    # end
  end
end

def Sum(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Sum.new(*operands)
end
