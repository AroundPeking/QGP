
	SUBROUTINE ATLVS(T,N,B,X,L,Y,S)
	DIMENSION T(N),B(N),X(N),Y(N),S(N)
	DOUBLE PRECISION T,B,X,Y,S,A,C,H,Q,BETA
	L=1
	A=T(1)
	IF (ABS(A)+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,100)
	  RETURN
	END IF
100	FORMAT(1X,'  FAIL')
	Y(1)=1.0
	X(1)=B(1)/T(1)
	DO 40 K=1,N-1
	  BETA=0.0
	  Q=0.0
	  DO 10 J=1,K
	    BETA=BETA+Y(J)*T(J+1)
	    Q=Q+X(J)*T(K-J+2)
10	  CONTINUE
	  IF (ABS(A)+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,100)
	    RETURN
	  END IF
	  C=-BETA/A
	  S(1)=C*Y(K)
	  Y(K+1)=Y(K)
	  IF (K.NE.1) THEN
	    DO 20 I=2,K
20	    S(I)=Y(I-1)+C*Y(K-I+1)
	  END IF
	  A=A+C*BETA
	  IF (ABS(A)+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,100)
	    RETURN
	  END IF
	  H=(B(K+1)-Q)/A
	  DO 30 I=1,K
	    X(I)=X(I)+H*S(I)
	    Y(I)=S(I)
30	  CONTINUE
	  X(K+1)=H*Y(K+1)
40	CONTINUE
	RETURN
	END

