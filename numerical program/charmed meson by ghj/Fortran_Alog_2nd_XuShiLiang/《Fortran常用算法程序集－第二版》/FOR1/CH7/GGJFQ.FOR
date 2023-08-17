
	SUBROUTINE GGJFQ(A,H,N,Y,M,Z,F,D,EPS,P,F1,F2,F3,G)
	DIMENSION Y(M),D(M),Z(M,N),P(M),F1(M),F2(M),F3(M),G(M)
	DOUBLE PRECISION Y,D,Z,P,F1,F2,F3,A,H,T,QQ,G
	DO 5 I=1,M
5	P(I)=0.0
	DO 10 I=1,M
10	Z(I,1)=Y(I)
	T=A
	CALL F(T,Y,M,D)
	DO 20 J=1,M
20	F1(J)=D(J)
	CALL GGIL1(T,H,Y,M,F,EPS,P,D,F3,F2,G)
	T=A+H
	CALL F(T,Y,M,D)
	DO 30 J=1,M
	  Z(J,2)=Y(J)
	  F2(J)=D(J)
30	CONTINUE
	DO 40 J=1,M
	  P(J)=-4*Z(J,2)+5*Z(J,1)+2*H*(2*F2(J)+F1(J))
	  Y(J)=P(J)
40	CONTINUE
	T=A+2*H
	CALL F(T,Y,M,D)
	DO 50 J=1,M
	  QQ=2*H*(D(J)-2*F2(J)-2*F1(J))/3.0
	  QQ=QQ+4*Z(J,2)-3*Z(J,1)
	  Z(J,3)=(P(J)+QQ)/2.0
	  Y(J)=Z(J,3)
50	CONTINUE
	DO 100 I=4,N
	  T=A+(I-2)*H
	  CALL F(T,Y,M,D)
	  DO 60 J=1,M
	    F1(J)=F2(J)
	    F2(J)=D(J)
60	  CONTINUE
	  DO 70 J=1,M
	    P(J)=-4*Z(J,I-1)+5*Z(J,I-2)+2*H*(2*F2(J)+F1(J))
	    Y(J)=P(J)
70	  CONTINUE
	  T=T+H
	  CALL F(T,Y,M,D)
	  DO 80 J=1,M
	    QQ=2*H*(D(J)-2*F2(J)-2*F1(J))/3.0
	    QQ=QQ+4*Z(J,I-1)-3*Z(J,I-2)
	    Z(J,I)=(P(J)+QQ)/2.0
	    Y(J)=Z(J,I)
80	  CONTINUE
100	CONTINUE
	RETURN
	END

