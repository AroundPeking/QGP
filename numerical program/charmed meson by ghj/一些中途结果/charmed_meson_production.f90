!Fiq used for SS, F1iq used for TS in Shower
!========================================
!    Note(200 GeV)
!1.
!If you would like to change the cutoff(integral interval) the shower SS and TS(S_j) 
!to improve results,Please ctrl+F to find "the cutoff" to change them
!
!Suggested values:
!for Jpsi, we choose q=2.7-30 for SS integral, q=2.8-50 for Shower integral to reproduce.
!for D0, now choose q=3.2-30 for SS integral, q=2.8-50 for Shower integral to reproduce.
!for Ds, now choose q=3.2-30 for SS integral, q=3.0-50 for Shower integral to reproduce.
!
!2.
!for Jpsi bL=0.01 to charm, but bL=2.39 to charm and gluon for D meson
!
!3.
!before run this program, check the energy of system, i.e. /sqrt s_NN=200 GeV, 2.76 TeV, 5.02 TeV, 5.5 TeV
!which will lead to different parameters in fik.
!(parameters for 2.76 and 5.02 are given except for c/cbar, which are linearly interpolated by ln(fik) and sNN between 5.5 and 0.2)
!
!4.SS(2j) should be considered at LHC energy, which is negligible at RHIC energy.
!=====================================================
!Two free parameters to fit
!1.v_T=tanh(eta_T), we will use sinh(eta_T) and cosh(eta_T)
!2.gamac
!
!
! IDP1, parton 1 id
! The parton ID
! 1, 2, 3,    4,    5,   6,  7,     8, 9
! u, d, ubar, dbar, g,   s,  sbar,  c, cbar
! IDmeson, represent the particle
! particle 
! J/psi (c, cbar) (8, 9) --1
! D0  (c,ubar) (8, 3)    --2
! Ds   (c, sbar)  (8, 7) --3
    include "MBSL3.f90"
    include "MBSL4.f90"
    
    module matrics
    implicit none
    
    real*8 MatFiqc(3000,9)
    real*8 MatF1iqc(3000,9)
    
    end module matrics
    
    module charm_dis
    implicit none
    
    real*8 fck_276(3000)
    real*8 fck_502(3000)
    
    end module charm_dis
    
    module limitsHJ
    implicit none

    real*8 plowlim, phighlim

    end module limitsHJ
    
    module Iflag
    implicit none

    integer ISys, IDParticle

    end module Iflag

    program charmed_meson_production
    use limitsHJ
    use Iflag
    use matrics
    use charm_dis
    implicit none
    !include 'Recom.h'

    ! functions to calculate different components for meson
	external meson_TT, meson_TS, meson_SS,int_SS, meson_SS2j
	real*8 meson_TT, meson_TS, meson_SS,int_SS, meson_SS2j
    
    !real*8 Dc,Dg,x
    !external S_ij, thermal,int_Sj,S_j
    !double precision S_ij, thermal,int_Sj,S_j
    real*8 pt, q, dNptdpt(5)   !4 components for meson
    integer IDP1, IDP2, IDmeson
    integer i,j, N
    !-------------------------------------------
    !---------------------------------------------
! scan the parameter space
    REAL*8 DATAX(500), DATAY(500),plow,phigh
    INTEGER IPOINT
    REAL(8) CHISQ
    character(len=7) CollSys
    character(len=4) Collparticle

!-----------------------------------------------------------------------------------------------------------------
!------------------------We only need to change the parameters here------------------------------------------
    ! set up the hard jet momentum limits
    plowlim = 2.0d0
    phighlim = 30.0d0
    
    !System of collision
    ISys = 1 !=0 for AuAu at 200 GeV,  =1 for PbPb at 2.76 TeV, =2 for PbPb at 5.02 TeV
    IDParticle = 1 ! 1 for Jpsi, 2 for D^0, 3 for D_s
    IDmeson=IDParticle!local variable
    
    !set Figure parameters
    phigh=10.20
    plow=0.5
    N=15!number of points
!------------------------(END)We only need to change the parameters here------------------------------------------
!-----------------------------------------------------------------------------------------------------------------
    call Read_fck! initialize fck at 2.76 and 5.02 produced from FONLL
    call Set_Fiqc_Matrix ! initialize MatFiqc
    call Set_F1iqc_Matrix ! initialize MatF1iqc
    
    if(ISys.eq.0)then
    CollSys = 'AuAu200'
    elseif(ISys.eq.1)then
    CollSys = 'PbPb276'
    elseif(ISys.eq.2)then
    CollSys = 'PbPb502'
    else
    print *, 'Which system do you investigate?'
    call sleep(20)
    endif

    print *, 'The study system is: ', CollSys
    
    if(IDParticle.eq.1)then
    Collparticle = 'Jpsi'
    IDP1=8
    IDP2=9
    elseif(IDParticle.eq.2)then
    Collparticle = 'D0__'
    IDP1=8
    IDP2=3
    elseif(IDParticle.eq.3)then
    Collparticle = 'Ds__'
    IDP1=8
    IDP2=7
    else
    print *, 'Which particle do you investigate?'
    call sleep(20)
    endif

    print *, 'The study particle is: ', Collparticle

