	program test_integral_algorithm
    implicit none
    external fun
    real*8 fun,x,q1,q2
    integer i,num
    real*8 fa,fb,fdel,fsum
    
    write(*,*) "Begin to test two integral algorithms"
    num=200
    !-----------exponential integral algorithm---------------
    fa=1.d0
    fb=10.d0
    fdel=1.d0/num!0.005d0
    fsum=0.d0
    call Integral_1d(fun, fa, fb, fdel, fsum)
    write(*,*) "Following is exponential integral algorithm"
    write(*,*) fsum
    !-----------end:exponential integral algorithm-----------
    !--------------------------------------------------------
    
    !-----------trapezoid integral algorithm-----------------
    fsum=0.0d0
    do i=1,num
        q1=fa+i*(fb-fa)/num
        q2=q1+(fb-fa)/num
        fsum=fsum+(fun(q1)+fun(q2))/2*(fb-fa)/num
    enddo
    write(*,*) "Following is trapezoid integral algorithm"
    write(*,*) fsum
    !-----------end:trapezoid integral algorithm-------------
    !--------------------------------------------------------
    
    
    end!main end
    
    
    function fun(x)
    implicit none
    real*8 x,fun
    
    fun=x**2 *dexp(-x)
    
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