
	SUBROUTINE JMAX1(X,Z,K,M,EPS,FS)
	DIMENSION Y(10),B(10)
	DOUBLE PRECISION Y,B,X,Z,XX,DY,H1,H2,DX
	M=10
10	J=0
20	IF (J.LE.2) THEN
	  XX=X+0.01*J
	ELSE
	  XX=H2
	END IF
	CALL FS(XX,Z,DY)
	IF (ABS(DY).GT.EPS) THEN
	  H1=DY
	  H2=XX
	  IF (J.EQ.0) THEN
	    Y(1)=H1
	    B(1)=H2
	  ELSE
	    Y(J+1)=H1
	    DO 30 I=1,J
	      H2=H2-B(I)
	      IF (ABS(H2)+1.0D0.EQ.1.0D0) THEN
	        H2=SIGN(1.0D+35,H2)
	        H2=H2*SIGN(1.0D0,H1-Y(I))
	      ELSE
	        H2=(H1-Y(I))/H2
	      END IF
30	    CONTINUE
	    B(J+1)=H2
	    H2=0.0
	    DO 40 I=J,1,-1
	      H2=B(I+1)+H2
	      IF (ABS(H2)+1.0D0.EQ.1.0D0) THEN
	        H2=SIGN(1.0D+35,H2)
	        H2=H2*SIGN(1.0D0,-Y(I))
	      ELSE
	        H2=-Y(I)/H2
	      END IF
40	    CONTINUE
	    H2=H2+B(1)
	  END IF
	  J=J+1
	  IF (J.LE.7) GOTO 20
	  X=H2
	  M=M-1
	  IF (M.NE.0) GOTO 10
	  XX=X
	END IF
	X=XX
	IF (ABS(X).LE.1.0) THEN
	  DX=1.0E-05
	ELSE
	  DX=ABS(X*1.0E-05)
	END IF
	XX=X-DX
	CALL FS(XX,H1,DY)
	XX=X+DX
	CALL FS(XX,H2,DY)
	K=0
	IF ((H1+H2-2*Z).LE.0.0) K=1
	RETURN
	END

