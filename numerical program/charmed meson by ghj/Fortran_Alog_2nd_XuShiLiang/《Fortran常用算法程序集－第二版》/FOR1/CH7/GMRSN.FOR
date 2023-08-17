
	SUBROUTINE GMRSN(T,H,N,Y,M,Z,F,EPS,D,U,A,B,C,V)
	DIMENSION Y(M),D(M),U(M),A(M),B(M)
	DIMENSION C(M),V(M),Z(M,N)
	DOUBLE PRECISION Y,D,U,A,B,C,V,Z,T,H,AA,X,HH,DT,T0,QQ
	AA=T
	DO 90 I=1,M
90	Z(I,1)=Y(I)
	DO 200 I=2,N
	  X=AA+(I-2)*H
	  P=1+EPS
	  NN=1
	  HH=H
	  DO 110 J=1,M
110	  U(J)=Y(J)
120	  IF (P.GE.EPS) THEN
	    DO 130 J=1,M
	      V(J)=Y(J)
	      Y(J)=U(J)
130	    CONTINUE
	    DT=H/NN
	    T=X
	    DO 160 K=1,NN
	      CALL F(T,Y,M,D)
	      DO 135 J=1,M
	        A(J)=D(J)
	        Y(J)=Y(J)+HH*D(J)/3.0
135	      CONTINUE
	      T0=T+HH/3.0
	      CALL F(T0,Y,M,D)
	      DO 140 J=1,M
	        B(J)=D(J)
	        Y(J)=Y(J)+HH*(D(J)-A(J))/6.0
140	      CONTINUE
	      CALL F(T0,Y,M,D)
	      DO 145 J=1,M
	        B(J)=D(J)
	        Y(J)=Y(J)+3*HH*(D(J)-4*(B(J)+A(J)/4.0)/9.0)/8.0
145	      CONTINUE
	      T0=T+HH/2.0
	      CALL F(T0,Y,M,D)
	      DO 150 J=1,M
	        C(J)=D(J)
	        QQ=D(J)-15*(B(J)-A(J)/5.0)/16.0
	        Y(J)=Y(J)+2*HH*QQ
150	      CONTINUE


	      T0=T+HH
	      CALL F(T0,Y,M,D)
	      DO 155 J=1,M
	        QQ=D(J)-8*(C(J)-9*(B(J)-2*A(J)/9.0)/8.0)
	        Y(J)=Y(J)+HH*QQ/6.0
155	      CONTINUE
	      T=T+DT
160	    CONTINUE
	    P=0.0
	    DO 165 J=1,M
	      QQ=ABS(Y(J)-V(J))
	      IF (QQ.GT.P) P=QQ
165	    CONTINUE
	    HH=HH/2.0
	    NN=NN+NN
	    GOTO 120
	  ELSE
	    DO 170 J=1,M
170	    Z(J,I)=Y(J)
	  END IF
200	CONTINUE
	T=AA
	RETURN
	END

