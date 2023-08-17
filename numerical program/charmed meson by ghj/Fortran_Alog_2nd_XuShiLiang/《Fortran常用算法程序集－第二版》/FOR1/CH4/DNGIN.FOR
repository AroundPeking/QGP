
	SUBROUTINE DNGIN(M,N,X,EPS1,EPS2,F,FJ,L,P,D,PP,DX,U,
     *                   V,KA,S,E,WORK)
	DIMENSION X(N),P(M,N),D(M),PP(N,M),DX(N),WORK(KA)
	DIMENSION U(M,M),V(N,N),Y(10),B(10),S(KA),E(KA)
	DOUBLE PRECISION X,P,D,ALPHA,PP,DX,U,V,Y1,Y2,Y0,
     *                   Z,H2,H1,Y,B,S,E,WORK
	L=30
	ALPHA=1.0
5	CALL F(M,N,X,D)
	CALL FJ(M,N,X,P)
	CALL AGMIV(M,N,P,D,PP,DX,LL,EPS2,U,V,KA,S,E,WORK)
	IF (LL.NE.0) THEN
	  L=1
	  RETURN
	END IF
	J=0
10	IF (J.LE.2) THEN
	  Z=ALPHA+J*0.01
	ELSE
	  Z=H2
	END IF
	DO 20 I=1,N
20	V(I,1)=X(I)-Z*DX(I)
	CALL F(M,N,V,D)
	Y1=0.0
	DO 30 I=1,M
30	Y1=Y1+D(I)*D(I)
	DO 40 I=1,N
40	V(I,1)=X(I)-(Z+0.00001)*DX(I)
	CALL F(M,N,V,D)
	Y2=0.0
	DO 50 I=1,M
50	Y2=Y2+D(I)*D(I)
	Y0=(Y2-Y1)/0.00001
	IF (ABS(Y0).GT.1.0E-10) THEN
	  H1=Y0
	  H2=Z
	  IF (J.EQ.0) THEN
	    Y(1)=H1
	    B(1)=H2
	  ELSE
	    Y(J+1)=H1
	    DO 60 K=1,J
	      H2=H2-B(K)
	      IF (ABS(H2)+1.0.EQ.1.0) THEN
	        H2=SIGN(1.0D+35,H2)*SIGN(1.0D0,H1-Y(K))
	      ELSE
	        H2=(H1-Y(K))/H2
	      END IF
60	    CONTINUE
	    B(J+1)=H2
	    H2=0.0
	    DO 70 K=J,1,-1
	      H2=B(K+1)+H2
	      IF (ABS(H2)+1.0.EQ.1.0) THEN
	        H2=SIGN(1.0D+35,H2)*SIGN(1.0D0,-Y(K))
	      ELSE
	        H2=-Y(K)/H2
	      END IF
70	    CONTINUE
	    H2=H2+B(1)
	  END IF
	  J=J+1
	  IF (J.LE.7) GOTO 10
	  Z=H2
	END IF
	ALPHA=Z
	Y1=0.0
	Y2=0.0
	DO 80 I=1,N
	  DX(I)=-ALPHA*DX(I)
	  X(I)=X(I)+DX(I)
	  Y1=Y1+ABS(DX(I))
	  Y2=Y2+ABS(X(I))
80	CONTINUE
	IF (Y1.LT.EPS1*Y2) THEN
	  L=0
	  RETURN
	END IF
	L=L-1
	IF (L.GE.0) GOTO 5
	RETURN
	END