!	open(unit=101, file='C:\Users\86177\Desktop\innovation\charmed meson program\charm\AuAu200Jpsi_data.dat', status='old')
!	!open(unit=102, file='p05_pb502_chisq.dat',status='unknown')
!
!	IPOINT = 1
!	
!200	READ(101, *, END=210)DATAX(IPOINT), DATAy(IPOINT)
!	PRINT *, IPOINT, DATAX(IPOINT), DATAY(IPOINT)*1.d-6
!	IPOINT = IPOINT + 1
!	GOTO 200
!210	CONTINUE
!
!	IPOINT = IPOINT-1
!    do i=1, IPOINT
!        pt = DATAX(i)
!        dNptdpt(1)  = meson_TT(pt, 8, 9, 1) 
!	    dNptdpt(2)  = meson_TS(pt, 8, 9, 1) 
!	    dNptdpt(3)  = meson_SS(pt, 8, 9, 1) 
!	    dNptdpt(4)  = meson_SS2j(pt, 8, 9, 1)
!	    dNptdpt(5)  = dNptdpt(1)+dNptdpt(2)+dNptdpt(3)+dNptdpt(4)
!
!	!CHISQ = CHISQ + (dNptdpt(5)/DATAY(I)-1.0)**2
!      ! write(*,*) "dNptdpt1"
!       ! write(*,*) dNptdpt(1)
!       ! write(*,*) "dNptdpt2"
!       ! write(*,*) dNptdpt(2)
!      !  write(*,*) "dNptdpt3"
!     !   write(*,*) dNptdpt(3)
!     !   write(*,*) "all:dNptdpt"
!        write(*,*) dNptdpt(5)
!    enddo
!    CHISQ = 0.0
    
    !test SS----------------------------
    !open(unit = 17, file = "SS_Jpsi_c020.dat", status = "unknown")
    !write(17,111)
    !testify thermal-------------------
    !open(unit = 14, file = "Tu_Jpsi_c020.dat", status = "unknown")
    !open(unit = 15, file = "Ts_Jpsi_c020.dat", status = "unknown")
    !open(unit = 16, file = "Tc_Jpsi_c020.dat", status = "unknown")
    !write(14, 98)
    !write(15, 98)
    !write(16, 98)
    !---------------------------------calculate begin-------------------------------------------
    open(unit = 11, file = "dNptdpt_"//Collparticle//"_c020_"//CollSys//".dat", status = "unknown")
    write(11, 108)
    
    do i = 1, N
	    pt = plow+(i-1)*(phigh-plow)/N
        dNptdpt(1)  = meson_TT(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(1)
	    dNptdpt(2)  = meson_TS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(2)
	    dNptdpt(3)  = meson_SS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(3)
	    dNptdpt(4)  = meson_SS2j(pt, IDP1, IDP2, IDmeson)
        write(*,*) pt,dNptdpt(4)
	    dNptdpt(5)  = dNptdpt(1)+dNptdpt(2)+dNptdpt(3)+dNptdpt(4)
        write(*,*) pt,dNptdpt(5)
        
        write(11, 110) pt, dNptdpt(1:5)
    enddo
    !pt=0-10 GeV run 15 points, 10-20 GeV run 2 points.
        pt = 14.0d0
        dNptdpt(1)  = meson_TT(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(1)
	    dNptdpt(2)  = meson_TS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(2)
	    dNptdpt(3)  = meson_SS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(3)
	    dNptdpt(4)  = meson_SS2j(pt, IDP1, IDP2, IDmeson)
        write(*,*) pt,dNptdpt(4)
	    dNptdpt(5)  = dNptdpt(1)+dNptdpt(2)+dNptdpt(3)+dNptdpt(4)
        write(*,*) pt,dNptdpt(5)
        
        write(11, 110) pt, dNptdpt(1:5)
        
        pt = 20.0d0
        dNptdpt(1)  = meson_TT(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(1)
	    dNptdpt(2)  = meson_TS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(2)
	    dNptdpt(3)  = meson_SS(pt, IDP1, IDP2, IDmeson) 
        write(*,*) pt,dNptdpt(3)
	    dNptdpt(4)  = meson_SS2j(pt, IDP1, IDP2, IDmeson)
        write(*,*) pt,dNptdpt(4)
	    dNptdpt(5)  = dNptdpt(1)+dNptdpt(2)+dNptdpt(3)+dNptdpt(4)
        write(*,*) pt,dNptdpt(5)
        
        write(11, 110) pt, dNptdpt(1:5)
    !!---------------------------------calculate end-------------------------------------------
    
    !write(14, 110) pt, Thermal(pt, 1)
    !write(15, 110) pt, Thermal(pt, 6)
    !write(16, 110) pt, Thermal(pt, 8)
    
        !test int_SS ,  integral by person
    !dNptdpt(2)=0
    !dNptdpt(5)=0
    !dNptdpt(1)=0
    !do j=1,1000
    !    if(pt.le.3.5)then
    !        q=4.-1.14286*pt +0.285714*pt**2+(j-1)*(30.0-pt)/1000!3.5+dexp(-pt)+(j-1)*(30.0-pt)/1000
    !    elseif(pt.gt.3.5)then
    !        q=pt+(j-1)*(30.0-pt)/1000
    !    endif
    !    dNptdpt(5) = int_SS(pt,q,1)
    !    dNptdpt(1)=dNptdpt(5)*(30.0-pt)/1000
    !    dNptdpt(2)=dNptdpt(2)+dNptdpt(1)
    !   ! write(*,*)pt, dNptdpt(5) 
    !enddo
    !   ! write(*,*)"all---------------------------"
    !    write(17,110)pt, dNptdpt(2)/pt*(1-dexp(-pt/2.0))
    !
    !enddo
    
    !open(unit = 25, file = "Sj_c.dat", status = "unknown")
    !write(25,112)
    !do i=1,1000
    !    pt=2.3+0.048*i
    !    dNptdpt(1)=S_j(pt,8)
    !    write(25,110)2+0.048*i,dNptdpt(1)
    !enddo
    
    !open(unit = 26, file = "Sj_c020.dat", status = "unknown")
    !write(26,113)
    !do i=1,1000
    !    pt=0.05+i*6.5/1000
    !    dNptdpt(1)=S_j(pt,9)
    !    write(26,110)pt,dNptdpt(1)
    !enddo
    
    !having testified D and SPD right
    !open(unit = 12, file = "Dc_Jpsi_c020.dat", status = "unknown")
    !write(12, 100)
    !open(unit = 13, file = "Dg_Jpsi_c020.dat", status = "unknown")
    !write(13, 100)
    !open(unit = 55, file = "S_c_cbar_Jpsi_c020.dat", status = "unknown")
    !open(unit = 66, file = "S_g_ccbar_Jpsi_c020.dat", status = "unknown")
    !open(unit = 77, file = "S_c_l_Jpsi_c020.dat", status = "unknown")
    !open(unit = 88, file = "S_c_c_Jpsi_c020.dat", status = "unknown")
    !do i=1, 100
    !    x=0+0.01*i
    !    Dc=0.5/x*                                            &
    !    ( S_ij(x/2,8,8)*S_ij(x/(2-x),8,9)+S_ij(x/2,8,9)*S_ij(x/(2-x),8,8))
    !    Dg=0.5/x*                                                   &
    !    ( S_ij(x/2,5,8)*S_ij(x/(2-x),5,9)+S_ij(x/2,5,9)*S_ij(x/(2-x),5,8))
    !    write(12,110)x,Dc
    !    write(13,110)x,Dg
        !write(55,110)x,S_ij(x,8,9)
        !write(66,110)x,S_ij(x,5,8)
        !write(77,110)x,S_ij(x,8,1)
        !write(88,110)x,S_ij(x,8,8)
    !enddo
!99  format(10x, "%x", 12x, "S_c_cbar/S_g_ccbar/S_c_l/S_c_c")
!100 format(10x, "%x", 12x, "Dc/Dg")
!98  format(10x, "%x", 12x, "T")
!111  format(10x, "%pt", 12x, "SS(by person)")
!112 format(10x, "%pt", 12x, "int_Sj")
!113 format(10x, "%pt", 12x, "Sj")
108 format(10x, "%pt", 12x, "TT", 12x,  "TS", 12x,  "SS", 12x,  "SS2j", 12x, "Tot")
110	format((1x, F12.3), 5(1x, ES14.5E2)) 

    end!!!!!!!!!!!!main program end
    
    
    !=======================================================
	! meson spectrum from TT
	function meson_TT(pt, IDP1, IDP2, IDmeson)
    use Iflag
	implicit none
	!include 'Recom.h'
	
	real*8 meson_TT
	real*8 pt
	integer IDP1, IDP2, IDmeson, i
    double precision :: pi=3.141592653589793D0
	real*8 gamc, gams, gaml, T
    real*8 :: C_M=(2*3)**2
    real*8 x, M_T, m_h, tau, A_T, mc, mu, ms, resu, q,tmp,eta
    integer ierr, nz
    
    external MBSL3,MBSL4
    double precision MBSL3,MBSL4, Ir,Kr,Kr2, I0,K1,K1_2
    !200 GeV for J/psi vT=tanh(etaT)=0.3c,  gamc=0.26        eta=0.30952
    !200 GeV for D0    vT=tanh(etaT)=0.42c, gamc=0.26        eta=0.447692

    if(ISys.eq.0)then!200 GeV
        gaml=1.d0
        gamc=0.26d0
        gams=0.8d0
        T=0.175
    elseif(ISys.eq.1)then!2.76 TeV
        gaml=1.d0
        gamc=0.26d0        !gamc=0.26d0!200 GeV
        gams=0.8d0
        T=0.185!J/psi
    elseif(ISys.eq.2)then!5.02 TeV
        gaml=1.0d0
        gamc=0.39d0!test for 5.02 TeV
        gams=0.8d0
        T=0.19d0!different for various mesons
    endif
    
!----------------------------------------------	for J/psi
	if(IDmeson.eq.1)then ! for J/psi
    m_h=3.097
    if(ISys.eq.0)then!200 GeV
        mc=1.50d0
    else
        mc=1.28
    endif
    M_T=Sqrt(m_h**2+pt**2)
    tau=25.34d0
    A_T=(45.61d0)**2*pi
    x=0.5d0!wavefunction**2 = delta(x-0.5) for J/psi
    
    !----------------free parameters for TT/TS (v_T=tanh eta_T)-----------------------------
    if(ISys.eq.0)then
        eta=0.30952d0
    elseif(ISys.eq.1)then
        eta=0.255413
    elseif(ISys.eq.2)then
        eta=0.255413
        T=0.19d0
    endif

    Ir=sinh(eta)*pt/T                                                       !test for 2.76 TeV(vT=0.1)
    !Ir=sinh(0.30952)*pt/T                                                  !for 200 GeV and 5.5 TeV(vT=0.3)
    Kr=cosh(eta)*(Sqrt(mc**2+(x*pt)**2)+Sqrt(mc**2+((1-x)*pt)**2))/T        !test for 2.76 TeV(vT=0.1)
    !Kr=cosh(0.30952)*(Sqrt(mc**2+(x*pt)**2)+Sqrt(mc**2+((1-x)*pt)**2))/T   !for 200 GeV(vT=0.3)
    !----------------free parameters for TT/TS (v_T=tanh eta_T)-----------------------------
	I0=MBSL3(0,Ir)
    K1=MBSL4(1,Kr)

	meson_TT = C_M*M_T*tau*A_T/(2*pi)**3*2*gamc*gamc*I0*K1!over

!-------------------------------------------	for D0
    elseif(IDmeson.eq.2)then ! for D0
    m_h=1.8
    M_T=Sqrt(m_h**2+pt**2)
    tau=25.34d0
    A_T=(45.61d0)**2*pi
    if(ISys.eq.0)then!200 GeV
        mc=1.5
    else
        mc=1.28
    endif
    mu=0.26
 !----------------free parameters for TT/TS (v_T=tanh eta_T)-----------------------------
    if(ISys.eq.0)then
        eta=0.447692
    elseif(ISys.eq.1)then
        T=0.185d0
        eta=0.459897
    elseif(ISys.eq.2)then
        eta=0.549306
        T=0.175d0
    endif
    resu=0.d0
    
		do i=1,1000
            x=i*(1.-0.)/1000
            tmp=x+(1.-0.)/1000
            Ir=sinh(eta)*pt/T
            Kr=cosh(eta)*(Sqrt(mu**2+(x*pt)**2)+Sqrt(mc**2+((1-x)*pt)**2))/T
            Kr2=cosh(eta)*(Sqrt(mu**2+(tmp*pt)**2)+Sqrt(mc**2+((1-tmp)*pt)**2))/T
            I0=MBSL3(0,Ir)
            K1=MBSL4(1,Kr)
            K1_2=MBSL4(1,Kr2)
            resu=resu+5*( K1*(1-x)**4 + K1_2*(1-(tmp))**4 )*(1.-0.)/1000/2
        enddo
	meson_TT =  C_M*M_T*tau*A_T/(2*pi)**3*2*gamc*gaml*I0*resu
	
!-------------------------------------------	for Ds
	elseif(IDmeson.eq.3)then ! for Ds
	m_h=1.96
    M_T=Sqrt(m_h**2+pt**2)
    tau=25.34d0
    A_T=(45.61d0)**2*pi
    if(ISys.eq.0)then!200 GeV
        mc=1.5
    else
        mc=1.28
    endif
    ms=0.46
 !----------------free parameters for TT/TS (v_T=tanh eta_T)-----------------------------
    if(ISys.eq.0)then
        eta=0.447692
    elseif(ISys.eq.1)then
        eta=0.30952
        T=0.185d0
    elseif(ISys.eq.2)then
        eta=0.30952
        T=0.175d0
    endif

    resu=0.d0
    
		do i=1,1000
            x=i*(1.-0.)/1000
            tmp=x+(1.-0.)/1000
            Ir=sinh(eta)*pt/T
            Kr=cosh(eta)*(Sqrt(ms**2+(x*pt)**2)+Sqrt(mc**2+((1-x)*pt)**2))/T
            Kr2=cosh(eta)*(Sqrt(ms**2+(tmp*pt)**2)+Sqrt(mc**2+((1-tmp)*pt)**2))/T
            I0=MBSL3(0,Ir)
            K1=MBSL4(1,Kr)
            K1_2=MBSL4(1,Kr2)
            
            resu=resu+660*( K1*x**2 *(1-x)**9 + K1_2*tmp**2 *(1-(tmp))**9 )*(1.-0.)/1000/2
        enddo
	meson_TT =  C_M*M_T*tau*A_T/(2*pi)**3*2*gamc*gams*I0*resu
	
	endif
	
	return

    end!meson_TT end
	
	function meson_TS(pt, IDP,IDP2, IDmeson)	
    use Iflag
	implicit none
!	include 'Recom.h'
	
	real*8 meson_TS
	real*8 pt, C_M, gamc,gaml,gams,fa, fb, fdel, fsum
	integer IDP, IDP2, IDmeson,g,i,num
    external Thermal, S_j, int_mesonTS
    double precision Thermal, S_j, int_mesonTS
    real*8 x,tmp
    
    fa=0.0d0
    fb=1.0d0
    fdel=0.01d0
    fsum=0.d0
    C_M=(2*3)**2
    g=6
    if(ISys.eq.0)then!200 GeV
        gaml=1.d0
        gamc=0.26d0
        gams=0.8d0
    elseif(ISys.eq.1)then!2.76 TeV
        gaml=1.d0
        gamc=0.26d0
        gams=0.8d0
    elseif(ISys.eq.2)then!5.02 TeV
        gaml=1.0d0
        gamc=0.39d0!test for 5.02 TeV
        gams=0.8d0
    endif

!------------------------------------------------------------	for J/psi
	if(IDmeson .eq.1)then !for J/psi

	meson_TS = C_M/g/gamc*2*    &
    (S_j(pt/2.0,IDP)*Thermal(pt/2.0,IDP2)+S_j(pt/2.0,IDP2)*Thermal(pt/2.0,IDP))
    !(1-dexp(-pt/2.0))*C_M/g/gamc*2*    &
    !(S_j(pt/2.0,IDP)*Thermal(pt/2.0,IDP2)+S_j(pt/2.0,IDP2)*Thermal(pt/2.0,IDP))
	
!-----------------------------------------------------------		for D0
    elseif(IDmeson.eq.2)then !for D0
    !num=200
    !do i=1,num
    !    x=i*(fb-fa)/num
    !    tmp=x+(fb-fa)/num
    !    fsum=fsum+(int_mesonTS(x,pt,IDmeson)+int_mesonTS(tmp,pt,IDmeson))/2*(fb-fa)/num
    !enddo
    !----------Issue!exponential algorithm doesnot work!-----------------------------------
    !----------The first integral point determines the order of magnitude for TS.----------
    !----------So in function meson_TS D0, 1.d-10 leads to large TS------------------------
	call Integral_1d(int_mesonTS,fa,fb,fdel,pt,IDmeson,fsum)
    meson_TS = C_M/g *5*fsum!*(1-dexp(-pt/2.0))
	
!-----------------------------------------------------------		for Ds
    elseif(IDmeson.eq.3)then ! for Ds
	
    call Integral_1d(int_mesonTS,fa,fb,fdel,pt,IDmeson,fsum)
    meson_TS = C_M/g *660*fsum!*(1-dexp(-pt/2.0))
	
	endif
	
	return
	
    end ! end meson_TS

!---------------------------------------------------
    function meson_SS(pt, IDP,IDP2, IDmeson)	
    use limitsHJ
	implicit none
!	include 'Recom.h'
	external int_SS
	real*8 meson_SS
	real*8 pt, m_h,p0,fdel,fa,fb,fsum
	integer IDP, IDP2, IDmeson
    double precision int_SS
    
    if((IDmeson .eq. 1))then !jpsi
        m_h=3.097
    elseif(IDmeson.eq.2)then !D0
        m_h=1.8
    elseif(IDmeson.eq.3)then !D0
        m_h=1.96
    endif
    p0=Sqrt(m_h**2+pt**2)
    fdel=0.02d0
    fsum=0.0d0

    fa=plowlim!the cutoff
    fb=phighlim
    if(pt.gt.fa) then
        fa = pt
    endif

!------------------------------------------------------------	for J/psi
	if(IDmeson .eq.1)then !for J/psi
	
    call Integral_1d(int_SS,fa,fb,fdel,pt,IDmeson,fsum)
    
    meson_SS = (fsum)/p0!(1-dexp(-pt/2.0))*(fsum)/p0
	!(1-dexp(-pt/2.0))*   S_j(pt/2,8)*S_j(pt/2,9)
!------------------------------------------------------------	for D0

    elseif(IDmeson.eq.2)then !for D0
        
    call Integral_1d(int_SS,fa,fb,fdel,pt,IDmeson,fsum)
    
	meson_SS = (fsum)/p0!*(1-dexp(-pt/2.0))!*(fsum)/p0
	
!------------------------------------------------------------	for Ds
    elseif(IDmeson.eq.3)then ! for Ds
    
    call Integral_1d(int_SS,fa,fb,fdel,pt,IDmeson,fsum)
    
	meson_SS = (fsum)/p0 !(1-dexp(-pt/2.0))*(fsum)/p0 
	endif
	
	return
    end ! end meson_SS
!---------------------------------------------------
!---------------------------------------------------
    function meson_SS2j(pt, IDP1,IDP2, IDmeson)	
    use limitsHJ
	implicit none
!	include 'Recom.h'
	external int_SS2j,Int_HardInt
	real*8 meson_SS2j
	real*8 pt, m_h, p0, k1, k2
	integer IDP1, IDP2, IDmeson, j, ni
    double precision fa,fb,fdel,fsum,fsum1,fsum2, int_SS2j,Int_HardInt
    
    if((IDmeson .eq. 1))then !jpsi
        m_h=3.097
    elseif(IDmeson.eq.2)then !D0
        m_h=1.8
    elseif(IDmeson.eq.3)then !Ds
        m_h=1.96
    endif
    p0=Sqrt(m_h**2+pt**2)
    fdel=0.1d0
    fsum=0.0d0
    fsum1=0.0d0
    fsum2=0.0d0
    
    fa=plowlim
    fb=phighlim
    
    !if(pt.ge.fa) then
    !    fa = pt
    !endif

!------------------------------------------------------------	for J/psi
	if(IDmeson .eq.1)then !for J/psi
        if(pt/2.0.ge.fa) then
            fa = pt/2.0
        endif
        
        call Integral_1d(Int_HardInt,fa,fb,fdel,pt/2.,IDP1,fsum1)
        call Integral_1d(Int_HardInt,fa,fb,fdel,pt/2.,IDP2,fsum2)
        
        fsum=fsum1*fsum2
    
	meson_SS2j = (fsum)/p0/pt*10.**(-2)!(1-dexp(-pt/2.0))*(fsum)/p0/pt*10.**(-2)

!------------------------------------------------------------	for D0
	elseif(IDmeson.eq.2)then !for D0
        if(pt.ge.fa) then
            fa = pt
        endif
        ni=500
        do j=1,ni
            k1=fa+j*(fb-fa)/ni
            k2=k1+(fb-fa)/ni
            call Integral_intSS2j(int_SS2j,fa,fb,fdel,pt,k1,IDmeson,fsum1)!integral over q
            call Integral_intSS2j(int_SS2j,fa,fb,fdel,pt,k2,IDmeson,fsum2)!integral over q
            fsum=fsum+(fsum1+fsum2)/2*(fb-fa)/ni
            fsum1=0.d0
            fsum2=0.d0
        enddo
	meson_SS2j = (fsum)/p0/pt**6*5*10.**(-2)!(1-dexp(-pt/2.0))*(fsum)/p0/pt**6*5*10.**(-2)
	
!------------------------------------------------------------	for Ds
    elseif(IDmeson.eq.3)then ! for Ds
        if(pt.ge.fa) then
            fa = pt
        endif
        ni=500
        do j=1,ni
            k1=fa+j*(fb-fa)/ni
            k2=k1+(fb-fa)/ni
            call Integral_intSS2j(int_SS2j,fa,fb,fdel,pt,k1,IDmeson,fsum1)!integral over q
            call Integral_intSS2j(int_SS2j,fa,fb,fdel,pt,k2,IDmeson,fsum2)!integral over q
            fsum=fsum+(fsum1+fsum2)/2*(fb-fa)/ni
            fsum1=0.d0
            fsum2=0.d0
        enddo
	meson_SS2j = (fsum)/p0/pt**13*660*10.**(-2)!(1-dexp(-pt/2.0))*(fsum)/p0/pt**13*660*10.**(-2)
    endif
    
	return
    end ! end meson_SS(2j)
!---------------------------------------------------
!---------------------------------------------------
    function Thermal(pt, IDP)
    use Iflag
    implicit none
    double precision thermal
    real*8  m_T, m_h, gama, T,pt, eta
    integer :: g=6
    integer IDP
    double precision :: pi=3.141592653589793D0
    
    external MBSL3,MBSL4
    double precision MBSL3,MBSL4, Ir,Kr, I0,K1

    if(ISys.eq.0)then
        T=0.175d0
    elseif(ISys.eq.1)then
        T=0.185d0
    elseif(ISys.eq.2)then
        T=0.19d0!different for various mesons
    endif
    !for J/psi vT=tanh(etaT)=0.3c,  gamc=0.26        eta=0.30952
    !for D0    vT=tanh(etaT)=0.42c, gamc=0.26        eta=0.447692
    if((IDP .eq. 8) .or. (IDP .eq. 9))then !c,cbar
        if(ISys.eq.0)then
            eta=0.30952d0
            gama=0.26d0    
        elseif(ISys.eq.1)then
            eta=0.255413
            gama=0.26!2.76 TeV
            !gama=0.26!200 GeV and 5.5 TeV
        elseif(ISys.eq.2)then
            eta=0.255413
            gama=0.39!5.02 TeV
        endif
        if(ISys.eq.0)then!200 GeV
            m_h=1.50d0
        else
            m_h=1.28
        endif
        m_T=Sqrt(m_h**2+pt**2)
        Ir=sinh(eta)*pt/T
        Kr=cosh(eta)*m_T/T
        
        !Ir=sinh(0.30952)*pt/T!200 GeV
        !Kr=cosh(0.30952)*m_T/T!200 GeV
    elseif((IDP .eq. 6) .or. (IDP .eq. 7))then !s,sbar
        if(ISys.eq.0)then
            eta=0.447692
            gama=0.8
        elseif(ISys.eq.1)then
            eta=0.30952
            gama=0.8!2.76 TeV
        elseif(ISys.eq.2)then
            eta=0.30952
            gama=0.8!5.02 TeV
            T=0.175d0
        endif
        m_h=0.46
        m_T=Sqrt(m_h**2+pt**2)
        Ir=sinh(eta)*pt/T
        Kr=cosh(eta)*m_T/T
    elseif((IDP .eq. 1) .or. (IDP .eq. 3).or.(IDP .eq. 2) .or. (IDP .eq. 4))then !u,ubar,d,dbar
        if(ISys.eq.0)then
            eta=0.447692
            gama=1.d0
        elseif(ISys.eq.1)then
            eta=0.255413d0
            gama=1.d0!2.76 TeV
            T=0.16d0
        elseif(ISys.eq.2)then
            eta=0.15d0
            gama=1.0d0!5.02 TeV
            T=0.16d0
        endif
        m_h=0.26
        m_T=Sqrt(m_h**2+pt**2)
!----------------------------------------200 GeV
        !eta=0.447692
!----------------------------------------
        Ir=sinh(eta)*pt/T
        Kr=cosh(eta)*m_T/T
    endif
    
    I0=MBSL3(0,Ir)
    K1=MBSL4(1,Kr)
    
    Thermal = 2*g*gama*m_T/(2*pi)**3*I0*K1

    return
    end!function thermal(pt,IDP) end
    
    function int_mesonTS(x, pt, IDmeson)
    use Iflag
    implicit none
    integer IDmeson, IDP1, IDP2
    real*8 x, pt, gaml, gamc, gams
    external Thermal,S_j
    double precision Thermal,S_j, int_mesonTS

    if(ISys.eq.0)then!200 GeV
        gaml=1.d0
        gamc=0.26d0
        gams=0.8d0
    elseif(ISys.eq.1)then!2.76 TeV
        gaml=1.d0
        gamc=0.26d0
        gams=0.8d0
    elseif(ISys.eq.2)then!5.02 TeV
        gaml=1.0d0
        gamc=0.39d0
        gams=0.8d0
    endif
    !-----------prevent from NaN---------
    if(x.ge.0.9999D0) x = 0.9999D0
	if(x.le.1.0D-6) x = 1.0D-6
    !-----------prevent from NaN---------
    if(IDmeson.eq.2)then
        IDP1=8
        IDP2=3
        int_mesonTS=( Thermal(pt*x,IDP2)*S_j(pt*(1.0d0-x),IDP1)/gaml/x              &
                    +S_j(pt*x,IDP2)*Thermal(pt*(1.0d0-x),IDP1)/gamc/(1.0d0-x) )*(1.0d0-x)**4
        
        if(x .eq. 1.0D-6) int_mesonTS=0.0d0!abondon the first point 0.0d0
        
        
    elseif(IDmeson.eq.3)then
        IDP1=8
        IDP2=7
        int_mesonTS=( Thermal(pt*x,IDP2)*S_j(pt*(1.0d0-x),IDP1)/gams/x              &
            +S_j(pt*x,IDP2)*Thermal(pt*(1.0d0-x),IDP1)/gamc/(1.0d0-x) )*x**2 *(1.0d0-x)**9
    endif
    
    return
    end!function int_mesonTS(x, pt, IDP) end
    
    
    !---------SPD Q=2m_c=3---------------------------------------------------
    function S_ij(z, IDP1, IDP2)!!IDP1:inside i; IDP2:outside j
    implicit none
    integer IDP1, IDP2
    real*8 z, s1, s2, S_ij, A0, a, b, c, d
    s1=0.d0
    s2=0.d0
    
    if(z.ge.0.9999D0) z = 0.9999D0
	if(z.le.1.0D-6) z = 1.0D-6
    
    if(IDP1.eq.5)then!i=g
        if((IDP2.eq.8) .or. (IDP2.eq.9))then!j=c,cbar
            A0=5.020d-3
            a=0.702
            b=1.201
            c=1.952
            d=4.415
        elseif((IDP2.eq.1) .or. (IDP2.eq.2) .or. (IDP2.eq.3) .or. (IDP2.eq.4))then!j=u,d,ubar,dbar
            A0=0.919
            a=-0.0646
            b=2.0425
            c=-0.977
            d=1.528
        elseif((IDP2.eq.6) .or. (IDP2.eq.7))then!j=s,sbar
            A0=0.0151
            a=-0.8754
            b=2.128
            c=3.7674
            d=1.148
        endif
    elseif(IDP1.eq.8)then!i=c
        if((IDP2.eq.1) .or. (IDP2.eq.2) .or. (IDP2.eq.3) .or. (IDP2.eq.4))then!j=u,d,ubar,dbar
            A0=2.185
            a=0.102
            b=4.017
            c=-0.879
            d=1.066
        elseif(IDP2.eq.8)then!j=c
            A0=6.483
            a=2.526
            b=2.375
            c=22.819
            d=3.233
        elseif(IDP2.eq.9)then!j=cbar
            A0=5.879d-4
            a=0.315
            b=2.577
            c=23.505
            d=16.078
        elseif((IDP2.eq.6) .or. (IDP2.eq.7))then!j=s,sbar
            A0=0.118
            a=-0.138
            b=2.3
            c=0.9
            d=0.1
        endif
    elseif(IDP1.eq.1)then
        if(IDP2.eq.3)then!S_u_ubar
            A0=0.7316
            a=-0.0813
            b=3.22
            c=5.5386
            d=5.1416
        elseif(IDP2.eq.7)then!S_u_sbar
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
        endif
    elseif(IDP1.eq.2)then
        if(IDP2.eq.3)then!S_d_ubar
            A0=0.7316
            a=-0.0813
            b=3.22
            c=5.5386
            d=5.1416
        elseif(IDP2.eq.7)then!S_d_sbar
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
        endif
    elseif(IDP1.eq.3)then
        if(IDP2.eq.3)then!S_ubar_ubar=K_NS+L=K
            A0=0.0101
            a=0.0256
            b=1.3418
            c=174.471
            d=1.093
            s1=A0*z**a*(1-z)**b*(1+c*z**d)!K_NS
            A0=0.7316
            a=-0.0813
            b=3.22
            c=5.5386
            d=5.1416
            s2=A0*z**a*(1-z)**b*(1+c*z**d)!L
        elseif(IDP2.eq.7)then!S_ubar_sbar
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
        endif
    elseif(IDP1.eq.4)then
        if(IDP2.eq.3)then!S_dbar_ubar
            A0=0.7316
            a=-0.0813
            b=3.22
            c=5.5386
            d=5.1416
        elseif(IDP2.eq.7)then!S_dbar_sbar
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
        endif
    elseif(IDP1.eq.6)then
        if(IDP2.eq.7)then!S_s_sbar
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
        endif
    elseif(IDP1.eq.7)then
        if(IDP2.eq.7)then!S_sbar_sbar
            A0=0.0101
            a=0.0256
            b=1.3418
            c=174.471
            d=1.093
            s1=A0*z**a*(1-z)**b*(1+c*z**d)!K_NS
            A0=2.0842
            a=0.8722
            b=8.377
            c=94.412
            d=3.0606
            s2=A0*z**a*(1-z)**b*(1+c*z**d)!L_s
        endif
    else
        print *, 'Encounter undefined i,j in SPD/S_ij'
        stop
    endif
    
    if(s1.eq.0.d0)then
        S_ij = A0*z**a*(1-z)**b*(1+c*z**d)
    else
        S_ij = s1+s2
    endif
            
    return
    end!function Shower_ij(z, IDP1, IDP2) end
    
    function Sij(p2,q,IDP1,IDP2)!SPD*QuenchSPD
    use Iflag
    implicit none
    integer IDP1, IDP2
    real*8 p2, q
    external S_ij
    real*8 S_ij,c2,pc,Sij
    
    if(Isys.eq.0)then
	c2 = 1.0D0 - dexp(-(p2/0.3D0)**2) ! for AuAu at 200 GeV
    elseif(Isys.eq.1)then
	c2 = 1.0D0 - dexp(-(p2/0.5D0)**2) ! for PbPb at 2.76 TeV
    !c2 = 1.0d0
    elseif(Isys.eq.2)then
    c2 = 1.0D0 - dexp(-(p2/0.5D0)**2) ! for PbPb at 5.02 TeV Should be modified or not?
    else
    print *, 'Check your values of IYangZhu and ISys'
    print *, 'In QuenchSPD'
    stop
    endif
    
    !pc=0.5d0
    !c2=1-dexp(-(p2/pc)**2)
    !c2=1.d0
    Sij=S_ij(p2/q,IDP1,IDP2)*c2
    end

    function S_j(pt, IDP2)
    use limitsHJ
    implicit none

    integer IDP2
    external int_Sj
    real*8 pt, S_j, fa, fb, fdel, int_Sj, fsum
    
    fa=plowlim
    fb=phighlim
    fdel=0.01d0
    fsum=0.d0
    S_j=0.0d0
    if(pt.gt.fa) then
        fa = pt
    endif
    
    call Integral_1d(int_Sj,fa,fb,fdel,pt,IDP2,fsum)
    
    S_j=fsum
    
    return
    end!function S_j(pt, IDP2) end
    
    function int_Sj(q, pt, IDP)!function for integral
    implicit none
    external F1iq, Sij
    real*8 F1iq, Sij, pt, q
    double precision int_Sj
    integer IDP
    
    if(IDP .eq. 8)then!S_c from g/c
        int_Sj = (F1iq(q, 8)*Sij(pt,q, 8, 8)+ F1iq(q, 5)*Sij(pt,q, 5,8))/q
    elseif(IDP .eq. 9)then!S_cbar from g/c
        int_Sj = (F1iq(q, 8)*Sij(pt,q, 8, 9)+ F1iq(q, 5)*Sij(pt,q, 5,9))/q
    elseif(IDP .eq. 3)then!S_ubar from light(bar)/g
        !int_Sj =( Fiq(q, 1)*Sij(pt,q, 1, 3)+ Fiq(q, 2)*Sij(pt,q, 2, 3)  &
        !        + Fiq(q, 3)*Sij(pt,q, 3, 3)+ Fiq(q, 4)*Sij(pt,q, 4, 3)  &
        !        + Fiq(q, 5)*Sij(pt,q, 5, 3) )/q
        int_Sj = (F1iq(q, 8)*Sij(pt,q, 8, 3)+ F1iq(q, 5)*Sij(pt,q, 5,3))/q
        
        !------useless because kns et al are at Q=10
        !int_Sj = (                                                                                           &
        !            (kns(pt/q)+ll(pt/q))*Fiq(q,3)+ll(pt/q)*(Fiq(q,1)+Fiq(q,2)+Fiq(q,4))+gg(pt/q)*Fiq(q,5)    &
        !            )/q
        
    elseif(IDP .eq. 7)then!S_sbar from light(bar)/g/s(bar)
        !int_Sj =( Fiq(q, 1)*Sij(pt,q, 1, 7)+ Fiq(q, 2)*Sij(pt,q, 2, 7)  &
        !        + Fiq(q, 3)*Sij(pt,q, 3, 7)+ Fiq(q, 4)*Sij(pt,q, 4, 7)  &
        !        + Fiq(q, 5)*Sij(pt,q, 5, 7)+ Fiq(q, 6)*Sij(pt,q, 6, 7)  &
        !        + Fiq(q, 7)*Sij(pt,q, 7, 7))/q
        int_Sj = (F1iq(q, 8)*Sij(pt,q, 8, 7)+ F1iq(q, 5)*Sij(pt,q, 5,7))/q
        
    endif

    return
    end!end int_Sj(pt,q, IDP)
    
    
!------------------------------------------------------------------------
	subroutine Read_fck
    use charm_dis
	implicit none
	integer IK
	real*8 k, i
	
	print *, 'Reading charm fik at 2.76 and 5.02 from FONLL'
	
	fck_276 = 0.0d0
    fck_502 = 0.0d0

    open(1,file="charm_dis_276.txt",status="old")
    open(2,file="charm_dis_502.txt",status="old")
    
	do IK = 1, 3000  ! the maximum of pt 30 GeV
	
	k = 0.01d0*IK
	
	read(1,*) i, fck_276(IK)
    read(2,*) i, fck_502(IK)

    enddo
    close(1)
    close(2)
	
	print *, 'Finish reading charm fik'

    end
    
    function fik(k,IDP)!2.76 and 5.02. 200 GeV added on 2023/3/4 by Huanjing
    use Iflag
    use charm_dis
    implicit none
    real*8 Ai, ki, ni
    double precision k, fik
    integer IDP, IK
    
    if(k.gt.30.0d0) fik=0.0d0!cutoff
    
    if((ISys.eq.0).and.(k.le.30.0d0) )then
    !    system: AuAu@200 GeV at RHIC
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
    
    fik = 19.2*(1+(k/6.d0)**2)/(1+k/3.7d0)**12/(1+dexp(0.9d0-2.d0*k))

	case default
	
	print *, "Need to check the parton IDP in fik"
	stop

    end select
    endif

    if((ISys.eq.1).and.(k.le.30.0d0) )then
    !    system: PbPb@2.76 TeV at LHC
 	select case(IDP)
! u quark		
	case(1)
	
	Ai = 1.138d4
	ki = 0.687d0
	ni = 5.67d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! d quark		
	case(2)
	
	Ai = 1.266d4
	ki = 0.677d0
	ni = 5.66d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! ubar quark		
	case(3)
	
	Ai = 0.24d4
	ki = 0.87d0
	ni = 5.97d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! dbar quark		
	case(4)
	
	Ai = 0.23d4
	ki = 0.88d0
	ni = 5.99d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! gluon		
	case(5)
	
	Ai = 6.2d4
	ki = 0.98d0
	ni = 6.22d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! s, sbar quark			
	case(6, 7)
	
	Ai = 0.093d4
	ki = 1.05d0
	ni = 6.12d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! c, cbar quark
    case(8, 9)
        
    IK = floor((k+0.001d0)/0.01d0)
	
	if(IK.eq.0) then
	print *, 'IK = 0 in function fik'
	stop
	endif
	
	fik = fck_276(IK)/(3.49926d6)
    !fik=dexp(20.406 - 3.343* k**0.5)/(3.49926* 10**6)/(1 + dexp(3.89105*(0.8424 - k)))!FONLL fit

	case default
	
	print *, "Need to check the parton IDP in fik"
	stop

    end select
    endif
    
    if((ISys.eq.2).and.(k.le.30.0d0))then
    !   PbPb@5.02 TeV at LHC
 	select case(IDP)
! u quark		
	case(1)
	
	Ai = 2.023d4
	ki = 0.578d0
	ni = 5.295d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! d quark		
	case(2)
	
	Ai = 2.279d4
	ki = 0.567d0
	ni = 5.278d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! ubar quark		
	case(3)
	
	Ai = 0.42d4
	ki = 0.74d0
	ni = 5.51d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! dbar quark		
	case(4)
	
	Ai = 0.397d4
	ki = 0.75d0
	ni = 5.52d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! gluon		
	case(5)
	
	Ai = 11.2d4
	ki = 0.789d0
	ni = 5.67d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! s, sbar quark			
	case(6, 7)
	
	Ai = 0.154d4
	ki = 0.925d0
	ni = 5.616d0
	
	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
! c, cbar quark
    case(8, 9)

    IK = floor((k+0.001d0)/0.01d0)
	
	if(IK.eq.0) then
	print *, 'IK = 0 in function fik'
	stop
	endif
	
	fik = fck_502(IK)/(3.49926d6)
    !fik = dexp(20.49 - 3.15879* k**0.5)/(3.49926* 10**6)/(1 + dexp(3.30142*(1.05 - k)))!FONLL fit

	case default
	
	print *, "Need to check the parton IDP in fik"
	stop

    end select
    endif

    return
    end!function fik(k,IDP) end
    

!    function fik(k,IDP)!PbPb@5.5 TeV at LHC
!    implicit none
!    real*8 Ai, ki, ni
!    double precision k, fik
!    integer IDP
! 	select case(IDP)
!! u quark		
!	case(1)
!	
!	Ai = 2.209d4
!	ki = 0.5635d0
!	ni = 5.240d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! d quark		
!	case(2)
!	
!	Ai = 2.493d4
!	ki = 0.5522d0
!	ni = 5.223d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! ubar quark		
!	case(3)
!	
!	Ai = 4.581d3
!	ki = 0.7248d0
!	ni = 5.437d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! dbar quark		
!	case(4)
!	
!	Ai = 4.317d3
!	ki = 0.7343d0
!	ni = 5.448d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! gluon		
!	case(5)
!	
!	Ai = 1.229d5
!	ki = 0.7717d0
!	ni = 5.600d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! s, sbar quark			
!	case(6, 7)
!	
!	Ai = 1.662d3
!	ki = 0.9064d0
!	ni = 5.548d0
!	
!	fik = 2.5d0*Ai/(1.0d0+k/ki)**ni
!! c, cbar quark in Ref.meson_fik_charm_5.5
!    case(8, 9)
!    
!    fik = 2497*(1+k/1.95)**(-5.5)*(   k*(1+(4/(1+dexp(0.1+k)))**2)     )**(-1)
!	case default
!	
!	print *, "Need to check the parton IDP in fik"
!	stop
!
!    end select
!
!    return
!    end!function fik(k,IDP) end
    
    
    function f1ik(k,IDP)!f'ik
    use Iflag
    implicit none
    external fik
    double precision k, fik, f1ik
    double precision :: pi=3.141592653589793D0
    real*8 E, m_h
    integer IDP
    if((IDP .eq. 8) .or. (IDP .eq. 9))then !c,cbar
        m_h=1.28
        if(ISys.eq.0)then!200 GeV
            m_h=1.5
        endif
    elseif((IDP .eq. 6) .or. (IDP .eq. 7))then !s,sbar
        m_h=0.46
    elseif((IDP .eq. 1) .or. (IDP .eq. 3))then !u,ubar
        m_h=0.26
    elseif((IDP .eq. 2) .or. (IDP .eq. 4))then !d,dbar
        m_h=0.26
    elseif(IDP.eq.5)then!gluon
        m_h=0.01
    endif
    E=Sqrt(m_h**2+k**2)!k**2/2/m_h!Sqrt(m_h**2+k**2)!？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    f1ik = (2*pi)**3/E*fik(k,IDP)/k

    return
    end!function f1ik(k,IDP)!f'ik end
    
    !------------------------------------------------------------------------
	function Fiq(q, ID)
    use matrics
	implicit none
	
	real*8 Fiq
	integer ID
	real*8 q    

	integer IQ
	
	IQ = floor((q+0.001d0)/0.01d0)
	
	if(IQ.eq.0) then
	print *, 'IQ = 0 in function Fiqc'
	stop
	endif
	
	Fiq = MatFiqc(IQ, ID)
	
	return

    end
    
!------------------------------------------------------------------------
	function F1iq(q, ID)
    use matrics
	implicit none
	
	real*8 F1iq
	integer ID
	real*8 q    

	integer IQ
	
	IQ = floor((q+0.001d0)/0.01d0)
	
	if(IQ.eq.0) then
	print *, 'IQ = 0 in function Fiqc'
	stop
	endif
	
	F1iq = MatF1iqc(IQ, ID)
	
	return

	end
    
    !------------------------------------------------------------------------
	subroutine Set_Fiqc_Matrix
    use matrics
	implicit none
	integer ID
	integer IQ
	real*8 q
	
	external Cal_Fiq
	real*8 Cal_Fiq
	
	print *, 'Calculating MatFiqc'
	!print *, 'centrality c is a common variable: ', c
	
	MatFiqc = 0.0d0
	
	do ID = 1, 9
	do IQ = 1, 3000  ! the maximum of pt 30 GeV
	
	q = 0.01d0*IQ
	
	MatFiqc(IQ, ID) = Cal_Fiq(q, ID)
	
	enddo
	enddo
	
	print *, 'Finish calculating MatFiqc'

    end
    
    !------------------------------------------------------------------------
	subroutine Set_F1iqc_Matrix
    use matrics
	implicit none
	integer ID
	integer IQ
	real*8 q
	
	external Cal_F1iq
	real*8 Cal_F1iq
	
	print *, 'Calculating MatF1iqc'
	!print *, 'centrality c is a common variable: ', c
	
	MatF1iqc = 0.0d0
	
	do ID = 1, 9
	do IQ = 1, 3000  ! the maximum of pt 30 GeV
	
	q = 0.01d0*IQ
	
	MatF1iqc(IQ, ID) = Cal_F1iq(q, ID)
	
	enddo
	enddo
	
	print *, 'Finish calculating MatF1iqc'

	end
    
!------------------------------------------------------------------------
	include 'vegas.f90' ! include the vegas integral subroutine
	
!------------------------------------------------------------------------

	function Cal_Fiq(q, ID)
    use Iflag
	implicit none
	
	real*8 Cal_Fiq
	integer ID
	real*8 q, centr
	
	real*8 reg(4), pi, result, sdr, chi
    integer ndim,ncall,itmx,nprn,idum
    common /ranno/ idum  ! the common in vegas.f90
    external Intf_fik     ! you must declare the fcn to be integrated as external
    real*8 Intf_fik
    external fik
    real*8 fik

	pi = 3.14159265d0
    centr=0.025D0
	
	idum=9812371     ! a random seed for vegas
    ndim=2           ! the number of dimensions of the integral
    itmx=8           ! block the evaluations into itmx groups (for error estimation)
    nprn=-1          ! something to do with information echoing

    reg(1) = 0.d0    ! the integration region is defined in an
    reg(2) = 0.d0    ! array of dim 2*d. In this case variable 1 i
    reg(3) = pi/2.0d0   ! 0-pi, and variable 3 from 0-2pi.
    reg(4) = 2.4d0

    ncall = 2000  ! this is the total number of fcn calls
    
    call vegas(reg,ndim,Intf_fik,0,ncall,itmx,nprn,result,sdr,chi, ID, q, centr)
    
    Cal_Fiq = result
     	
	return

	end 
	
!-----------------------------------------------------------------
	function Intf_fik(intvar, wgt, IDH, q, centr)
    use Iflag
	implicit none
	real*8 Intf_fik
	real*8 intvar(2), wgt, q, centr
	integer IDH
	
	external Psi, fik
	real*8 Psi, fik 
	
	real*8 phi, z, pi, k
	real*8 gama, gamai
	real*8 xibari
	real*8 Tabc, TabcRatio
	
	pi = 3.14159265d0
	phi = intvar(1)
	z = intvar(2)
	
	gama = 0.11d0
	if(IDH.eq.5)then
!   For Au+Au, 200 GeV, Phys. Rev. C 88 044919
!	gamai = 0.14d0
!   For Pb+Pb, 2.76 TeV JPG47, 055102(2020)
   gamai = 2.8d0/(1.0d0+q**2/49.0d0) ! consider the gammai depends on q
!	gamai = 3.2d0/(1.0d0+q**2/81.0d0) ! consider the gammai depends on q
!	gamai = PAR(1)/(1.0d0+(q/PAR(2))**2) ! consider the gammai depends on q, search parameters by computer
    elseif(IDH.eq.8 .or. IDH.eq.9)then
        if(ISys.eq.1)then
!   For Pb+Pb, 2.76 TeV
        gamai = 2.8d0/(1.0d0+q**2/49.0d0) ! consider the gammai depends on q
        elseif(ISys.eq.2)then
!   For Pb+Pb, 5.02 TeV
	    gamai = 2.8d0/(1.0d0+q**2/49.0d0)
        endif
    else
!   For Au+Au, 200 GeV, Phys. Rev. C 88 044919
!	gamai = 0.07d0
        if(ISys.eq.1)then
!   For Pb+Pb, 2.76 TeV JPG47, 055102(2020)
        gamai = 2.8d0/(1.0d0+q**2/49.0d0)/2.0d0 ! consider the gammai depends on q
        elseif(ISys.eq.2)then
!   For Pb+Pb, 5.02 TeV
	    gamai = 1.6d0/(1.0d0+q**2/81.0d0)
!	gamai = PAR(1)/2.0d0/(1.0d0+(q/PAR(2))**2) ! consider the gammai depends on q, search parameters by computer
        endif
	endif
	
	if(.True.)then
	
	if(phi.gt.pi/2.0.and.phi.le.pi)then  !using the periodic condition
	phi = pi - phi
	elseif(phi.gt.pi.and.phi.le.1.5*pi)then
	phi = phi - pi
	elseif(phi.gt.1.5*pi.and.phi.le.2.0*pi)then
	phi = 2.0*pi - phi
	endif
	
	endif

!   ZH2013,Phys. Rev. C 88 044919
	xibari = gamai/gama*0.655d0*(1.0d0-centr-0.32*cos(phi)*sin(centr**(0.71d0)*pi)) ! depends on c
    !if(IYangZhu.eq.1)then
    !xibari = 0.0
    !endif

	k = q*dexp(z*xibari)

!============================================
! T_AA(c) for different systems.
! Add by Lilin on May-20-2020
!============================================
!    if(ISys.eq.5)then
!   For dAu, obtained by fitting T_AA vs centrality of dAu at 200 GeV
!---------------------------------------------------------------------------------------
!   From Hua's note: Recombination_model.pdf
!	Tabc = 0.45761d0-0.9933d0*centr+1.2564d0*centr**2-0.84044d0*centr**3 !need to modify for different systems
!   From LiLin by fit T_dAu from TBALE II PRC75,024909(2007)
!    Tabc = 0.4353d0-0.8382d0*centr+0.9157d0*centr**2-0.6008d0*centr**3
!    TabcRatio = Tabc/0.36d0
!---------------------------------------------------------------------------------------
!    elseif(ISys.eq.1)then
!   For AuAu, obtained by fitting T_AA vs centrality of AuAu at 200 GeV
!   The data for T_AA vs centrality are from TABLE I, PRC69, 034909(2004)
!---------------------------------------------------------------------------------------
!    Tabc = 26.6381d0-97.3355d0*centr+122.0414d0*centr**2-51.9970d0*centr**3
!    TabcRatio = Tabc/24.28d0
!---------------------------------------------------------------------------------------
    if(ISys.eq.1 .or. ISys.eq.2)then
!   For PbPb, obtained by fitting T_AA vs centrality of PbPb
!   The data for T_AA vs centrality are from TABLE I, PRC88, 044909(2013)
!---------------------------------------------------------------------------------------
    Tabc = 27.3731d0-100.8426d0*centr+126.5849d0*centr**2-53.6066d0*centr**3
    TabcRatio = Tabc/24.93d0
!---------------------------------------------------------------------------------------
    endif
	!TabcRatio = 1.0D0 ! for central collision

	Intf_fik = Psi(z)*q**2*dexp(2.0d0*z*xibari)*fik(k, IDH)*TabcRatio*2.0d0/pi
    
	end	
	
!-----------------------------------------------------------------	
! Psi(z) is very insensitive to phi and c, so we use this simplist expression for all systems and centralities.
! Appendix B, Phys. Rev. C 88 044919(2013), ZH2013
    function Psi(z)
	implicit none
	real*8 Psi, z

	Psi = (z/2.4d0)**0.5d0*(1.0d0-z/2.4d0)/0.64d0
	
	return
	
    end 
    
    !------------------------------------------------------------------------

	function Cal_F1iq(q, ID)
    use Iflag
	implicit none
	
	real*8 Cal_F1iq
	integer ID
	real*8 q, centr
	
	real*8 reg(4), pi, result, sdr, chi
    integer ndim,ncall,itmx,nprn,idum
    common /ranno/ idum  ! the common in vegas.f90
    external Intf_f1ik     ! you must declare the fcn to be integrated as external
    real*8 Intf_f1ik
    external f1ik
    real*8 f1ik

	pi = 3.14159265d0
    centr=0.025D0
	
	idum=9812371     ! a random seed for vegas
    ndim=2           ! the number of dimensions of the integral
    itmx=8           ! block the evaluations into itmx groups (for error estimation)
    nprn=-1          ! something to do with information echoing

    reg(1) = 0.d0    ! the integration region is defined in an
    reg(2) = 0.d0    ! array of dim 2*d. In this case variable 1 i
    reg(3) = pi/2.0d0   ! 0-pi, and variable 3 from 0-2pi.
    reg(4) = 2.4d0

    ncall = 2000  ! this is the total number of fcn calls
    
    call vegas(reg,ndim,Intf_f1ik,0,ncall,itmx,nprn,result,sdr,chi, ID, q, centr)
    
    Cal_F1iq = result
     	
	return

	end 
	
!-----------------------------------------------------------------
	function Intf_f1ik(intvar, wgt, IDH, q, centr)
    use Iflag
	implicit none
	real*8 Intf_f1ik
	real*8 intvar(2), wgt, q, centr
	integer IDH
	
	external Psi, f1ik
	real*8 Psi, f1ik 
	
	real*8 phi, z, pi, k
	real*8 gama, gamai
	real*8 xibari
	real*8 Tabc, TabcRatio
	
	pi = 3.14159265d0
	phi = intvar(1)
	z = intvar(2)
	
	gama = 0.11d0
	if(IDH.eq.5)then
!   For Au+Au, 200 GeV, Phys. Rev. C 88 044919
!	gamai = 0.14d0
!   For Pb+Pb, 2.76 TeV JPG47, 055102(2020)
   gamai = 2.8d0/(1.0d0+q**2/49.0d0) ! consider the gammai depends on q
!	gamai = 3.2d0/(1.0d0+q**2/81.0d0) ! consider the gammai depends on q
!	gamai = PAR(1)/(1.0d0+(q/PAR(2))**2) ! consider the gammai depends on q, search parameters by computer
    elseif(IDH.eq.8 .or. IDH.eq.9)then
        if(ISys.eq.1)then
!   For Pb+Pb, 2.76 TeV
        gamai = 2.8d0/(1.0d0+q**2/49.0d0) ! consider the gammai depends on q
        elseif(ISys.eq.2)then
!   For Pb+Pb, 5.02 TeV
	    gamai = 2.8d0/(1.0d0+q**2/49.0d0)
        endif
    else
!   For Au+Au, 200 GeV, Phys. Rev. C 88 044919
!	gamai = 0.07d0
        if(ISys.eq.1)then
!   For Pb+Pb, 2.76 TeV JPG47, 055102(2020)
        gamai = 2.8d0/(1.0d0+q**2/49.0d0)/2.0d0 ! consider the gammai depends on q
        elseif(ISys.eq.2)then
!   For Pb+Pb, 5.02 TeV
	    gamai = 1.6d0/(1.0d0+q**2/81.0d0)
!	gamai = PAR(1)/2.0d0/(1.0d0+(q/PAR(2))**2) ! consider the gammai depends on q, search parameters by computer
        endif
	endif
	
	if(.True.)then
	
	if(phi.gt.pi/2.0.and.phi.le.pi)then  !using the periodic condition
	phi = pi - phi
	elseif(phi.gt.pi.and.phi.le.1.5*pi)then
	phi = phi - pi
	elseif(phi.gt.1.5*pi.and.phi.le.2.0*pi)then
	phi = 2.0*pi - phi
	endif
	
	endif

!   ZH2013,Phys. Rev. C 88 044919
	xibari = gamai/gama*0.655d0*(1.0d0-centr-0.32*cos(phi)*sin(centr**(0.71d0)*pi)) ! depends on c
    !if(IYangZhu.eq.1)then
    !xibari = 0.0
    !endif

	k = q*dexp(z*xibari)

!============================================
! T_AA(c) for different systems.
! Add by Lilin on May-20-2020
!============================================
!    if(ISys.eq.5)then
!   For dAu, obtained by fitting T_AA vs centrality of dAu at 200 GeV
!---------------------------------------------------------------------------------------
!   From Hua's note: Recombination_model.pdf
!	Tabc = 0.45761d0-0.9933d0*centr+1.2564d0*centr**2-0.84044d0*centr**3 !need to modify for different systems
!   From LiLin by fit T_dAu from TBALE II PRC75,024909(2007)
!    Tabc = 0.4353d0-0.8382d0*centr+0.9157d0*centr**2-0.6008d0*centr**3
!    TabcRatio = Tabc/0.36d0
!---------------------------------------------------------------------------------------
!    elseif(ISys.eq.1)then
!   For AuAu, obtained by fitting T_AA vs centrality of AuAu at 200 GeV
!   The data for T_AA vs centrality are from TABLE I, PRC69, 034909(2004)
!---------------------------------------------------------------------------------------
!    Tabc = 26.6381d0-97.3355d0*centr+122.0414d0*centr**2-51.9970d0*centr**3
!    TabcRatio = Tabc/24.28d0
!---------------------------------------------------------------------------------------
    if(ISys.eq.1 .or. ISys.eq.2)then
!   For PbPb, obtained by fitting T_AA vs centrality of PbPb
!   The data for T_AA vs centrality are from TABLE I, PRC88, 044909(2013)
!---------------------------------------------------------------------------------------
    Tabc = 27.3731d0-100.8426d0*centr+126.5849d0*centr**2-53.6066d0*centr**3
    TabcRatio = Tabc/24.93d0
!---------------------------------------------------------------------------------------
    endif
	!TabcRatio = 1.0D0 ! for central collision

	Intf_f1ik = Psi(z)*dexp(2.0d0*z*xibari)*f1ik(k, IDH)*TabcRatio*2.0d0/pi
    
	end	
	
    
    !function Cal_Fiq(q,IDP)!with energy     Fiq has been added Quench
    !use Iflag
    !implicit none
    !external f1ik!f'ik
    !double precision q, f1ik
    !real*8  Cal_Fiq
    !real*8  bL, fa, fb, fdel, fsum
    !integer IDP
    !
    !if(ISys.eq.0)then
    !    if( IDParticle.eq.1 )then!Jpsi200
    !        if(IDP.eq.5)then
    !            bL=2.9
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.01
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0200
    !        if(IDP.eq.5)then
    !            bL=2.39
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.39
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds200
    !        if(IDP.eq.5)then
    !            bL=2.39
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.39
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    endif
    !elseif(ISys.eq.1)then
    !    if( IDParticle.eq.1 )then!Jpsi276
    !        if(IDP.eq.5)then
    !            bL=2.9!2.76	Jpsi
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.01!2.76    Jpsi
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9!2.76	Jpsi
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0276
    !        if(IDP.eq.5)then
    !            bL=2.9
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=10.0
    !            !bL=17.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=10.0
    !            !bL=17.0
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds276
    !        if(IDP.eq.5)then
    !            bL=2.9
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.9
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9
    !        endif
    !    endif
    !elseif(ISys.eq.2)then
    !    if( IDParticle.eq.1 )then!Jpsi502
    !        if(IDP.eq.5)then
    !            bL=0.1
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.001
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0502
    !        if(IDP.eq.5)then
    !            bL=17.0
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=17.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=17.0
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds502
    !        if(IDP.eq.5)then
    !            bL=7.0
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=7.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=5.0
    !        endif
    !    endif
    !endif
    !
    !fsum=0.d0
    !fa=q
    !fb=q*dexp(bL)
    !fdel=0.01d0
    !if(fb.gt.30.0d0) fb=30.0d0!cutoff
    !if(IDParticle.eq.1) fdel=0.001d0
    !
    !call Integral_fik(f1ik,fa,fb,fdel,IDP, fsum)
    !!if((IDP.eq.8).or.(IDP.eq.9))then
    !!    Fiq = 1/bL*fsum
    !!elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.5 .or. IDP.eq.6.or. IDP.eq.7)then
    !!    Fiq = 1/bL*fsum  *1.0D0/(1.0D0 + dexp((3.5D0-q)/0.5D0))
    !!endif
    !Cal_Fiq = 1.0d0/bL*fsum  *1.0D0/(1.0D0 + dexp((3.5D0-q)/0.5D0))
    !
    !return
    !end!Cal_Fiq(q,IDP) end
    !    
    !function Cal_F1iq(q,IDP)!F'iq(without energy E)     F'iq has been added Quench
    !use Iflag
    !implicit none
    !external int_fik
    !real*8  Cal_F1iq, q, int_fik
    !real*8  bL, fsum, fa, fb, fdel
    !integer IDP
    !
    !if(ISys.eq.0)then
    !    if( IDParticle.eq.1 )then!Jpsi200
    !        if(IDP.eq.5)then
    !            bL=2.9
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.01
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0200
    !        if(IDP.eq.5)then
    !            bL=2.39
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.39
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds200
    !        if(IDP.eq.5)then
    !            bL=2.39
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.39
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    endif
    !elseif(ISys.eq.1)then
    !    if( IDParticle.eq.1 )then!Jpsi276
    !        if(IDP.eq.5)then
    !            bL=2.9!2.76	Jpsi
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.01!2.76    Jpsi
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9!2.76	Jpsi
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0276
    !        if(IDP.eq.5)then
    !            bL=2.9
    !            !bL=1.0d-2
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            !bL=17.0
    !            bL=15.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=10.0
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds276
    !        if(IDP.eq.5)then
    !            bL=2.9
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=2.9
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.9
    !        endif
    !    endif
    !elseif(ISys.eq.2)then
    !    if( IDParticle.eq.1 )then!Jpsi502
    !        if(IDP.eq.5)then
    !            bL=0.1
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=0.001
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=2.39
    !        endif
    !    elseif( IDParticle.eq.2 )then!D0502
    !        if(IDP.eq.5)then
    !            bL=17.0
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=17.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=17.0
    !        endif
    !    elseif( IDParticle.eq.3 )then!Ds502
    !        if(IDP.eq.5)then
    !            bL=7.0
    !        elseif(IDP.eq.8 .or. IDP.eq.9)then
    !            bL=7.0
    !        elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.6.or. IDP.eq.7)then
    !            bL=5.0
    !        endif
    !    endif
    !endif
    !
    !fsum=0.d0
    !fa=q
    !fb=q*dexp(bL)
    !fdel=0.01d0
    !if(fb.gt.30.0d0) fb=30.0d0!cutoff
    !
    !if(IDParticle.eq.1) fdel=0.001d0
    !
    !call Integral_fik(int_fik,fa,fb,fdel,IDP, fsum)
    !!if((IDP.eq.8).or.(IDP.eq.9))then
    !!    F1iq = 1/bL*fsum
    !!elseif(IDP.eq.1 .or. IDP.eq.2 .or. IDP.eq.3 .or. IDP.eq.4 .or. IDP.eq.5 .or. IDP.eq.6.or. IDP.eq.7)then
    !!    F1iq = 1/bL*fsum  *1.0D0/(1.0D0 + dexp((3.5D0-q)/0.5D0))
    !!endif
    !Cal_F1iq = 1.0d0/bL*fsum  *1.0D0/(1.0D0 + dexp((3.5D0-q)/0.5D0))
    !
    !return
    !end!F1iq(q,IDP) end
    
        
    function int_fik(k,IDP)
    implicit none
    external fik
    double precision int_fik, fik
    real*8 k
    integer IDP
    int_fik=fik(k, IDP)*k
    return
    end!fik/k for integral end
    
    
    function int_SS(q, p, IDmeson)!SS for integral
    implicit none 
    external S_ij, Fiq, int_DD0c, int_DD0g, int_DDsc, int_DDsg, int_Djpsic, int_Djpsig, SPD, fik
    real*8   S_ij, int_DD0c,int_DD0g, int_DDsc, int_DDsg, int_Djpsic, int_Djpsig, SPD, fik
    double precision  Fiq, fsum, p, q,int_SS
    integer IDmeson
    real*8 fa,fb, fdel, Dc, Dg
    
    Dc=0.d0
    Dg=0.d0
!-----------------------------------------------Jpsi--------------------------------------
    if(IDmeson.eq.1)then
        Dc=0.5/(p/q)*                                            &
        ( S_ij(p/q/2,8,8)*S_ij(p/q/(2-p/q),8,9)+S_ij(p/q/2,8,9)*S_ij(p/q/(2-p/q),8,8))
        Dg=0.5/(p/q)*                                            &
        ( S_ij(p/q/2,5,8)*S_ij(p/q/(2-p/q),5,9)+S_ij(p/q/2,5,9)*S_ij(p/q/(2-p/q),5,8))
        !Dcbar=0.5/(p/q)*                                            &
        !( S_ij(p/q/2,9,8)*S_ij(p/q/(2-p/q),9,9)+S_ij(p/q/2,9,9)*S_ij(p/q/(2-p/q),9,8))
        
        !Dc=SPD(8, 8, p/2/q)*QuenchSPD(p/2)*SPD(8, 9, p/2/(q-p/2))*QuenchSPD(p/2)/q
        !Dg=SPD(5, 8, p/2/q)*QuenchSPD(p/2)*SPD(5, 9, p/2/(q-p/2))*QuenchSPD(p/2)/q
        
        !Dc=0.5/(p/q)*                                            &
        !( SPD(8,8,p/q/2)*SPD(8,9,p/q/(2-p/q))+SPD(8,9,p/q/2)*SPD(8,8,p/q/(2-p/q)))
        !Dg=0.5/(p/q)*                                            &
        !( SPD(5,8,p/q/2)*SPD(5,9,p/q/(2-p/q))+SPD(5,9,p/q/2)*SPD(5,8,p/q/(2-p/q)))!different use compared with v15, so wrong.
        Dc=Dc*(1-dexp(-p**2))
        Dg=Dg*(1-dexp(-p**2))

       ! do i=1,498
       !     x1=i*(p/q-0.)/500
       !     tmp=x1+(p/q-0.)/500
       !     Dc=Dc+(int_Djpsic(p/q,x1)+int_Djpsic(p/q,tmp))/2*(p/q-0.)/500
       ! enddo
        !
        !do i=1,498
        !    x1=i*(p/q-0.)/500
        !    tmp=x1+(p/q-0.)/500
        !    Dg=Dg+(int_Djpsig(p/q,x1)+int_Djpsig(p/q,tmp))/2*(p/q-0.)/500
        !enddo

        int_SS =( (Fiq(q,8)*Dc)+(Fiq(q,5)*Dg) )/q**2
    write(*,*) q, Fiq(q,8), Fiq(q,5)
!-----------------------------------------------D0--------------------------------------
    elseif(IDmeson.eq.2)then
        fa=0.d0
        fb=p/q
        fdel=0.02d0
        call Integral_D(int_DD0c,fa,fb,fdel,p/q,Dc)
        call Integral_D(int_DD0g,fa,fb,fdel,p/q,Dg)

        Dc=Dc*(1-dexp(-p**2))
        Dg=Dg*(1-dexp(-p**2))
        !write(*,*)p/q,Dc,Dg
        int_SS =( (Fiq(q,8)*Dc)+(Fiq(q,5)*Dg)  )/q**2
        !int_SS =( (fik(q,8)*Dc)+(fik(q,5)*Dg)  )/q**2
        
!-----------------------------------------------Ds--------------------------------------
    elseif(IDmeson.eq.3)then
        fa=0.d0
        fb=p/q
        fdel=0.02d0
        call Integral_D(int_DDsc,fa,fb,fdel,p/q,Dc)
        call Integral_D(int_DDsg,fa,fb,fdel,p/q,Dg)
        
        Dc=Dc*(1-dexp(-p**2))
        Dg=Dg*(1-dexp(-p**2))
        !write(*,*)p/q,Dc,Dg
        int_SS =( (Fiq(q,8)*Dc)+(Fiq(q,5)*Dg)  )/q**2
    endif

    return
    end!int_SS(p,q,IDmeson) end
    
   ! function int_Djpsic(x,x1)
   ! implicit none
   ! real*8 int_Djpsic, x,x1
   ! external S_ij
   ! double precision S_ij
   !
   ! int_Djpsic = ( S_ij(x1,8,8)*S_ij((x-x1)/(1-x1),8,9)+       &
   ! S_ij(x1/(1-x+x1),8,8)*S_ij(x-x1,8,9) )/2/x**2
   !!write(*,*)x,x1,int_DD0c
   ! return
   ! end


    !function int_Djpsig(x,x1)
    !implicit none
    !real*8 int_Djpsig, x,x1
    !external S_ij
    !double precision S_ij
    !
    !int_Djpsig = ( S_ij(x1,5,8)*S_ij((x-x1)/(1-x1),5,9)+       &
    !S_ij(x1/(1-x+x1),5,8)*S_ij(x-x1,5,9) )/2/x**2
    !!write(*,*)(x-x1)/(1-x1),S_ij((x-x1)/(1-x1),5,8)
    !return
    !end
    
    function int_DD0c(x,x1)
    implicit none
    real*8 int_DD0c, x,x1
    external S_ij
    double precision S_ij
    
    if(x1.gt.x-1.0d-5)then
        x1=x-1.0d-5
    endif
    int_DD0c = ( S_ij(x1,8,3)*S_ij((x-x1)/(1-x1),8,8)+       &
    S_ij(x1/(1-x+x1),8,3)*S_ij(x-x1,8,8) )/2*5*(x-x1)**4/x**6
   !write(*,*)x,x1,int_DD0c
    return
    end
    

    function int_DD0g(x,x1)
    implicit none
    real*8 int_DD0g, x,x1
    external S_ij
    double precision S_ij
    
    if(x1.gt.x-1.0d-5)then
        x1=x-1.0d-5
    endif
    int_DD0g = ( S_ij(x1,5,3)*S_ij((x-x1)/(1-x1),5,8)+       &
    S_ij(x1/(1-x+x1),5,3)*S_ij(x-x1,5,8) )/2*5*(x-x1)**4/x**6
    !write(*,*)(x-x1)/(1-x1),S_ij((x-x1)/(1-x1),5,8)
    return
    end
    
    function int_DDsc(x,x1)
    implicit none
    real*8 int_DDsc, x,x1
    external S_ij
    double precision S_ij
    
    if(x1.gt.x-1.0d-5)then
        x1=x-1.0d-5
    endif
    int_DDsc = ( S_ij(x1,8,7)*S_ij((x-x1)/(1-x1),8,8)+       &
    S_ij(x1/(1-x+x1),8,7)*S_ij(x-x1,8,8) )*330*x1**2 *(x-x1)**9/x**13
   !write(*,*)x,x1,int_DD0c
    return
    end
    

    function int_DDsg(x,x1)
    implicit none
    real*8 int_DDsg, x,x1
    external S_ij
    double precision S_ij
    
    if(x1.gt.x-1.0d-5)then
        x1=x-1.0d-5
    endif
    int_DDsg = ( S_ij(x1,5,7)*S_ij((x-x1)/(1-x1),5,8)+       &
    S_ij(x1/(1-x+x1),5,7)*S_ij(x-x1,5,8) )*330*x1**2 *(x-x1)**9/x**13
    !write(*,*)(x-x1)/(1-x1),S_ij((x-x1)/(1-x1),5,8)
    return
    end
    
    function Int_HardInt(q, pt, IDP)
	implicit none
	real*8 Int_HardInt
	real*8 q, pt
	integer IDP, IDH
	
!------------------------------------------------------
	
	external Fiq, S_ij, QuenchSPD
	real*8 Fiq, S_ij, QuenchSPD

!------------------------------------------------------	
	
	Int_HardInt = 0.0D0
	
	!do IDH = 1, 9
	IDH=5
	Int_HardInt = Int_HardInt + Fiq(q, IDH)*S_ij(pt/q, IDH, IDP)*QuenchSPD(pt)/q
	IDH=8
	Int_HardInt = Int_HardInt + Fiq(q, IDH)*S_ij(pt/q, IDH, IDP)*QuenchSPD(pt)/q
	!enddo
	
	return
	
	end	
    
    function int_SS2j(pt, q, k,IDmeson)!SS2j for integral, q=q and k=q'
    implicit none 
    external Sij, Fiq, int_fss
    real*8 Sij, int_fss,fa,fb,fdel
    double precision  Fiq, fsum, pt, q, k, int_SS2j
    real*8 fs1s5, fs2s5, fs3s5, fs4s5, fs5s5, fs6s5, fs7s5,fs8s5,  fs1s8, fs2s8, fs3s8, fs4s8, fs5s8, fs6s8,fs7s8,fs8s8
    integer IDmeson

    fs1s5=0.d0
    fs2s5=0.d0
    fs3s5=0.d0
    fs4s5=0.d0
    fs5s5=0.d0
    fs6s5=0.d0
    fs7s5=0.d0
    fs8s5=0.d0
    
    fs1s8=0.d0
    fs2s8=0.d0
    fs3s8=0.d0
    fs4s8=0.d0
    fs5s8=0.d0
    fs6s8=0.d0
    fs7s8=0.d0
    fs8s8=0.d0
    
    !-----------prevent from NaN---------
    if(k.le.1.d-10)then
        k=1.d-10
    endif
    if(q.le.1.d-10)then
        q=1.d-10
    endif
    !-----------prevent from NaN---------
    
    fa=0.0d0
    fb=pt
    fdel=0.05d0
    if(IDmeson.eq.1)then!Jpsi
        !sum over i=c/g, i'=c/g, totally 4 terms
        !int_SS2j =(Fiq(q, 8)*Fiq(k, 8)*Sij(pt/2.,q,8,8)*Sij(pt/2.,k,8,9)+ &
        !           Fiq(q, 5)*Fiq(k, 8)*Sij(pt/2.,q,5,8)*Sij(pt/2.,k,8,9)+ &
        !           Fiq(q, 8)*Fiq(k, 5)*Sij(pt/2.,q,8,8)*Sij(pt/2.,k,5,9)+ &
        !           Fiq(q, 5)*Fiq(k, 5)*Sij(pt/2.,q,5,8)*Sij(pt/2.,k,5,9))/q/k
        int_SS2j =(Fiq(q, 8)*Fiq(k, 8)*Sij(pt/2.,q,8,8)*Sij(pt/2.,k,8,9)+ &
                   Fiq(q, 5)*Fiq(k, 8)*Sij(pt/2.,q,5,8)*Sij(pt/2.,k,8,9)+ &
                   Fiq(q, 8)*Fiq(k, 5)*Sij(pt/2.,q,8,8)*Sij(pt/2.,k,5,9)+ &
                   Fiq(q, 5)*Fiq(k, 5)*Sij(pt/2.,q,5,8)*Sij(pt/2.,k,5,9)    )/q/k
        
        
    elseif(IDmeson.eq.2)then!D0

        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,5,5,fs5s5)!integral over p_2:  0-pt
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,5,8,fs5s8)
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,8,5,fs8s5)
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,8,8,fs8s8)

        int_SS2j =(Fiq(q, 5)*Fiq(k, 5)*fs5s5+  Fiq(q, 5)*Fiq(k, 8)*fs5s8+   &
                   Fiq(q, 8)*Fiq(k, 5)*fs8s5+  Fiq(q, 8)*Fiq(k, 8)*fs8s8)/q/k
        
    elseif(IDmeson.eq.3)then!Ds

        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,5,5,fs5s5)!integral over p_2:  0-pt
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,5,8,fs5s8)
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,8,5,fs8s5)
        call Integral_intfss(int_fss,fa,fb,fdel,pt,q,k,IDmeson,8,8,fs8s8)
        
		int_SS2j =(Fiq(q, 5)*Fiq(k, 5)*fs5s5+  Fiq(q, 5)*Fiq(k, 8)*fs5s8+   &
                   Fiq(q, 8)*Fiq(k, 5)*fs8s5+  Fiq(q, 8)*Fiq(k, 8)*fs8s8)/q/k 
         
    endif

    return
    end!int_SS2j(p,q,IDmeson) end
    
    
    function int_fss(pt, q, k ,p2,IDmeson, ID1, ID2)!function to integral to form SS2j
    implicit none
    real*8 int_fss, pt, q, k ,p2
    integer IDmeson, ID1, ID2!ID1:i, ID2:i'
    external Sij
    double precision Sij

    if(p2.gt.pt)then
        p2=pt
    endif
    if(IDmeson .eq. 1)then ! J/psi
        int_fss = Sij((pt-p2),q, ID1,9)*Sij(p2,k, ID2,8)
        
    elseif(IDmeson .eq. 2)then ! D0
        int_fss = p2**4*Sij((pt-p2),q, ID1,3)*Sij(p2,k, ID2,8)
    
    elseif(IDmeson .eq. 3)then ! Ds
        int_fss = p2**9*(pt-p2)**2 *Sij((pt-p2),q, ID1,7)*Sij(p2,k, ID2,8)
        
    endif
    
    return
    end!int_fss end
   
