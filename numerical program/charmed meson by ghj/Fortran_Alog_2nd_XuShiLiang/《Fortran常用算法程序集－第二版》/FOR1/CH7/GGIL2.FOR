
	SUBROUTINE GGIL2(T,H,N,Y,M,Z,F,EPS,D,Q,U,V,G)
	DIMENSION Y(M),D(M),Z(M,N),A(4),B(4),C(4),E(4)
	DIMENSION Q(M),U(M),V(M),G(M)
	DOUBLE PRECISION Y,D,Z,A,B,C,E,Q,U,V,G,
     *                   T,H,AA,X,HH,DT,R,S,T0
	DATA A/0.5,0.29289321881,1.7071067812,0.166666667/
	DATA B/2.0,1.0,1.0,2.0/
	DATA E/0.5,0.5,1.0,1.0/
	AA=T
	DO 10 I=1,3
10	C(I)=A(I)
	C(4)=0.5
	DO 20 I=1,M
20	Z(I,1)=Y(I)
	DO 30 I=1,M
30	Q(I)=0.0
	DO 200 I=2,N
	  X=AA+(I-2)*H
	  P=1+EPS
	  NN=1
	  HH=H
	  DO 40 J=1,M
40	  U(J)=Y(J)
50	  IF (P.GE.EPS) THEN
	    DO 60 J=1,M
	      V(J)=Y(J)
	      Y(J)=U(J)
	      G(J)=Q(J)
60	    CONTINUE
	    DT=H/NN
	    T=X
	    DO 180 K=1,NN
	      CALL F(T,Y,M,D)
	      DO 160 II=1,4
	        DO 70 J=1,M
70	        D(J)=D(J)*HH
	        DO 140 J=1,M
	          R=(A(II)*(D(J)-B(II)*G(J))+Y(J))-Y(J)
	          Y(J)=Y(J)+R
	          S=G(J)+3.0*R
	          G(J)=S-C(II)*D(J)
140	        CONTINUE
	        T0=T+E(II)*HH
	        CALL F(T0,Y,M,D)
160	      CONTINUE
	      T=T+DT
180	    CONTINUE


	    P=0.0
	    DO 190 J=1,M
	      QQ=ABS(Y(J)-V(J))
	      IF (QQ.GT.P) P=QQ
190	    CONTINUE
	    HH=HH/2.0
	    NN=NN+NN
	    GOTO 50
	  ELSE
	    DO 195 J=1,M
	      Q(J)=G(J)
	      Z(J,I)=Y(J)
195	    CONTINUE
	  END IF
200	CONTINUE
	T=AA
	RETURN
	END

  