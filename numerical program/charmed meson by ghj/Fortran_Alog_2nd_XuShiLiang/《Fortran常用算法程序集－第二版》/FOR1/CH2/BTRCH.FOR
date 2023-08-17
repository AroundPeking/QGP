
	SUBROUTINE BTRCH(T0,T,TT,N,M,B,L,C,R,P)
	DIMENSION T(N),TT(N),B(M,M)
	DIMENSION C(M),R(M),P(M)
	DOUBLE PRECISION T0,T,TT,B,C,R,P,A,S
	L=1
	IF (ABS(T0)+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,100)
	  RETURN
	END IF
100	FORMAT(1X,'  FAIL')
	A=T0
	C(1)=TT(1)/T0
	R(1)=T(1)/T0
	DO 60 K=0,N-2
	  S=0.0
	  DO 10 J=1,K+1
10	  S=S+C(K+2-J)*TT(J)
	  S=(S-TT(K+2))/A
	  DO 20 I=1,K+1
20	  P(I)=C(I)+S*R(K+2-I)
	  C(K+2)=-S
	  S=0.0
	  DO 30 J=1,K+1
30	  S=S+R(K+2-J)*T(J)
	  S=(S-T(K+2))/A
	  DO 40 I=1,K+1
	    R(I)=R(I)+S*C(K+2-I)
	    C(K+2-I)=P(K+2-I)
40	  CONTINUE
	  R(K+2)=-S
	  A=0.0
	  DO 50 J=1,K+2
50	  A=A+T(J)*C(J)
	  A=T0-A
	  IF (ABS(A)+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,100)
	    RETURN
	  END IF
60	CONTINUE
	B(1,1)=1.0/A
	DO 70 I=1,N
	  B(1,I+1)=-R(I)/A
	  B(I+1,1)=-C(I)/A
70	CONTINUE
	DO 80 I=1,N
	DO 80 J=1,N
	  B(I+1,J+1)=B(I,J)-C(I)*B(1,J+1)
	  B(I+1,J+1)=B(I+1,J+1)+C(N+1-J)*B(1,N+2-I)
80	CONTINUE
	RETURN
	END

