

	SUBROUTINE KKABG(N,X,T,A,B,C,Y)
	DIMENSION X(N),Y(N)
	DO 10 I=1,N
	  S1=SS+T*VV+T*T*AA/2.0
	  V1=VV+T*AA
	  A1=AA
	  SS=S1+A*(X(I)-S1)
	  Y(I)=SS
	  VV=V1+B*(X(I)-S1)
	  AA=A1+2.0*C*(X(I)-S1)/(T*T)
10	CONTINUE
	RETURN
	END

