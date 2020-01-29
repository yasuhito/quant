# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックな積
  class Product
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
      if @operands.first.is_a?(Integer) || @operands.first.is_a?(Fraction)
        Product.new(*@operands[1..-1])
      else
        self
      end
    end

    def const
      if @operands.first.is_a?(Integer) || @operands.first.is_a?(Fraction)
        @operands.first
      else
        1
      end
    end

    def compare(v)
      case v
      when Product
        return @operands.last.compare(v.operands.last) if @operands.last != v.operands.last

        m = length
        n = v.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(v[n - j - 2]) if @operands[m - j - 1] == v[n - j - 1] && @operands[m - j - 2] != v[n - j - 2]
          end
        end

        m.compare(n)
      when Power, Sum, Factorial, Function, Symbol
        compare Product(v)
      end
    end

    def length
      @operands.length
    end

    def [](n)
      @operands[n]
    end

    def ==(other)
      @operands == other.operands
    end

    # # (define (simplify-product u)
    # #  (match u
    # #   ( ('* x) x )
    # #   ( ('* . (? any-are-zero?)) 0 )
    # #   ( ('* . elts)
    # #     (match (simplify-product-rec elts)
    # #       ( () 1 )
    # #       ( (x) x )
    # #       ( xs `(* ,@xs) )) )))
    # def simplify
    #   # ('* x) x
    #   return @operands.first if @operands.size == 1

    #   # ('* . (? any-are-zero?)) 0
    #   return 0 if @operands.any? { |each| each.is_a?(Numeric) && each.zero? }

    #   # ( ('* . elts)
    #   #   (match (simplify-product-rec elts)
    #   #     ( () 1 )
    #   #     ( (x) x )
    #   #     ( xs `(* ,@xs) )) )))
    #   simplify_rec_result = simplify_rec(@operands)

    #   # () 1
    #   return 1 if simplify_rec_result.empty?

    #   # (x) x
    #   return simplify_rec_result.first if simplify_rec_result.size == 1

    #   # xs `(* ,@xs)
    #   Product.new(*simplify_rec_result)
    # end

    # private

    # # (define (simplify-product-rec elts)
    # #  (match elts
    # #   ( (('* . p-elts) ('* . q-elts)) (merge-products p-elts   q-elts)   )
    # #   ( (('* . p-elts) q)             (merge-products p-elts   (list q)) )
    # #   ( (p             ('* . q-elts)) (merge-products (list p) q-elts)   )
    # #   ( ((? number? p) (? number? q)) (list-or-null-if-1 (rnrs:* p q))   )
    # #   ( (1 x) (list x) )
    # #   ( (x 1) (list x) )
    # #   ( (p q) (cond ((equal? (base p) (base q))
    # #                  (list-or-null-if-1
    # #                   (^ (base p)
    # #                    (+ (exponent p)
    # #                     (exponent q)))))
    # #            ((order-relation q p) (list q p))
    # #            (else (list p q))) )
    # #   ( (('* . ps) . qs) (merge-products ps       (simplify-product-rec qs)) )
    # #   ( (x         . xs) (merge-products (list x) (simplify-product-rec xs)) )))
    # def simplify_rec(operands)
    #   # (('* . p-elts) ('* . q-elts)) (merge-products p-elts   q-elts)
    #   return merge_products(operands.first.operands, operands[1].operands) if operands.size == 2 && operands.first.is_a?(Product) && operands[1].is_a?(Product)

    #   # (('* . p-elts) q) (merge-products p-elts (list q))
    #   return merge_products(operands.first.operands, [operands[1]]) if operands.size == 2 && operands.first.is_a?(Product)

    #   # (p ('* . q-elts)) (merge-products (list p) q-elts)
    #   return merge_products([operands.first], operands[1].operands) if operands.size == 2 && operands[1].is_a?(Product)

    #   # ((? number? p) (? number? q)) (list-or-null-if-1 (rnrs:* p q))
    #   return list_or_null_if_1(operands.first * operands[1]) if operands.size == 2 && operands.first.is_a?(Numeric) && operands[1].is_a?(Numeric)

    #   # (1 x) (list x)
    #   return [operands[1]] if operands.size == 2 && operands.first == 1

    #   # (x 1) (list x)
    #   return [operands.first] if operands.size == 2 && operands[1] == 1

    #   # ( (p q) (cond ((equal? (base p) (base q))
    #   #                (list-or-null-if-1
    #   #                 (^ (base p)
    #   #                  (+ (exponent p)
    #   #                   (exponent q)))))
    #   #               ((order-relation q p) (list q p))
    #   #               (else (list p q))) )
    #   if operands.size == 2
    #     p = operands.first
    #     q = operands[1]

    #     if order_relation(q, p) == [p, q]
    #       return [q, p]
    #     else
    #       raise 'Not implemented yet'
    #     end
    #   end

    #   # (('* . ps) . qs) (merge-products ps (simplify-product-rec qs))
    #   if operands.first.is_a?(Product)
    #     ps = operands.first.operands
    #     qs = operands[1..-1]
    #     return merge_products(ps, simplify_rec(qs))
    #   end

    #   # (x . xs) (merge-products (list x) (simplify-product-rec xs))
    #   return merge_products([operands.first], simplify_rec(operands[1..-1])) if operands.size >= 1

    #   raise
    # end

    # # (define (merge-products p-elts q-elts)
    # #  (match (list p-elts q-elts)
    # #   ( (() x) x )
    # #   ( (x ()) x )
    # #   ( ((p . ps) (q . qs))
    # #     (match (simplify-product-rec (list p q))
    # #      ( ()                                (merge-products ps qs)      )
    # #      ( (x)                       (cons x (merge-products ps qs))     )
    # #      ( (? (equal-to (list p q))) (cons p (merge-products ps q-elts)) )
    # #      ( (? (equal-to (list q p))) (cons q (merge-products p-elts qs)) )) )))
    # def merge_products(p_elements, q_elements)
    #   # ((() x) x)
    #   return q_elements if p_elements.empty?

    #   # ((x ()) x)
    #   return p_elements if q_elements.empty?

    #   # ( ((p . ps) (q . qs))
    #   #   (match (simplify-product-rec (list p q))
    #   #    ( ()                                (merge-products ps qs)      )
    #   #    ( (x)                       (cons x (merge-products ps qs))     )
    #   #    ( (? (equal-to (list p q))) (cons p (merge-products ps q-elts)) )
    #   #    ( (? (equal-to (list q p))) (cons q (merge-products p-elts qs)) )) )))

    #   if p_elements.is_a?(Array) && p_elements.size >= 1 && q_elements.is_a?(Array) && q_elements.size >= 1
    #     p = p_elements.first
    #     ps = p_elements[1..-1]
    #     q = q_elements.first
    #     qs = q_elements[1..-1]

    #     match = simplify_rec([p, q])

    #     # () (merge-products ps qs)
    #     return merge_products(ps, qs) if match.empty?

    #     # (x) (cons x (merge-products ps qs))
    #     return match + merge_products(ps, qs) if match.size == 1

    #     # (? (equal-to (list p q))) (cons p (merge-products ps q-elts))
    #     raise 'Not implemented yet: (? (equal-to (list p q))) (cons p (merge-products ps q-elts))' if match == [p, q]

    #     # (? (equal-to (list q p))) (cons q (merge-products p-elts qs))
    #     return [q] + merge_products(p_elements, qs) if match == [q, p]

    #     raise "Not implemented yet: match = #{match.inspect}"
    #   else
    #     raise 'not implemented yet'
    #   end
    # end

    # def list_or_null_if_1(x)
    #   if x == 1
    #     []
    #   else
    #     [x]
    #   end
    # end

    # def order_relation(u, v)
    #   [u, v].sort if u.is_a?(Symbol) && v.is_a?(Symbol)
    # end
  end
end

def Product(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Product.new(*operands)
end
