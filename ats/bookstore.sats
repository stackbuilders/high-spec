#define DISCOUNT_PERCENTAGE   2 (* percent *)
#define BOOK_THRESHOLD        2 (* books *)
#define LTE_BOOK_THRESHOLD(i) (i <= BOOK_THRESHOLD)
#define GT_BOOK_THRESHOLD(i)  (i > BOOK_THRESHOLD)

datasort customer =
  | vip
  | regular

datatype customer(customer) =
  | vip (vip)
  | regular (regular)

dataprop CUSTOMER_GETS_DISCOUNT(customer, int, bool) =
  | {i:int | GT_BOOK_THRESHOLD i}  VIP_ENOUGH_BOOKS     (vip, i, true)
  | {i:int | LTE_BOOK_THRESHOLD i} VIP_NOT_ENOUGH_BOOKS (vip, i, false)
  | {i:int}                        REGULAR              (regular, i, false)

typedef discount (book_count:int) =
  [res:int] (MUL( book_count - BOOK_THRESHOLD
                , DISCOUNT_PERCENTAGE
                , res
                ) | int(res))