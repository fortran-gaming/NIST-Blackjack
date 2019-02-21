module game

implicit none
private

integer :: i, cards(52), debug

public :: cards, debug, mix, hand

contains


integer function hand() result(win)

integer :: P,D,pace,dace,cnt
character :: yesno

P=0
D=0
PACE=0
DACE=0
WIN=0

call hit(P,PACE)
call hit(D,DACE)
call hit(P,PACE)
call hit(D,DACE)
cnt = 0

print '(A,I2)', 'Dealer shows: ',cards(i-1)
print '(A,I2,A,I1)', 'Player total: ',P,' incl. # of Aces: ',pace

if (p == 21) then
   print *, 'Player Blackjack!'
   win = 1
else
   cnt = 2
   do
     write(*,'(A)', advance='no') 'Hit?  y / n  '
     read(*,'(A1)') yesno
     if (yesno /= 'y') exit

     call hit(p,pace)
     cnt = cnt+1
     print '(A,I2,A,I1)', 'Player ',P,' # of Aces: ',pace
     if (p > 21) then
       print *, 'player busts -- dealer wins'
       return
     endif
   enddo
endif

if (d == 21) then
  print *, 'Dealer Blackjack'
  if (win == 1) then
    print *,' ---- Push'
    win = 2
    return
  else
    print *, 'Dealer automatically wins'
    return
  endif
else
  if ((p == 21) .or. (cnt >= 5)) then
    print *, 'Player automatically wins'
    win = 1
    return
  endif
endif

print '(A,I2)', 'Dealer has ', D
do while (D <= 16)
  call hit(d,dace)
  print '(A,I2)', 'Dealer has ', D
  if (d > 21) then
    print *,'Dealer busts - Player wins'
    win = 1
    return
  endif
enddo

print '(A,I2,A,I2)', 'Player: ',P,' Dealer: ',D
if (p > d) then
  print *,'Player wins'
  win = 1
else
  print *, 'Dealer wins'
endif

end function hand


subroutine hit(total, aces)

implicit none

integer, intent(inout) :: total, aces

if (debug == 1) then
  write(*,'(A)', advance='no') 'input next card'
  read(*,'(I2)') cards(i)
endif

total = total + cards(i)
if (cards(i) == 11) then
  aces = aces + 1
endif

i = i + 1

if (total > 21 .and. aces >= 1) then
  total = total - 10
  aces = aces - 1
endif

end subroutine hit


integer function mix()
! knuth shuffle
! https://www.rosettacode.org/wiki/Knuth_shuffle#Fortran

real :: r
dimension :: mix(52)
integer :: i, j, temp

mix = &
[2,2,2,2, &
 3,3,3,3, &
 4,4,4,4, &
 5,5,5,5, &
 6,6,6,6, &
 7,7,7,7, &
 8,8,8,8, &
 9,9,9,9, &
 10,10,10,10, 10,10,10,10, 10,10,10,10, 10,10,10,10, &
 11,11,11,11]

do i = size(mix), 2, -1
  call random_number(r)
  j = int(r * i) + 1
  temp = mix(j)
  mix(j) = mix(i)
  mix(i) = temp
end do

end function mix


end module game


program blackjack

use game
implicit none

integer :: win

debug = 0

cards = mix()
print '(52I3)', cards
win = hand()

end program
