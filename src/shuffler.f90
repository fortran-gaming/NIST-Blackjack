module shuffler
!! shuffle arrays

use, intrinsic :: iso_c_binding, only : c_int
implicit none
private

public :: knuth_shuffle

contains

subroutine knuth_shuffle(A) bind(c)
!! Knuth shuffle
!! https://www.rosettacode.org/wiki/Knuth_shuffle#Fortran

integer(c_int), intent(inout) :: A(:)

integer(c_int) :: i, j, temp
real :: r

do i = size(A), 2, -1
  call random_number(r)
  j = int(r * i) + 1
  temp = A(j)
  A(j) = A(i)
  A(i) = temp
end do

end subroutine knuth_shuffle

end module shuffler