!=========================================================================
! The quenching functions
!=========================================================================
! Eq. (C3) in ZH, PhysRevC.88.044919
! A cut-off for shower parton distribution

	function QuenchSPD(p1)
    use Iflag
	implicit none
	real*8 QuenchSPD, p1

    if(ISys.eq.0)then
	QuenchSPD = 1.0D0 - dexp(-(p1/0.3D0)**2)  ! for AuAu
    elseif(ISys.eq.1)then
	QuenchSPD = 1.0D0 - dexp(-(p1/0.5D0)**2) ! for PbPb at 2.76 TeV
    elseif(ISys.eq.2)then
    QuenchSPD = 1.0D0 - dexp(-(p1/0.5D0)**2) ! for PbPb at 5.02 TeV Should be modified or not?
    else
    print *, 'Check your values of ISys'
    print *, 'In QuenchSPD'
    stop
    endif
	
	return
	
	end
!===================================================
! shower parton distribution of different types
! Sij from IDH to IDP----------Q=10 except for charm and gluon added later by Huanjing Gong.
	
	function SPD(IDH, IDP, x)
	implicit none
	
	real*8 SPD, x, A0, a, b, c, d
	integer  IDH, IDP
	
	external kns, ll, gg, squ, sqg, kk
	real*8  kns, ll, gg, squ, sqg, kk

