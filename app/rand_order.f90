program randint
!! shuffle a list of integers e.g. team number order
use shuffler, only : knuth_shuffle

implicit none

character(3) :: buf

integer :: N, i
integer, allocatable :: A(:)

call get_command_argument(1, buf, status=i)
if(i /= 0) error stop "Enter max integer to generate"

read(buf, '(i3)') N
if(N < 1) error stop "max integer must be positive"

allocate(A(N))

call random_init(.false., .false.)

A = [( i, i=1,N )]

call knuth_shuffle(A)

print *, A

end program
