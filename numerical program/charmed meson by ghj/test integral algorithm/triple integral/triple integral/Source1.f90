	module niter
    implicit none

    integer num

    end module niter
    
    program test_integral_algorithm
    use niter
    implicit none
    external f2
    real*8 f2
    real*8 fa,fb,fdel,fsum
    
    write(*,*) "Begin to test triple integral convergence"
    num=200
    !-----------exponential integral algorithm---------------
    fa=0.d0
    fb=1.d0
    fdel=1.d0/num
    fsum=0.d0
    call Integral_1d(f2, fa, fb, fdel, fsum)
    write(*,*) "Following is exponential integral algorithm"
    write(*,*) "step:", num, ", fdel:", fdel
    write(*,*) fsum
    !-----------end:exponential integral algorithm-----------
    !--------------------------------------------------------
    
    
    end!main end
    
    
    function f2(x)
    use niter
    implicit none
    external f1
    real*8 x, f2, fa, fb, fdel, fsum, f1
    
    fa=0.d0
    fb=(1.0d0-x)/2.d0
    fdel=1.d0/num
    fsum=0.d0
    call Integral_2(f1, fa, fb, fdel, x, fsum)
    f2=fsum
    
    return
    end
    
    function f1(x,y)
    use niter
    implicit none
    external fun
    real*8 x,y, f1, fa, fb, fdel, fsum, fun
    
    fa=0.d0
    fb=1.0d0-x-2*y
    fdel=1.d0/num
    fsum=0.d0
    call Integral_1(fun, fa, fb, fdel, x, y, fsum)
    f1=fsum
    
    return
    end
    
    function fun(x,y,z)
    implicit none
    real*8 x,y,z,fun
    
    fun=10**4 *x*y*z
    
    return
    end
!==============================================================================
! one dimensional integral subroutine using expotential integral algorithm
! integral function fnx
! integral range from a to b, and the integral step is del
! momentum p1, p2, p3, pt
! parton ID IDP1, IDP2, IDP3
! centrality centr
! integral result sumf
	            	
	subroutine Integral_1d(fnx, a, b, del, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 sumf
!-------------------------------------------------

	integer NP
	real*8 fa, fb, xi, aa
	integer i

!-------------------------------------------------	
! calculate how many steps we will take

	sumf = 0.0D0
	
	if((b-a)/del-int((b-a)/del).le.0.5D0)then
	NP = int((b-a)/del)
	else
	NP = int((b-a)/del)+1
	endif	
	
!--------------------------------------------------
	xi = a
	fa = fnx(xi)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(xi)
	if(fb.le.0.0D0) fb = 1.0D-18
	
	aa = log(fb/fa)/del
		
	if(abs(aa).lt.0.0001D0)then
	sumf = sumf+fa*del
	else 
	sumf = sumf+(fb-fa)/aa
	
	endif
	
	fa = fb
	
	enddo
	
	return
	
    end
    
    subroutine Integral_1(fnx, a, b, del, x, y, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 sumf
!-------------------------------------------------

	integer NP
	real*8 fa, fb, xi, aa, x, y
	integer i

!-------------------------------------------------	
! calculate how many steps we will take

	sumf = 0.0D0
	
	if((b-a)/del-int((b-a)/del).le.0.5D0)then
	NP = int((b-a)/del)
	else
	NP = int((b-a)/del)+1
	endif	
	
!--------------------------------------------------
	xi = a
	fa = fnx(x,y,xi)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(x,y,xi)
	if(fb.le.0.0D0) fb = 1.0D-18
	
	aa = log(fb/fa)/del
		
	if(abs(aa).lt.0.0001D0)then
	sumf = sumf+fa*del
	else 
	sumf = sumf+(fb-fa)/aa
	
	endif
	
	fa = fb
	
	enddo
	
	return
	
    end
    
    subroutine Integral_2(fnx, a, b, del, x, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 sumf
!-------------------------------------------------

	integer NP
	real*8 fa, fb, xi, aa, x
	integer i

!-------------------------------------------------	
! calculate how many steps we will take

	sumf = 0.0D0
	
	if((b-a)/del-int((b-a)/del).le.0.5D0)then
	NP = int((b-a)/del)
	else
	NP = int((b-a)/del)+1
	endif	
	
!--------------------------------------------------
	xi = a
	fa = fnx(x,xi)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(x,xi)
	if(fb.le.0.0D0) fb = 1.0D-18
	
	aa = log(fb/fa)/del
		
	if(abs(aa).lt.0.0001D0)then
	sumf = sumf+fa*del
	else 
	sumf = sumf+(fb-fa)/aa
	
	endif
	
	fa = fb
	
	enddo
	
	return
	
    end