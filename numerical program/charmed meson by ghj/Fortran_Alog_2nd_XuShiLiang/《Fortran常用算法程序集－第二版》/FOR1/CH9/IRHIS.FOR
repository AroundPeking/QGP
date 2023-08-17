
	SUBROUTINE IRHIS(N,X,XA,S,T,X0,H,M,F,E,K)
	CHARACTER A(50)
	DIMENSION X(N),F(M),E(M)
	XA=0.0
	DO 10 I=1,N
10	XA=XA+X(I)/N
	S=0.0
	DO 20 I=1,N
20	S=S+(X(I)-XA)*(X(I)-XA)
	S=S/(N*1.0)
	T=SQRT(S)
	DO 30 I=1,M
	  E(I)=0.0
	  Z=X0+(I-0.5)*H-XA
	  Z=EXP(-Z*Z/(2.0*S))
	  F(I)=N*Z*H/(T*2.5066)
30	CONTINUE
	XE=X0+M*H

	DO 40 I=1,N
	  IF ((X(I)-X0).GE.0.0) THEN
	    IF ((XE-X(I)).GE.0.0) THEN
	      J=(X(I)-X0)/H+1
	      E(J)=E(J)+1
	    END IF
	  END IF
40	CONTINUE
	IF (K.EQ.0) RETURN
	WRITE(*,*)
	WRITE(*,50) N
50	FORMAT(1X,'N=',I10)
	WRITE(*,*)
	WRITE(*,60) X0,H,M
60	FORMAT(1X,'X0=',E13.6,3X,'H=',E13.6,3X,'M=',I5)
	WRITE(*,*)
	WRITE(*,70) XA,S,T
70	FORMAT(1X,'XA=',E13.6,3X,'S=',E13.6,3X,'T=',E13.6)
	WRITE(*,*)
	XE=1.0
	Z=0.0
	DO 80 I=1,M
	  IF (E(I).GT.Z) Z=E(I)
80	CONTINUE
90	IF (Z.GT.50.0) THEN
	  Z=Z/2
	  XE=XE/2
	  GOTO 90
	END IF
	DO 120 I=1,M
	  Z=X0+(I-0.5)*H
	  DO 100 J=1,50
100	  A(J)=' '
	  J=E(I)*XE+0.5
	  IF (J.GT.0) THEN
	    DO 110 L=1,J
110	    A(L)='X'
	  END IF
	  J=F(I)*XE+0.5
	  IF ((J.GT.0).AND.(J.LE.50)) A(J)='*'
	  WRITE(*,130) Z,E(I),A
	  WRITE(*,*)
120	CONTINUE
130	FORMAT(1X,E13.6,1X,E13.6,1X,50A1)
	RETURN
	END