!-----------------------------------------
	
	if(x.ge.0.9999D0) x = 0.9999D0
	if(x.le.1.0D-6) x = 1.0D-6
    
	if(IDH.eq.IDP)then
	
	if(IDP<6)then
	SPD = kk(x)
	else
	SPD = kns(x)+squ(x)
	endif
	
!------------------------------------------	
	else
	
	if(IDH.lt.5)then
	
	if(IDP.lt.5) then
	SPD = ll(x)
	else
	SPD = squ(x)
	endif
	
	elseif(IDH.eq.5)then
	
	if(IDP.lt.5)then 
	SPD = gg(x)
	else
	SPD = sqg(x)
	endif
	
	else
	
	if(IDP.lt.5)then
	SPD = ll(x)
	else
	SPD = squ(x)
	endif

	endif
!--------------------------------------------	
    endif
	
    if(IDH.eq.5)then!i=g
        if((IDP.eq.8) .or. (IDP.eq.9))then!j=c,cbar
            A0=5.020d-3
            a=0.702
            b=1.201
            c=1.952
            d=4.415
        elseif((IDP.eq.1) .or. (IDP.eq.2) .or. (IDP.eq.3) .or. (IDP.eq.4))then!j=u,d,ubar,dbar
            A0=0.919
            a=-0.0646
            b=2.0425
            c=-0.977
            d=1.528
        elseif((IDP.eq.6) .or. (IDP.eq.7))then!j=s,sbar
            A0=0.0151
            a=-0.8754
            b=2.128
            c=3.7674
            d=1.148
        endif
    elseif(IDH.eq.8)then!i=c
        if((IDP.eq.1) .or. (IDP.eq.2) .or. (IDP.eq.3) .or. (IDP.eq.4))then!j=u,d,ubar,dbar
            A0=2.185
            a=0.102
            b=4.017
            c=-0.879
            d=1.066
        elseif(IDP.eq.8)then!j=c
            A0=6.483
            a=2.526
            b=2.375
            c=22.819
            d=3.233
        elseif(IDP.eq.9)then!j=cbar
            A0=5.879d-4
            a=0.315
            b=2.577
            c=23.505
            d=16.078
        elseif((IDP.eq.6) .or. (IDP.eq.7))then!j=s,sbar
            A0=0.118
            a=-0.138
            b=2.3
            c=0.9
            d=0.1
        endif
    endif
    SPD = A0*x**a*(1-x)**b*(1+c*x**d)
    
	return
	
    end	
    
