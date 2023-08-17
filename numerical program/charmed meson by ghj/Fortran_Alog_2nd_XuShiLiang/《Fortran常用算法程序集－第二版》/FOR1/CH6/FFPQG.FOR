
	SUBROUTINE FFPQG(A,B,F,EPS,G,L)
	DIMENSION BB(10),H(10)
	DOUBLE PRECISION A,B,F,G,BB,H,HH,T1,S1,S,X,T2
	M=1
	N=1
	H(1)=B-A
	HH=B-A
	T1=HH*(F(A)+F(B))/2.0
	S1=T1
	BB(1)=S1
5	S=0.0
	DO 10 K=0,N-1
	  X=A+(K+0.5)*HH
	  S=S+F(X)
10	CONTINUE
	T2=(T1+HH*S)/2.0
	M=M+1
	H(M)=H(M-1)/2.0
	G=T2
	DO 20 J=2,M
	  S=G-BB(J-1)
	  IF (ABS(S)+1.0.EQ.1.0) THEN
	    S=SIGN(1.0D+35,S)
	    G=S*SIGN(1.0D0,H(M)-H(J-1))
	  ELSE
	    G=(H(M)-H(J-1))/S
	  END IF
20	CONTINUE
	BB(M)=G
	G=BB(M)
	DO 30 J=M,2,-1
	  IF (ABS(G)+1.0.EQ.1.0) THEN
	    G=SIGN(1.0D+35,G)
	    G=G*SIGN(1.0D0,H(J-1))
	    G=BB(J-1)-G
	  ELSE
	    G=BB(J-1)-H(J-1)/G
	  END IF
30	CONTINUE
	IF ((ABS(G-S1).GE.EPS).AND.(M.LE.9)) THEN
	  N=N+N
	  T1=T2
	  S1=G
	  HH=HH/2.0
	  GOTO 5
	END IF
	IF (M.GE.10) THEN
	  L=0
	ELSE
	  L=1
	END IF
	RETURN
	END

