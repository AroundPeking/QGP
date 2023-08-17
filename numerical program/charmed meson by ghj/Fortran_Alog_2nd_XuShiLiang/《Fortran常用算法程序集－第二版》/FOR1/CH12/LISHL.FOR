

	SUBROUTINE LISHL(A,N,MM,NN)
	INTEGER A(N),T
	B=NN-MM+1
	B=ALOG(B)/ALOG(2.0)
	M=B
	L=1
	DO 10 I=1,M
10	L=L*2
	DO 50 I=1,M
	  K=L-1
	  L=L/2
	  DO 40 J=K+MM,NN
	    T=A(J)
	    IS=J-K
20	    IF((IS.GT.MM-1).AND.(A(IS).GT.T)) THEN
	      A(IS+K)=A(IS)
	      IS=IS-K
	      GOTO 20
	    END IF
	    A(IS+K)=T
40	  CONTINUE
50	CONTINUE
	RETURN
	END

