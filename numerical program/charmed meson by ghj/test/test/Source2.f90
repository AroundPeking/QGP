program main
    external Fiq
    DOUBLE PRECISION Fiq


    write(*,*)Fiq(2.0d0,8)
    write(*,*)Fiq(2.0d0,1)
    end
    
    
    function fik(k,IDP)!AuAu@200GeV at RHIC
    real*8 Ai, ki, ni
    double precision k, fik
 	select case(IDP)
! u quark		
	case(1)
	
	Ai = 9.113d2
	ki = 1.459d0
	ni = 7.679d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! d quark		
	case(2)
	
	Ai = 9.596d2
	ki = 1.467d0
	ni = 7.662d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! ubar quark		
	case(3)
	
	Ai = 2.031d2
	ki = 1.767d0
	ni = 8.546d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! dbar quark		
	case(4)
	
	Ai = 2.013d2
	ki = 1.759d0
	ni = 8.566d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! gluon		
	case(5)
	
	Ai = 4.455d3
	ki = 1.7694
	ni = 8.610d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! s, sbar quark			
	case(6, 7)
	
	Ai = 1.038d2
	ki = 1.868d0
	ni = 8.642d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! c, cbar quark in fik[15]
    case(8, 9)
    
    fik = 19.2*(1+(k/6)**2)/(1+k/3.7)**12/(1+dexp(0.9-2*k))
	
	case default

	print *, "Need to check the parton IDP in fik"
	stop
	
    end select
    return
    end!function fik(k,IDP) end

    function f1ik(k,IDP)!f'ik
    implicit none
    external fik
    double precision k, fik, f1ik
    double precision :: pi=3.141592653589793D0
    real*8 E, m_h
    integer IDP
    if((IDP .eq. 8) .or. (IDP .eq. 9))then !c,cbar
        m_h=1.275
        write(*,*)8
    elseif((IDP .eq. 6) .or. (IDP .eq. 7))then !s,sbar
        m_h=95
    elseif((IDP .eq. 1) .or. (IDP .eq. 3))then !u,ubar
        m_h=2.2
                write(*,*)1
    elseif((IDP .eq. 2) .or. (IDP .eq. 4))then !d,dbar
        m_h=4.7
    elseif(IDP.eq.5)then
        m_h=0.0
    endif
    E=Sqrt(m_h**2+k**2)!£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿£¿
    f1ik = (2*pi)**3/E*fik(k,IDP)
    return
    end!function f1ik(k,IDP)!f'ik end
    
    function Fiq(q,IDP)
    implicit none
    external f1ik!f'ik
    double precision q, fsum, f1ik
    real*8  Fiq
    real*8 :: bL=2.9
    integer IDP

    call integral(q,q*dexp(bL),f1ik,0.000001,fsum,IDP)
    Fiq = 1/bL*fsum
    return
    end!Fiq(q,IDP) end