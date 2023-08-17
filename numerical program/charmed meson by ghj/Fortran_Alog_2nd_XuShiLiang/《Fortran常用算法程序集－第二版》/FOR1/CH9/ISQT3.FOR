
	SUBROUTINE ISQT3(M,K,X,F1,F2,EPS,XX,B,V,S,C,F,YE,YR,R)
	DIMENSION X(K,M),B(M),V(M),S(M),YE(M),YR(M),R(M,M),XX(M)
	DOUBLE PRECISION X,B,V,S,YE,YR,R,XX,F,C,FMI,FMX,
     *                   PHI,VMI,VMX,Z,Q,SD
	DO 50 J=1,M
	  Z=0.0
	  DO 40 I=1,K
40	  Z=Z+X(I,J)/K
	  XX(J)=Z
50	CONTINUE
	DO 80 I=1,M
	  DO 70 J=1,I
	    Z=0.0
	    DO 60 II=1,K
60	    Z=Z+(X(II,I)-XX(I))*(X(II,J)-XX(J))
	    R(I,J)=Z
70	  CONTINUE
80	CONTINUE
	DO 90 I=1,M
90	YE(I)=SQRT(R(I,I))

	DO 100 I=1,M
	DO 100 J=1,I
	  R(I,J)=R(I,J)/(YE(I)*YE(J))
	  R(J,I)=R(I,J)
100	CONTINUE
	PHI=K-1
	SD=YE(M)/SQRT(K-1.0)
105	VMI=1.0E+35
	VMX=0.0
	IMI=0
	IMX=0
	DO 110 I=1,M
	  V(I)=0.0
	  B(I)=0.0
	  S(I)=0.0
110	CONTINUE
	I=0
120	I=I+1
	IF (R(I,I).GE.EPS) THEN
	  V(I)=R(I,M)*R(M,I)/R(I,I)
	  IF (V(I).GE.0.0) THEN
	    IF (V(I).GT.VMX) THEN
	      VMX=V(I)
	      IMX=I
	    END IF
	  ELSE
	    B(I)=R(I,M)*YE(M)/YE(I)
	    S(I)=SQRT(R(I,I))*SD/YE(I)
	    IF (ABS(V(I)).LT.VMI) THEN
	      VMI=ABS(V(I))
	      IMI=I
	    END IF
	  END IF
	END IF
	IF (I.NE.M-1) GOTO 120
	IF (PHI.NE.M-2) THEN
	  Z=0.0
	  DO 130 I=1,M-1
130	  Z=Z+B(I)*XX(I)
	  B(M)=XX(M)-Z
	  S(M)=SD
	  V(M)=Q
	ELSE
	  B(M)=XX(M)
	  S(M)=SD
	END IF

	FMI=VMI*PHI/R(M,M)
	FMX=(PHI-1.0)*VMX/(R(M,M)-VMX)
	IF ((FMI.LT.F2).OR.(FMX.GE.F1)) THEN
	  IF (FMI.LT.F2) THEN
	    PHI=PHI+1.0
	    L=IMI
	  ELSE
	    PHI=PHI-1.0
	    L=IMX
	  END IF
	  DO 150 I=1,M
	    IF (I.NE.L) THEN
	      DO 140 J=1,M
	        IF (J.NE.L) THEN
	          R(I,J)=R(I,J)-(R(L,J)/R(L,L))*R(I,L)
	        END IF
140	      CONTINUE
	    END IF
150	  CONTINUE
	  DO 160 J=1,M
	    IF (J.NE.L) THEN
	      R(L,J)=R(L,J)/R(L,L)
	    END IF
160	  CONTINUE
	  DO 170 I=1,M
	    IF (I.NE.L) THEN
	      R(I,L)=-R(I,L)/R(L,L)
	    END IF
170	  CONTINUE
	  R(L,L)=1.0/R(L,L)
	  Q=R(M,M)*YE(M)*YE(M)
	  SD=SQRT(R(M,M)/PHI)*YE(M)
	  C=SQRT(1.0-R(M,M))
	  F=(PHI*(1.0-R(M,M)))/((K-PHI-1.0)*R(M,M))
	  GOTO 105
	END IF
	DO 190 I=1,K
	  Z=0.0
	  DO 180 J=1,M-1
180	  Z=Z+B(J)*X(I,J)
	  YE(I)=B(M)+Z
	  YR(I)=X(I,M)-YE(I)
190	CONTINUE
	RETURN
	END

