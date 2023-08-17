Program main
Implicit none
    external Ctq4Pdf
    real*8 :: Ctq4Pdf
    integer :: Iset=10,Iparton,m,n
    real*8  :: x,y,Q,pdf
!   The available applied range is 10^-5 < x < 1 and 1.6 < Q < 10,000 (GeV) 
!   except CTEQ4LQ(4HQ1) for which Q starts at a lower value of 0.7(1.0) GeV.
!   change x,Q range here
    real*8  :: x0=0.00001d0,dx=0.00001d0,x1=0.00999d0
    real*8  :: y0=0.01d0,dy=0.01d0,y1=1.d0
    real*8  :: Q0=1.d0,dQ=1.d0,Q1=10.d0
!   Iparton  is the parton label (5, 4, 3, 2, 1, 0, -1, ......, -5)
!                            for (b, c, s, d, u, g, u_bar, ..., b_bar),
    
    call SetCtq4 (Iset)  
    DO Iparton=-5,5
        if(Iparton.eq.1)then 
            open(unit=101, file="pdf_u.txt",status='unknown')
        elseif(Iparton.eq.2)then 
            open(unit=101, file="pdf_d.txt",status='unknown')
        elseif(Iparton.eq.3)then 
            open(unit=101, file="pdf_s.txt",status='unknown')
        elseif(Iparton.eq.4)then 
            open(unit=101, file="pdf_c.txt",status='unknown')
        elseif(Iparton.eq.5)then 
            open(unit=101, file="pdf_b.txt",status='unknown')
        elseif(Iparton.eq.0)then 
            open(unit=101, file="pdf_g.txt",status='unknown')
        elseif(Iparton.eq.-1)then 
            open(unit=101, file="pdf_ubar.txt",status='unknown')
        elseif(Iparton.eq.-2)then 
            open(unit=101, file="pdf_dbar.txt",status='unknown')
        elseif(Iparton.eq.-3)then 
            open(unit=101, file="pdf_sbar.txt",status='unknown')
        elseif(Iparton.eq.-4)then 
            open(unit=101, file="pdf_cbar.txt",status='unknown')
        elseif(Iparton.eq.-5)then 
            open(unit=101, file="pdf_bbar.txt",status='unknown')
        endif
    Do m=0,INT((Q1-Q0)/dQ)
        Q=Q0+m*dQ
        do n=0,INT((x1-x0)/dx)
            x=x0+n*dx
            pdf=Ctq4Pdf(Iparton, x, Q)
            write(101,110)x,Q,pdf
        enddo
         do n=0,INT((y1-y0)/dy)
            y=y0+n*dy
            pdf=Ctq4Pdf(Iparton, y, Q)
            write(101,110)y,Q,pdf
        enddo
    EndDo
    ENDDO
110 format((1x, ES14.8E2),(1x, F12.4), 7(1x, ES14.8E2))
    
    Print *, "finish"
    pause
    
end