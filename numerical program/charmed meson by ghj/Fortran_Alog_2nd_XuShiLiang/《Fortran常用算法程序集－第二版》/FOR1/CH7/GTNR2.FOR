
	SUBROUTINE GTNR2(A,H,N,Y,M,W,F,D,P,Z,G,R)
	DIMENSION Y(M),D(M),W(M,N),Z(4,M),G(4,M)
	DIMENSION P(M),R(4,M)
	DOUBLE PRECISION Y,D,W,Z,G,P,R,A,H,T,S,AA,BB,DD,Q,DY,DY1
	DO 10 J=1,M
10	W(J,1)=Y(J)
	DO 200 I=2,N
	  T=A+(I-2)*H
	  DO 50 J=1,M
50	  Z(1,J)=Y(J)
	  CALL F(T,Y,M,D)
	  DO 60 J=1,M
	    G(1,J)=D(J)
	    Y(J)=Z(1,J)+H*D(J)/2.0
	    Z(2,J)=Y(J)
60	  CONTINUE
	  S=T+H/2.0
	  CALL F(S,Y,M,D)
	  DO 70 J=1,M
	    G(2,J)=D(J)
	    Y(J)=Z(1,J)+H*D(J)/2.0
	    Z(3,J)=Y(J)
70	  CONTINUE
	  CALL F(S,Y,M,D)
	  DO 80 J=1,M
80	  G(3,J)=D(J)


	  DO 90 J=1,M
	    AA=G(3,J)-G(2,J)
	    BB=Z(3,J)-Z(2,J)
	    IF (-AA*BB*H.GT.0.0) THEN
	      P(J)=-AA/BB
	      DD=-P(J)*H
	      R(1,J)=EXP(DD)
	      R(2,J)=(R(1,J)-1)/DD
	      R(3,J)=(R(2,J)-1)/DD
	      R(4,J)=(R(3,J)-1)/DD
	    ELSE
	      P(J)=0.0
	    END IF
	    IF (P(J).LE.0.0) THEN
	      Q=G(3,J)
	    ELSE
	      Q=2*(G(3,J)-G(1,J))*R(3,J)
	      Q=Q+(G(1,J)-G(2,J))*R(2,J)+G(2,J)
	    END IF
	    Z(4,J)=Z(1,J)+Q*H
	    Y(J)=Z(4,J)
90	  CONTINUE
	  S=T+H
	  CALL F(S,Y,M,D)
	  DO 100 J=1,M
100	  G(4,J)=D(J)
	  DO 110 J=1,M
	    IF (P(J).LE.0.0) THEN
	      DY=(G(1,j)+2*(G(2,j)+G(3,j))+G(4,j))*h/6.0
	    ELSE
	      DY=-3*(G(1,J)+P(J)*Z(1,J))+2*(G(2,J)+P(J)*Z(2,J))
	      DY=DY+2*(G(3,J)+P(J)*Z(3,J))-(G(4,J)+P(J)*Z(4,J))
	      DY=DY*R(3,J)+G(1,J)*R(2,J)
	      DY1=G(1,J)-G(2,J)-G(3,J)+G(4,J)
	      DY1=DY1+(Z(1,J)-Z(2,J)-Z(3,J)+Z(4,J))*P(J)
	      DY=(DY+4*DY1*R(4,J))*H
	    END IF
	    Y(J)=Z(1,J)+DY
	    W(J,I)=Y(J)
110	  CONTINUE
200	CONTINUE
	RETURN
	END

