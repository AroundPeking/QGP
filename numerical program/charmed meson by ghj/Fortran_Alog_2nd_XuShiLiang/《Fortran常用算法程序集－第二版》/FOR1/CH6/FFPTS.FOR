
	SUBROUTINE FFPTS(A,B,F,EPS,T)
	DIMENSION S(30,7)
	DOUBLE PRECISION A,B,F,T,S,F0,F1,P,H,X,F3,T1,T2
	T=0.0
	F0=F(A)
	F1=F(B)
	P=H*(F0+F1)/2.0
	K=1
	S(K,1)=A
	S(K,2)=B
	S(K,3)=B-A
	S(K,4)=F0
	S(K,5)=F1
	S(K,6)=P
	S(K,7)=EPS
10	IF (K.NE.0) THEN
	  H=S(K,3)
	  X=S(K,1)+H/2.0
	  F3=F(X)
	  T1=H*(S(K,4)+F3)/4.0
	  T2=H*(F3+S(K,5))/4.0
	  IF ((ABS(S(K,6)-T1-T2).LT.S(K,7)).OR.(K.GE.29)) THEN
	    T=T+(T1+T2)
	    K=K-1
	  ELSE
	    S(K+1,1)=X
	    S(K+1,2)=S(K,2)
	    S(K,2)=X
	    S(K,3)=H/2.0
	    S(K+1,3)=S(K,3)
	    S(K+1,4)=F3
	    S(K+1,5)=S(K,5)
	    S(K,5)=F3
	    S(K,7)=S(K,7)/1.4
	    S(K+1,7)=S(K,7)
	    S(K,6)=T1
	    S(K+1,6)=T2
	    K=K+1
	  END IF
	  GOTO 10
	END IF
	RETURN
	END

