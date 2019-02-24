program blackjack

use game
implicit none

integer :: win, cards(52)

debug = .false.

call mix(cards)
print '(52I3)', cards
win = hand(cards)

end program
