
function [VIP] = VIP_PLS (X, Y, NCOMP, bandas)

 

  SCT=Y'*Y;
  
  Rmatriz=[0];
  %INICIO DE ALGORITMO NIPALS PARA PLS
  
  
  
  
  for i = 1:NCOMP
    
  unew=Y(:,1); %escoger primera columna 
  
  do
  u=unew;
  w=X'*u/ (u'*u);
  w=w/norm(w); %escalar vector w a longitud unitaria
  t=X*w/(w'*w);
  c=Y'*t/(t'*t);
  %c=c/norm(c); %escalar vector c a longitud unitaria
  unew=Y*c/(c'*c);
  until (norm(u-unew)<=0.0001);
  
  p=X'*t/(t'*t);
  q=Y'*u/(u'*u);
  
  
  
   
  
  E=X-(t*p');
  F=Y-(t*c');
  
  

  R2=1-(norm(F*F')/SCT)-sum(Rmatriz');
  
  
  X=E;
  Y=F;
  
  if(i==1)
    Umatriz=u;
    Tmatriz=t;
    Wmatriz=w;
    Cmatriz=c;
    Pmatriz=p;
    Qmatriz=q;
    Rmatriz=R2;

   else  
    Umatriz=[Umatriz,u];
    Tmatriz=[Tmatriz,t];
    Wmatriz=[Wmatriz,w];
    Cmatriz=[Cmatriz,c];
    Pmatriz=[Pmatriz,p];
    Qmatriz=[Qmatriz,q];
    Rmatriz=[Rmatriz,R2];

  endif  
 
endfor

 Bpls=Wmatriz*inv(Pmatriz'*Wmatriz)*Cmatriz';
 
 W2=bsxfun (@times,Wmatriz,Wmatriz);
 
 VIP=W2*Rmatriz';
 
 
 VIP = bsxfun(@times, VIP, bandas/sum(Rmatriz'));
 
 VIP = bsxfun(@power, VIP, 0.5);




  endfunction