
	SUBROUTINE FGAUS(N,JS,X,FS,F,S)
	DIMENSION JS(N),X(N)
	DIMENSION T(5),C(5),D(2,11),CC(11),IS(2,11)
	DOUBLE PRECISION X,F,S,T,C,D,CC,DN,UP,P
	DATA T/-0.9061798459,-0.5384693101,0.0,
     *         0.5384693101,0.9061798459/
	DATA C/0.2369268851,0.4786286705,0.5688888889,
     *         0.4786286705,0.2369268851/
	M=1
	D(1,N+1)=1.0
	D(2,N+1)=1.0
10	DO 20 J=M,N
	  CALL FS(J,N,X,DN,UP)
	  D(1,J)=0.5*(UP-DN)/JS(J)
	  CC(J)=D(1,J)+DN
	  X(J)=D(1,J)*T(1)+CC(J)
	  D(2,J)=0.0
	  IS(1,J)=1
	  IS(2,J)=1
20	CONTINUE

	J=N
30	K=IS(1,J)
	IF (J.EQ.N) THEN
	  P=F(N,X)
	ELSE
	  P=1.0
	END IF
	D(2,J)=D(2,J+1)*D(1,J+1)*P*C(K)+D(2,J)
	IS(1,J)=IS(1,J)+1
	IF (IS(1,J).GT.5) THEN
	  IF (IS(2,J).GE.JS(J)) THEN
	    J=J-1
	    IF (J.EQ.0) THEN
	      S=D(2,1)*D(1,1)
	      RETURN
	    END IF
	    GOTO 30
	  END IF
	  IS(2,J)=IS(2,J)+1
	  CC(J)=CC(J)+D(1,J)*2.0
	  IS(1,J)=1
	END IF
	K=IS(1,J)
	X(J)=D(1,J)*T(K)+CC(J)
	IF (J.EQ.N) GOTO 30
	M=J+1
	GOTO 10
	END

