
	SUBROUTINE LIBSR(A,N,MM,NN,X,K)
	INTEGER A(N),X
	I=MM
	J=NN
10	IF (I.LE.J) THEN
	  K=(I+J)/2
	  IF (X.EQ.A(K)) RETURN
	  IF (X.LT.A(K)) THEN
	    J=K-1
	  ELSE
	    I=K+1
	  END IF
	  GOTO 10
	END IF
	K=MIN(I,J)-1
20	IF (X.GT.A(K)) THEN
	  K=K+1
	  GOTO 20
	END IF
	K=-(K-1)
	RETURN
	END

