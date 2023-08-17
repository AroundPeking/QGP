
	SUBROUTINE JMAXN(X,N,FS,EPS,Z,K,L)
	DIMENSION X(N),Y(10),B(10)
	DOUBLE PRECISION X,Y,B,Z,T,H1,H2,F,DX
	L=10
10	T=0.0
	DO 15 I=1,N
	  CALL FS(X,N,I,F)
	  T=T+ABS(F)
15	CONTINUE
	IF (T.GE.EPS) THEN
	  DO 60 I=1,N
	    IL=5
20	    J=0
	    T=X(I)
30	    IF (J.LE.2) THEN
	      Z=T+J*0.01
	    ELSE
	      Z=H2
	    END IF
	    X(I)=Z
	    CALL FS(X,N,I,F)
	    IF (ABS(F)+1.0.NE.1.0) THEN
	      H1=F
	      H2=Z
	      IF (J.EQ.0) THEN
                Y(1)=H1
	        B(1)=H2
	      ELSE
	        Y(J+1)=H1
	        DO 40 K=1,J
	          H2=H2-B(K)
	          IF (ABS(H2)+1.0D0.EQ.1.0D0) THEN
	            H2=SIGN(1.0D+35,H2)
	            H2=H2*SIGN(1.0D0,H1-Y(K))
	          ELSE
	            H2=(H1-Y(K))/H2
	          END IF
40	        CONTINUE
	        B(J+1)=H2

	        H2=0.0
	        DO 50 K=J,1,-1
	          H2=H2+B(K+1)
	          IF (ABS(H2)+1.0D0.EQ.1.0D0) THEN
	            H2=SIGN(1.0D+35,H2)
	            H2=H2*SIGN(1.0D0,-Y(K))
	          ELSE
	            H2=-Y(K)/H2
	          END IF
50	        CONTINUE
	        H2=H2+B(1)
	      END IF
	      J=J+1
	      IF (J.LE.7) GOTO 30
	      X(I)=H2
	      IL=IL-1
	      IF (IL.NE.0) GOTO 20
	    END IF
	    X(I)=Z
60	  CONTINUE
	  L=L-1
	  IF (L.NE.0) GOTO 10
	END IF
	K=1
	DX=0.00001
	T=X(1)
	CALL FS(X,N,0,Z)
	X(1)=T+DX
	CALL FS(X,N,0,H1)
	X(1)=T-DX
	CALL FS(X,N,0,H2)
	X(1)=T
	T=H1+H2-2*Z
	IF (T.GT.0.0) K=-1
	J=1
70	J=J+1
	DX=0.00001
	T=X(J)
	X(J)=T+DX
	CALL FS(X,N,0,H2)
	X(J)=T-DX
	CALL FS(X,N,0,H1)
	X(J)=T
	T=H1+H2-2*Z
	IF ((T*K.LT.0.0).AND.(J.LT.N)) GOTO 70
	IF (T*K.GT.0.0) K=0
	RETURN
	END

