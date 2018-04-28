module gauss
    use utils
    implicit none

    contains

    subroutine eliminate(A, Y, n)
        integer(kind = 8), intent(in) :: n
        real(kind = my_KIND), intent(inout) :: Y(0:n), A(0:n, 0:n)
        real(kind = my_KIND) :: z
        integer :: i, j

        do i = 0, n
            Y(i) = Y(i) / A(i, i)
            A(:, i) = A(:, i) / A(i, i)
            do j = 0, n
                if ((i .NE. j) .AND. (A(i, i) .NE. 0)) then
                    z = A(i, j) / A(i, i)
                    A(:, j) = A(:, j) - z * A(:, i)
                    Y(j) = Y(j) - z * Y(i)
                end if
            end do
        end do
    end subroutine eliminate

end module gauss