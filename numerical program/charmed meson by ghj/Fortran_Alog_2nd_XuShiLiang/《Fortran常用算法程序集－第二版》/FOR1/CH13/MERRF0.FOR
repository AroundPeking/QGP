
	DOUBLE PRECISION MERRF,X(4),Y(4)
	WRITE(*,*)
	DO 10 I=0,9
	  DO 20 J=0,3
	    X(J+1)=0.05*(4.0*I+J)
	    Y(J+1)=MERRF(X(J+1))
20	  CONTINUE
	  WRITE(*,100) (X(K),Y(K),K=1,4)
10	CONTINUE
100	FORMAT(1X,4('erf(',F4.2,')=',F8.6,1X))
	X(1)=2.0
	Y(1)=MERRF(X(1))
	WRITE(*,200) X(1),Y(1)
200	FORMAT(1X,'erf(',F4.2,')=',F8.6)
	WRITE(*,*)
	END