!===================================================
!===================================================
! This part we don't need to change	
!===================================================
!===================================================
! shower parton distribution functions which are 
! derived from fragmentation functions
! From HY2004, PRC 70, 024904
	function kns(x)  ! valence quark Kns
	implicit none
	
	real*8 kns, x
	
	real*8 nv, av, bv, cv, dv
	
	nv = 0.3328D0
	av = 0.45D0
	bv = 2.1D0
	cv = 5.0D0
	dv = 0.5D0
	
	kns = nv*x**av*(1.0D0-x)**bv*(1.0D0+cv*x**dv)
	
	return
	
	end 	
!---------------------------------------------------
! From HY2004, PRC 70, 024904

	function ll(x)  ! L
	implicit none
	
	real*8 ll, x
	
	real*8 ns, as, bs, cs, ds
	
	ns = 1.881D0
	as = 0.13323D0
	bs = 3.3842D0
	cs = -0.99098D0
	ds = 0.30986D0
	
	ll = ns*x**as*(1.0D0-x)**bs*(1.0D0+cs*x**ds)
	
	return
	
	end
	
!---------------------------------------------------
		
	function gg(x)  ! G
	implicit none
	
	real*8 gg, x
	
	real*8 ns, as, bs, cs, ds
! From HY2004, PRC70, 024904(2004)

