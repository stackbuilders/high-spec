#include "share/atspre_staload.hats"

staload "bookstore.sats"

#define ATS_MAINATSFLAG 1

extern fn should_get_discount:
  {c: customer}{i: int} (customer c, int i) ->
  [b:bool] (CUSTOMER_GETS_DISCOUNT(c,i,b) | bool b)

implement should_get_discount(c,i) =
   case (c, i) of
   | (regular (), _) => (REGULAR | false)
   | (vip(), i)      => if GT_BOOK_THRESHOLD i
                          then (VIP_ENOUGH_BOOKS | true)
                          else (VIP_NOT_ENOUGH_BOOKS | false)

extern fn customer_type: int -> [c:customer] customer(c)
implement customer_type _ = vip ()

extern fn calculate_discount':
  {c: customer}{i:int}
  (CUSTOMER_GETS_DISCOUNT(c,i,true) | int(i)) ->
  discount(i)

implement calculate_discount' (_ |bookCount) =
  g1int_mul2 (bookCount - BOOK_THRESHOLD, DISCOUNT_PERCENTAGE)

extern fn calculate_discount: (int, int) -> int = "mac#"
implement calculate_discount (userid, bookCount) =
  let
    val c = customer_type userid
    val count = g1ofg0 (bookCount)
    val (pf | gets_discount) = should_get_discount (c, count)
  in
    if gets_discount
      then let
            val (_ | discount) = calculate_discount' (pf | count)
           in
            discount
           end
      else 0
  end