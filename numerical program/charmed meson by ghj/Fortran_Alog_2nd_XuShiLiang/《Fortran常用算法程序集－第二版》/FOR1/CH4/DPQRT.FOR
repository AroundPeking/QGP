
	SUBROUTINE DPQRT(X,EPS,F,L)
	DIMENSION A(10),Y(10)
	L=10
10	J=0
20	IF (J.LE.2) THEN
	  Z=X+0.1*J
	ELSE
	  Z=H2
	END IF
	Y(J+1)=F(Z)
	H2=Z
	IF (J.EQ.0) THEN
	  A(1)=Z
	ELSE
	  DO 30 I=1,J
	    H2=H2-A(I)
	    IF (ABS(H2)+1.0.EQ.1.0) THEN
	      H2=SIGN(1.0E+35,H2)
              H2=H2*SIGN(1.0E0,Y(J+1)-Y(I))
	    ELSE
	      H2=(Y(J+1)-Y(I))/H2
	    END IF
30	  CONTINUE
	  A(J+1)=H2
	  H2=0.0
	  DO 40 I=J,1,-1
	    H2=H2+A(I+1)
	    IF (ABS(H2)+1.0.EQ.1.0) THEN
	      H2=SIGN(1.0E+35,H2)
              H2=H2*SIGN(1.0E0,-Y(I))
	    ELSE
	      H2=-Y(I)/H2
	    END IF
40	  CONTINUE
	  H2=H2+A(1)
	END IF
	IF (ABS(Y(J+1)).GT.EPS) THEN
	  J=J+1
	  IF (J.LE.7) GOTO 20
	  X=H2
	  L=L-1
	  IF (L.NE.0) GOTO 10
	END IF
	X=H2
	RETURN
	END

