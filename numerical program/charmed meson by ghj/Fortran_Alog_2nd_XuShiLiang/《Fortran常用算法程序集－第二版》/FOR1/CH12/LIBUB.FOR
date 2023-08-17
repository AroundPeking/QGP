

	SUBROUTINE LIBUB(A,N,MM,NN)
	INTEGER A(N),D
	M=NN-MM+1
10	IF (M.GT.0) THEN
	  J=M+MM-2
	  M=0
	  DO 20 I=MM,J
	    IF (A(I).GT.A(I+1)) THEN
	      D=A(I)
	      A(I)=A(I+1)
	      A(I+1)=D
	      M=I-MM+1
	    END IF
20	  CONTINUE
	  GOTO 10
	END IF
	RETURN
	END


