
%los valores ya deben estar centrados y escalados

%los coeficientes que retorna estan normalizados

function [Bpls] = NIPALSreducido (X, Y, NCOMP)
  
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
  
  
  X=E;
  Y=F;  
  
  
  if(i==1)
    Umatriz=u;
    Tmatriz=t;
    Wmatriz=w;
    Cmatriz=c;
    Pmatriz=p;
    Qmatriz=q;

   else  
    Umatriz=[Umatriz,u];
    Tmatriz=[Tmatriz,t];
    Wmatriz=[Wmatriz,w];
    Cmatriz=[Cmatriz,c];
    Pmatriz=[Pmatriz,p];
    Qmatriz=[Qmatriz,q];

  endif  
 
endfor

 Bpls=Wmatriz*inv(Pmatriz'*Wmatriz)*Cmatriz';
 
 %Bpls=Wmatriz*inv((X'*Tmatriz/(Tmatriz'*Tmatriz))'*Wmatriz)*Cmatriz';
 
 %Error=Ynormalizado-(Xnormalizado*Bpls); 
 %R2=1-(norm(Error*Error')/SCT);
 
 
 




  endfunction