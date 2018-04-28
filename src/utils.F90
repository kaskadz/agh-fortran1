#ifndef DKIND
#define DKIND 4
#endif

module utils
implicit none

integer, parameter :: my_KIND = DKIND
integer, parameter :: ref_KIND = 16

contains

subroutine print_vec(V, n)
    integer(kind = 8), intent(in) :: n
    real(kind = my_KIND), intent(in) :: V(0:n)
    integer(kind = 8) :: i

    do i = 0, n
        print *, i, ": ", V(i)
    end do
end subroutine print_vec

subroutine print_rvec(V, n)
    integer(kind = 8), intent(in) :: n
    real(kind = ref_KIND), intent(in) :: V(0:n)
    integer(kind = 8) :: i

    do i = 0, n
        print *, i, ": ", V(i)
    end do
end subroutine print_rvec

subroutine print_matrix(A, n)
    implicit none
    integer(kind = 8), intent(in) :: n
    real(kind = my_KIND), intent(in) :: A(0:n, 0:n)
    integer(kind = 8) :: i

    do i = 0, n
        print *, i, ": ", A(:, i)
    end do
end subroutine print_matrix

end module utils