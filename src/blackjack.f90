module game

use, intrinsic :: iso_fortran_env, only : stdin=>input_unit, stdout=>output_unit
use, intrinsic :: iso_c_binding, only: c_int

implicit none (type, external)
private

logical :: debug

public :: debug, mix, hand

contains


integer(c_int) function hand(cards) result(win)

integer(c_int), intent(inout) :: cards(52)
integer(c_int) :: P,D,pace,dace,cnt,i,ios
character :: yesno

i=1
P=0
D=0
PACE=0
DACE=0
WIN=0

call hit(P,PACE,i,cards)
call hit(D,DACE,i,cards)
call hit(P,PACE,i,cards)
call hit(D,DACE,i,cards)
cnt = 0

print '(A,I2)', 'Dealer shows: ',cards(i-1)
print '(A,I2,A,I1)', 'Player total: ',P,' incl. # of Aces: ',pace

if (p == 21) then
   print *, 'Player Blackjack!'
   win = 1
else
   cnt = 2
   do
     write(stdout,'(A)', advance='no') 'Hit?  y / n  '
     read(stdin, '(A1)',iostat=ios) yesno
     if(is_iostat_end(ios)) stop 'Goodbye'
     if (yesno /= 'y') exit

     call hit(p,pace,i,cards)
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
  call hit(d,dace,i,cards)
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


subroutine hit(total, aces, i, cards) bind(c)

integer(c_int), intent(inout) :: total, aces, i
integer(c_int), intent(inout) :: cards(52)

if (debug) then
  write(stdout,'(A)', advance='no') 'input next card: '
  read(stdin, '(I2)') cards(i)
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


subroutine mix(cards) bind(c)
! knuth shuffle
! https://www.rosettacode.org/wiki/Knuth_shuffle#Fortran

integer(c_int), intent(out) :: cards(52)
integer(c_int) :: i, j, temp
real :: r

cards = &
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

do i = size(cards), 2, -1
  call random_number(r)
  j = int(r * i) + 1
  temp = cards(j)
  cards(j) = cards(i)
  cards(i) = temp
end do

end subroutine mix


end module game
