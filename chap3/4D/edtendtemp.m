
AUX=0.5*(A11+A22);
if (abs(AUX)<1) 
  PHASE1=acos(0.5*(A11+A22));
  SP1=sin(PHASE1);
  if (SP1<1E-10 && abs(A12)<1E-10)
    BETA1=1;                %..nulldurchnull
    ALPHA1=0;
  elseif (abs(SP1)<1E-10)
    BETA1=1;
    ALPHA1=0;
  else   
    BETA1=A12/SP1;
    ALPHA1=0.5D0*(A11-A22)/SP1;
  end
  if (BETA1<0) 
    PHASE1=-PHASE1;
    if (abs(sin(PHASE1))<1E-10)
      BETA1=1D0;
      ALPHA1=0D0;
    else
      BETA1=A12/SIN(PHASE1);
      ALPHA1=0.5D0*(A11-A22)/SIN(PHASE1);
    end
  end
  TUNE1=PHASE1/(2*pi)
  if (TUNE1<0) 
    TUNE1=1+TUNE1;
  else   % unstable
    PHASE1=0;
    BETA1=0;
    ALPHA1=0;
    TUNE1=0;
  end
 TUNE1
  
  AUX=0.5*(B11+B22);
  if (abs(AUX)<1)
    PHASE2=acos(0.5*(B11+B22));
    SP2=sin(PHASE2);
    if (SP2<1E-10 && abs(B12)<1E-10)
      BETA2=1;               %..nulldurchnull
      ALPHA2=0;
    elseif (abs(SP2)<1E-10)
      BETA2=1;
      ALPHA2=0; 
    else
      BETA2=B12/SP2;
      ALPHA2=0.5D0*(B11-B22)/SP2;
    end
    if (BETA2<0)
      PHASE2=-PHASE2;
      if (abs(sin(PHASE2))<1E-10) 
        BETA2=1;
        ALPHA2=0;
      else
        BETA2=B12/SIN(PHASE2);
        ALPHA2=0.5D0*(B11-B22)/SIN(PHASE2);
      end
    end
    TUNE2=PHASE2/(2*pi)
    if (TUNE2<0) 
      TUNE2=1+TUNE2;
    else
      PHASE2=0;
      BETA2=0;
      ALPHA2=0;
      TUNE2=0;
    end
  end
end
out=[TUNE1,BETA1,ALPHA1,TUNE2,BETA2,ALPHA2,phi,D11,D12,D21,D22]