!	ns = 0.8109D0
!	as = -0.0561D0
!	bs = 2.5470D0
!	cs = -0.1757D0
!	ds = 1.2D0

! From ZH2011, PRC84, 064914(2011)
! Z-5-18-SPD-ZH2011
!	ns = 0.739D0
!	as = -0.28D0
!	bs = 4.387D0
!	cs = 4.502D0
!	ds = 10.469D0

! From ZH2011, PRC84, 064914(2011)
! Z-5-26a-SPD-ZH2011
! The scale-breaking effect due to a cut-off at low p_1 is included.
	ns = 0.0739D0
	as = -0.6882D0
	bs = 3.5245D0
	cs = 16.4849D0
	ds = 0.7561D0
	
	gg = ns*x**as*(1.0D0-x)**bs*(1.0D0+cs*x**ds)
	
	return
	
	end
	
!-------------------------------------------------
! From HY2004, PRC 70, 024904

	function squ(x)  ! Ls
	implicit none
	
	real*8 squ, x
	
	real*8 ns, as, bs, cs, ds
	
	ns = 0.1182D0
	as = -0.1378D0
	bs = 2.3D0
	cs = 0.9D0
	ds = 0.1D0
	
	squ = ns*x**as*(1.0D0-x)**bs*(1.0D0+cs*x**ds)
	
	return
	
	end
	
