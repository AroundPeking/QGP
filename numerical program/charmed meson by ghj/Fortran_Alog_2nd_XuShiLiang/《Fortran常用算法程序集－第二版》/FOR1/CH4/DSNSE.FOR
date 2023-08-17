
	SUBROUTINE DSNSE(N,EPS,X,Y,FS,L)
	DIMENSION X(N),Y(N)
	DOUBLE PRECISION X,Y,F,D,S
	L=500
5	CALL FS(X,N,F,Y)
	IF (F.GE.EPS) THEN
	  L=L-1
	  IF (L.EQ.0) RETURN
	  D=0.0
	  DO 20 J=1,N
20	  D=D+Y(J)*Y(J)
	  IF (D+1.0.EQ.1.0) THEN
	    L=-1
	    RETURN
	  END IF
	  S=F/D
	  DO 30 I=1,N
30	  X(I)=X(I)-S*Y(I)
	  GOTO 5
	END IF
	RETURN
	END

