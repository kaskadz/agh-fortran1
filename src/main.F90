program main
    use utils
    use gauss
    implicit none
    real(kind = my_KIND), allocatable, dimension(:,:) :: A
    real(kind = my_KIND), allocatable, dimension(:) :: X
    real(kind = my_KIND) :: h
    real(kind = ref_KIND), allocatable, dimension(:) :: ERR, REF
    integer(kind=8) :: n, read_status
    character(len=100) :: param

    if (command_argument_count() .EQ. 1) then
        call get_command_argument(1, param)
    else 
        print *, "No n (number of elements) given!"
        error stop
    end if
    
    read(param, *, iostat=read_status) n
    if (read_status .NE. 0) then
        print *, "Error parsing parameter!"
        error stop
    end if
  
    allocate(A(0:n, 0:n))
    allocate(X(0:n))
    allocate(REF(0:n))
    allocate(ERR(0:n))

    ! initialize step size
    h = real(1, kind = my_KIND) / real(n, kind = my_KIND)
  
    ! fill referential vector
    call fill_referential(REF, n)
    ! fill right side vector
    call fill_Y(X, n)
    ! fill matrix
    call fill_matrix(A, n, h)

    ! print *, "h = ", h
    ! print *, "Referential values vector:"
    ! call print_rvec(REF, n)
    ! print *, "Right side vector:"
    ! call print_vec(X, n)
    ! print *, "Matrix:"
    ! call print_matrix(A, n)

    ! print *, "Eliminating..."
    call eliminate(A, X, n)

    ! print *, "Matrix after elimination (should be identity matrix):"
    ! call print_matrix(A, n)

    ! print *, "Result:"
    ! call print_vec(X, n)

    ERR(:) = X - REF
    ! print *, "Error values:"
    call print_rvec(ERR, n)
    ! print *, "kind: ", my_KIND
    ! print *, "n: ", n
    ! print *, "Avg error: ", (SUM(ABS(ERR)) / n)
    print *, my_KIND, n, (SUM(ABS(ERR)) / n)

    if (allocated(A)) deallocate(A)
    if (allocated(X)) deallocate(X)
    if (allocated(REF)) deallocate(REF)
    if (allocated(ERR)) deallocate(ERR)

    contains

    subroutine fill_referential(R, n)
        use utils
        integer(kind = 8), intent(in) :: n
        real(kind = ref_KIND), intent(out) :: R(0:n)
        integer(kind = 8) :: i

        do i = 0, n
            R(i) = real(1, kind=ref_KIND) / real(n, kind=ref_KIND) * i
        end do
    end subroutine fill_referential

    subroutine fill_Y(Y, n)
        use utils
        integer(kind = 8), intent(in) :: n
        real(kind = my_KIND), intent(out) :: Y(0:n)

        Y(:) = real(0, kind=my_KIND)
        Y(n) = real(1, kind=my_KIND)
    end subroutine fill_Y

    subroutine fill_matrix(A, n, h)
        use utils
        integer(kind = 8), intent(in) :: n
        real(kind = my_KIND), intent(out) :: A(0:n, 0:n)
        real(kind = my_KIND) :: h
        real(kind = my_KIND) :: val1, val2
        integer(kind = 8) :: i

        val1 = 1.0 / (h ** 2)
        val2 = val1 * (-2)

        A(:, :) = real(0, kind = my_KIND)
        do i = 1, n - 1
            A(i - 1, i) = val1
            A(i, i) = val2
            A(i + 1, i) = val1
        end do
        A(0, 0) = real(1, kind = my_KIND)
        A(n, n) = real(1, kind = my_KIND)
    end subroutine fill_matrix

end program main