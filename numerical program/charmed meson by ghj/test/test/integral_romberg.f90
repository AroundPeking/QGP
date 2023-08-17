!usage example:
!    program main
!    external f
!    DOUBLE PRECISION f,s,a,b
!    a=0.
!    b=5.
!    e=0.1
!    call integral(a,b,f,e,s)
!    write(*,*)s
!    WRITE(*,*)125./3
!    end
!    
!function f(x)
!double precision f,x
!f=x**2
!return
!end
SUBROUTINE integral(A,B,F,EPS,T,IDP)
DIMENSION Y(10)
DOUBLE PRECISION A,B,F,T,Y,H,P,S,Q
integer IDP
    H=B-A
    Y(1)=H*(F(A,IDP)+F(B,IDP))/2.0
    M=1
    N=1
10  P=0.0
    DO 20 I=0,N-1
20      P=P+F(A+(I+0.5)*H,IDP)
    P=(Y(1)+H*P)/2.0
    S=1.0
    DO 30 K=1,M
        S=4*S
        Q=(S*P-Y(K))/(S-1)
        Y(K)=P
        P=Q
30  CONTINUE
    IF ((ABS(Q-Y(M)).GE.EPS).AND.(M.LE.9))THEN
        M=M+1
        Y(M)=Q
        N=N+N
        H=H/2.0
        GOTO 10
    ENDIF
    T=Q

    RETURN
END

SUBROUTINE integral_S(A,B,F,EPS,T,IDP,pt)
DIMENSION Y(10)
DOUBLE PRECISION A,B,F,T,Y,H,P,S,Q,pt
integer IDP
    H=B-A
    Y(1)=H*(F(pt,A,IDP)+F(pt,B,IDP))/2.0
    M=1
    N=1
11  P=0.0
    DO 21 I=0,N-1
21      P=P+F(pt,A+(I+0.5)*H,IDP)
        P=(Y(1)+H*P)/2.0
        S=1.0
    DO 31 K=1,M
        S=4*S
        Q=(S*P-Y(K))/(S-1)
        Y(K)=P
        P=Q
31  CONTINUE
    IF ((ABS(Q-Y(M)).GE.EPS).AND.(M.LE.9))THEN
        M=M+1
        Y(M)=Q
        N=N+N
        H=H/2.0
        GOTO 11
    ENDIF
    T=Q

    RETURN
    END   
    
    !自适应梯形积分
	SUBROUTINE FFPTS(A,B,F,EPS,T,IDP,pt)
	DIMENSION S(30,7)
	DOUBLE PRECISION A,B,F,T,S,F0,F1,P,H,X,F3,T1,T2,pt
    INTEGER IDP
	T=0.0
	F0=F(pt,A,IDP)
	F1=F(pt,B,IDP)
	P=H*(F0+F1)/2.0
	K=1
	S(K,1)=A
	S(K,2)=B
	S(K,3)=B-A
	S(K,4)=F0
	S(K,5)=F1
	S(K,6)=P
	S(K,7)=EPS
10	IF (K.NE.0) THEN
	  H=S(K,3)
	  X=S(K,1)+H/2.0
	  F3=F(pt,X,IDP)
	  T1=H*(S(K,4)+F3)/4.0
	  T2=H*(F3+S(K,5))/4.0
	  IF ((ABS(S(K,6)-T1-T2).LT.S(K,7)).OR.(K.GE.29)) THEN
	    T=T+(T1+T2)
	    K=K-1
	  ELSE
	    S(K+1,1)=X
	    S(K+1,2)=S(K,2)
	    S(K,2)=X
	    S(K,3)=H/2.0
	    S(K+1,3)=S(K,3)
	    S(K+1,4)=F3
	    S(K+1,5)=S(K,5)
	    S(K,5)=F3
	    S(K,7)=S(K,7)/1.4
	    S(K+1,7)=S(K,7)
	    S(K,6)=T1
	    S(K+1,6)=T2
	    K=K+1
	  END IF
	  GOTO 10
	END IF
	RETURN
    END
    
    