!-------------------------------------------------
! From HY2004, PRC 70, 024904

	function sqg(x)  ! Gs
	implicit none
	
	real*8 sqg, x
	
	real*8 ns, as, bs, cs, ds
	
	ns = 0.0687D0
	as = -0.425D0
	bs = 2.489D0
	cs = -0.5D0
	ds = 1.1D0
	
	sqg = ns*x**as*(1.0D0-x)**bs*(1.0D0+cs*x**ds)
	
	return
	
	end
	
!-------------------------------------------------
! From HY2004, PRC 70, 024904

	function kk(x)  ! K
	implicit none
	
	real*8 kk, x
	
	external kns, ll
	real*8 kns, ll
	
	kk = kns(x)+ll(x)
	
	return
	
    end	
    
!===================================================
! beta function	
        SUBROUTINE BETA(P,Q,BT)
!       ==========================================
!       Purpose: Compute the beta function B(p,q)
!       Input :  p  --- Parameter  ( p > 0 )
!                q  --- Parameter  ( q > 0 )
!       Output:  BT --- B(p,q)
!       Routine called: GAMMA for computing ‚(x)
!       ==========================================
!
        IMPLICIT DOUBLE PRECISION (A-H,O-Z)
        CALL GAMMA(P,GP)
        CALL GAMMA(Q,GQ)
        PPQ=P+Q
        CALL GAMMA(PPQ,GPQ)
        BT=GP*GQ/GPQ
        RETURN
        END!beta function end

