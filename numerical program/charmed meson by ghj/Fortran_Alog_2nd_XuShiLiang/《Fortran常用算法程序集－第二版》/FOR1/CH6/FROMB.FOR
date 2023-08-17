
	SUBROUTINE FROMB(A,B,F,EPS,T)
	DIMENSION Y(10)
	DOUBLE PRECISION A,B,F,T,Y,H,P,S,Q
	H=B-A
	Y(1)=H*(F(A)+F(B))/2.0
	M=1
	N=1
10	P=0.0
	DO 20 I=0,N-1
20	P=P+F(A+(I+0.5)*H)
	P=(Y(1)+H*P)/2.0
	S=1.0
	DO 30 K=1,M
	  S=4*S
	  Q=(S*P-Y(K))/(S-1)
	  Y(K)=P
	  P=Q
30	CONTINUE
	IF ((ABS(Q-Y(M)).GE.EPS).AND.(M.LE.9)) THEN
	  M=M+1
	  Y(M)=Q
	  N=N+N
	  H=H/2.0
	  GOTO 10
	END IF
	T=Q
	RETURN
	END
