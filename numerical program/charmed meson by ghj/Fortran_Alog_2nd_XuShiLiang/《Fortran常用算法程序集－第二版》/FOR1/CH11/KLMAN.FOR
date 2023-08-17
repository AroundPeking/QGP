

	SUBROUTINE KLMAN(N,M,K,F,Q,R,H,Y,X,P,G,L,E,IA,A,B,IS,JS)
	DIMENSION F(N,N),Q(N,N),R(M,M),H(M,N),Y(K,M),X(K,N)
	DIMENSION P(N,N),G(N,M),E(M,M),A(IA,IA),B(IA,IA)
	DIMENSION IS(M),JS(M)
	DOUBLE PRECISION F,Q,R,H,Y,X,P,G,E,A,B
	DO 2 I=1,N
	DO 2 J=1,N
	  A(I,J)=0.0
	  DO 1 KK=1,N
1	  A(I,J)=A(I,J)+P(I,KK)*F(J,KK)
2	CONTINUE
	DO 4 I=1,N
	DO 4 J=1,N
	  P(I,J)=Q(I,J)
	  DO 3 KK=1,N
3	  P(I,J)=P(I,J)+F(I,KK)*A(KK,J)
4	CONTINUE

	DO 300 II=2,K
	  DO 20 I=1,N
	  DO 20 J=1,M
	    A(I,J)=0.0
	    DO 10 KK=1,N
10	    A(I,J)=A(I,J)+P(I,KK)*H(J,KK)
20	  CONTINUE
	  DO 40 I=1,M
	  DO 40 J=1,M
	    E(I,J)=R(I,J)
	    DO 30 KK=1,N
30	    E(I,J)=E(I,J)+H(I,KK)*A(KK,J)
40	  CONTINUE
	  CALL BRINV(E,M,L,IS,JS)
	  IF (L.EQ.0) RETURN
	  DO 60 I=1,N
	  DO 60 J=1,M
	    G(I,J)=0.0
	    DO 50 KK=1,M
50	    G(I,J)=G(I,J)+A(I,KK)*E(J,KK)
60	  CONTINUE
	  DO 80 I=1,N
	    X(II,I)=0.0
	    DO 70 J=1,N
70	    X(II,I)=X(II,I)+F(I,J)*X(II-1,J)
80	  CONTINUE
	  DO 100 I=1,M
	    B(I,1)=Y(II,I)
	    DO 90 J=1,N
90	    B(I,1)=B(I,1)-H(I,J)*X(II,J)
100	  CONTINUE
	  DO 120 I=1,N
	    DO 110 J=1,M
110	    X(II,I)=X(II,I)+G(I,J)*B(J,1)
120	  CONTINUE
	  IF (II.LT.K) THEN
	    DO 140 I=1,N
	    DO 140 J=1,N
	      A(I,J)=0.0
	      DO 130 KK=1,M
130	      A(I,J)=A(I,J)-G(I,KK)*H(KK,J)
	      IF (I.EQ.J) A(I,J)=1.0+A(I,J)
140	    CONTINUE

	    DO 160 I=1,N
	    DO 160 J=1,N
	      B(I,J)=0.0
	      DO 150 KK=1,N
150	      B(I,J)=B(I,J)+A(I,KK)*P(KK,J)
160	    CONTINUE
	    DO 180 I=1,N
	    DO 180 J=1,N
	      A(I,J)=0.0
	      DO 170 KK=1,N
170	      A(I,J)=A(I,J)+B(I,KK)*F(J,KK)
180	    CONTINUE
	    DO 200 I=1,N
	    DO 200 J=1,N
	      P(I,J)=Q(I,J)
	      DO 190 KK=1,N
190	      P(I,J)=P(I,J)+F(I,KK)*A(J,KK)
200	    CONTINUE
	  END IF
300	CONTINUE
	L=1
	RETURN
	END