! gamma function	
        SUBROUTINE GAMMA(X,GA)
!
!       ==================================================
!       Purpose: Compute gamma function ‚(x)
!       Input :  x  --- Argument of ‚(x)
!                       ( x is not equal to 0,-1,-2,˙˙˙)
!       Output:  GA --- ‚(x)
!       ==================================================
!
        IMPLICIT DOUBLE PRECISION (A-H,O-Z)
        DIMENSION G(26)
        PI=3.141592653589793D0
        IF (X.EQ.INT(X)) THEN
           IF (X.GT.0.0D0) THEN
              GA=1.0D0
              M1=X-1
              DO 10 K=2,M1
10               GA=GA*K
           ELSE
              GA=1.0D+300
           ENDIF
        ELSE
           IF (DABS(X).GT.1.0D0) THEN
              Z=DABS(X)
              M=INT(Z)
              R=1.0D0
              DO 15 K=1,M
15               R=R*(Z-K)
              Z=Z-M
           ELSE
              Z=X
           ENDIF
           
              G=(/1.0D0,0.5772156649015329D0,                       &
               -0.6558780715202538D0, -0.420026350340952D-1,        &  
               0.1665386113822915D0,-.421977345555443D-1,           &
               -.96219715278770D-2, .72189432466630D-2,             &
               -.11651675918591D-2, -.2152416741149D-3,             & 
               .1280502823882D-3, -.201348547807D-4,                &
               -.12504934821D-5, .11330272320D-5,                   &
               -.2056338417D-6, .61160950D-8,                       &
               .50020075D-8, -.11812746D-8,                         &
               .1043427D-9, .77823D-11,                             &
               -.36968D-11, .51D-12,                                &
               -.206D-13, -.54D-14, .14D-14, .1D-15/)               
           GR=G(26)
           DO 20 K=25,1,-1
20            GR=GR*Z+G(K)
           GA=1.0D0/(GR*Z)
           IF (DABS(X).GT.1.0D0) THEN
              GA=GA*R
              IF (X.LT.0.0D0) GA=-PI/(X*GA*DSIN(PI*X))
           ENDIF
        ENDIF
        RETURN
    END!gamma function end
    

!==============================================================================
! one dimensional integral subroutine using expotential integral algorithm
! integral function fnx
! integral range from a to b, and the integral step is del
! momentum p1, p2, p3, pt
! parton ID IDP1, IDP2, IDP3
! centrality centr
! integral result sumf
	            	
	subroutine Integral_1d(fnx, a, b, del, pt, IDP, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 pt
	integer IDP
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
	fa = fnx(xi, pt, IDP)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(xi, pt, IDP)
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

    
    ! only for int_SS2j           	
	subroutine Integral_intSS2j(fnx, a, b, del, pt, k, IDP, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 pt, k
	integer IDP
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
	fa = fnx(pt, xi, k, IDP)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(pt, xi, k, IDP)
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
    
    ! only for int_fss          	
	subroutine Integral_intfss(fnx, a, b, del, pt, q, k, IDmeson, IDP1, IDP2, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	real*8 pt, q, k
	integer IDP1, IDP2, IDmeson
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
	fa = fnx(pt,q,k,xi,IDmeson,IDP1,IDP2)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(pt,q,k,xi,IDmeson,IDP1,IDP2)
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
    
    ! only for int_fik         	
	subroutine Integral_fik(fnx, a, b, del, IDP, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del
	integer IDP
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
	fa = fnx(xi, IDP)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(xi, IDP)
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
    
    ! only for Dc Dg         	
	subroutine Integral_D(fnx, a, b, del, q, sumf)
	implicit none
!-------------------------------------------------	
	external fnx
	real*8 fnx
	
	real*8 a, b, del, q
	integer IDP
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
	fa = fnx(q,xi)
	if(fa.le.0.0D0) fa = 1.0D-18
		
	do i = 1, NP
	
	xi = xi+del
	if(xi.gt.b) xi = b
	
	fb = fnx(q,xi)
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
!==============================================================================
! two dimensional integral subroutine using expotential integral algorithm
! this subroutine is specifically written for recombnation model to calculate the spectra of particles 
! the first integral range from fa to fb, and the integral step is fdel
! the second integral up limit is not fixed, it depends on the value of first integral variable
! integral function fnx
! momentum pt
! parton ID IDP1, IDP2, IDP3
! centrality centr
! integral result sumf
	            	
!	subroutine Integral_2d(fnx, fa, fb, pt, IDP, sumf)
!	implicit none
!!-------------------------------------------------	
!	external fnx
!	real*8 fnx
!	
!	real*8 pt
!	integer IDP
!	real*8 sumf
!!-------------------------------------------------
!
!	integer NP
!	real*8 resa, resb, x, aa
!	integer i
!	
!	real*8 fa, fb, fdel  ! f means first
!	real*8 sa, sb, sdel  ! s means second
!	real*8 ssumf
!
!!-------------------------------------------------	
!! calculate how many steps we will take
!
!	sumf = 0.0D0
!	fdel = 0.05D0
!	
!	if((fb-fa)/fdel-int((fb-fa)/fdel).le.0.5D0)then
!	NP = int((fb-fa)/fdel)
!	else
!	NP = int((fb-fa)/fdel)+1
!	endif	
!	
!!--------------------------------------------------
!	
!	sa = 0.01D0
!	sdel = fdel
!	
!	
!	x = fa  ! x is the second integral variable
!	sb = pt-x-0.01D0 ! the up limit of second integral variable which depends on value of the first integral variable 
!	fp1 = x  
!	
!	call Integral_1d(fnx, sa, sb, sdel, fp1, fp2, fp3, pt, IDP, ssumf)
!	
!	resa = ssumf
!	
!	if(resa.le.0.0D0) resa = 1.0D-18
!	
!	do i =1, NP
!	
!	x = x + fdel
!	sb = pt-x
!	fp1 = x
!	
!	call Integral_1d(fnx, sa, sb, sdel, fp1, fp2, fp3, pt, IDP1, IDP2, IDP3, centr, ssumf)
!	
!	resb = ssumf
!	
!	if(resb.le.0.0D0) resb = 1.0D-18
!	
!	aa = log(resb/resa)/fdel
!		
!	if(abs(aa).lt.0.0001D0)then
!	sumf = sumf+resa*fdel
!	else 
!	sumf = sumf+(resb-resa)/aa
!	endif
!	
!	resa = resb
!
!	enddo
!
!	return
!	
!	end	