program blackjack

use, intrinsic :: iso_c_binding, only: c_int
use game, only : mix, hand, debug

implicit none

integer(c_int) :: win, cards(52)
character(2) :: argv
integer :: i

call random_init(.false., .false.)

debug = .false.
call get_command_argument(1, argv, status=i)
if(i==0 .and. argv=='-d') debug = .true.

call mix(cards)
print '(52I3)', cards
win = hand(cards)

end program
