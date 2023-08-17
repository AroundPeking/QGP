	

	SUBROUTINE LRHAP(A,N,MM,NN)
	DIMENSION A(N)
	L=NN-MM+1
	K=(NN-MM+1)/2
	DO 30 M=K,1,-1
	  I=M
	  J=2*I
	  X=A(I+MM-1)
10	  IF (J.LE.L) THEN
	    IF (J.LT.L) THEN
	      IF (A(J+MM-1).LT.A(J+MM)) J=J+1
	    END IF
	    IF (X.LT.A(J+MM-1)) THEN
	      A(I+MM-1)=A(J+MM-1)
	      I=J
	      J=2*I
	    ELSE
	      GOTO 20
	    END IF
	    GOTO 10
	  END IF
20	  A(I+MM-1)=X
30	CONTINUE
	DO 100 NS=L,2,-1
	  X=A(MM)
	  A(MM)=A(NS+MM-1)
	  A(NS+MM-1)=X
	  I=1
	  J=2
	  X=A(MM)
	  K=NS-1
50	  IF (J.LE.K) THEN
	    IF (J.LT.K) THEN
	      IF (A(J+MM-1).LT.A(J+MM)) J=J+1
	    END IF
	    IF (X.LT.A(J+MM-1)) THEN
	      A(I+MM-1)=A(J+MM-1)
	      I=J
	      J=2*I
	    ELSE
	      GOTO 60
	    END IF
	    GOTO 50
	  END IF
60	  A(I+MM-1)=X
100	CONTINUE
	RETURN
	END

