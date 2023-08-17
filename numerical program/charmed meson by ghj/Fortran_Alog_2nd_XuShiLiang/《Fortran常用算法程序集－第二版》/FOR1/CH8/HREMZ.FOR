
	SUBROUTINE HREMZ(A,B,F,P,N,M,EPS)
	DIMENSION P(M),X(20),G(20)
	DOUBLE PRECISION P,X,G,H,U,D,A,B,XX,X0,S,T,YY
	IF (N.GE.20) N=19
	D=1.0D+35
	DO 10 K=0,N
	  T=COS((N-K)*3.1415926/(1.0*N))
	  X(K+1)=(B+A+(B-A)*T)/2.0
10	CONTINUE
15	U=1.0
	DO 20 I=1,M
	  P(I)=F(X(I))
	  G(I)=-U
	  U=-U
20	CONTINUE
	DO 30 J=1,N
	  K=M
	  S=P(K)
	  XX=G(K)
	  DO 25 I=J,N
	    T=P(N-I+J)
	    X0=G(N-I+J)
	    P(K)=(S-T)/(X(K)-X(M-I))
	    G(K)=(XX-X0)/(X(K)-X(M-I))
	    K=N-I+J
	    S=T
	    XX=X0
25	  CONTINUE
30	CONTINUE
	U=-P(M)/G(M)
	DO 35 I=1,M
35	P(I)=P(I)+G(I)*U
	DO 50 J=1,N-1
	  K=N-J
	  H=X(K)
	  S=P(K)
	  DO 40 I=M-J,N
	    T=P(I)
	    P(K)=S-H*T
	    S=T
	    K=I
40	  CONTINUE
50	CONTINUE

	P(M)=ABS(U)
	U=P(M)
	IF (ABS(U-D).LE.EPS) RETURN
	D=U
	H=0.1*(B-A)/N
	XX=A
	X0=A
60	IF (X0.LE.B) THEN
	  S=F(X0)
	  T=P(N)
	  DO 70 I=N-1,1,-1
70	  T=T*X0+P(I)
	  S=ABS(S-T)
	  IF (S.GT.U) THEN
	    U=S
	    XX=X0
	  END IF
	  X0=X0+H
	  GOTO 60
	END IF
	S=F(XX)
	T=P(N)
	DO 75 I=N-1,1,-1
75	T=T*XX+P(I)
	YY=S-T
	I=1
	J=N+1
80	IF ((J-I).NE.1) THEN
	  K=(I+J)/2
	  IF (XX.LT.X(K)) THEN
	    J=K
	  ELSE
	    I=K
	  END IF
	  GOTO 80
	END IF
	IF (XX.LT.X(1)) THEN
	  S=F(X(1))
	  T=P(N)
	  DO 90 K=N-1,1,-1
90	  T=T*X(1)+P(K)
	  S=S-T

	  IF (S*YY.GT.0.0) THEN
	    X(1)=XX
	  ELSE
	    DO 95 K=N,1,-1
95	    X(K+1)=X(K)
	    X(1)=XX
	  END IF
	ELSE IF (XX.GT.X(N+1)) THEN
	  S=F(X(N+1))
	  T=P(N)
	  DO 100 K=N-1,1,-1
100	  T=T*X(N+1)+P(K)
	  S=S-T
	  IF (S*YY.GT.0.0) THEN
	    X(N+1)=XX
	  ELSE
	    DO 105 K=1,N
105	    X(K)=X(K+1)
	    X(N+1)=XX
	  END IF
	ELSE
	  S=F(X(I))
	  T=P(N)
	  DO 110 K=N-1,1,-1
110	  T=T*X(I)+P(K)
	  S=S-T
	  IF (S*YY.GT.0.0) THEN
	    X(I)=XX
	  ELSE
	    X(J)=XX
	  END IF
	END IF
	GOTO 15
	RETURN
	END

