
function [Q2matriz,R2matriz,NCmatriz] = cvPLS (Xnormalizado, Ynormalizado, NCOMP,K)

 
  
  NCOMPi=1;
  
  
  for NCOMPi=1:NCOMP
  
    
    PRESS=0; %medida del error de predicción, valor inicial es 0
    i=1;%ubicacion de fila de la matriz
    j=0;%indica numero de grupo analizado
    
    [m,n]=size(Xnormalizado); %m es el numero de individuos
    
    individuosxgrupo=round(m/K);
    
    totalindividuos=0;
    
    
    do
        %se repite para las k iteraciones
        j=j+1;
        
        %datos de prueba CV
        Ycvp = Ynormalizado (i:i+individuosxgrupo-1,:);
        Xcvp = Xnormalizado (i:i+individuosxgrupo-1,:);
        
        
        %datos de entrenamiento CV
        
      if(j==1) %para la primera iteracion
        Ycve = Ynormalizado (i+individuosxgrupo:m,:);
        Xcve = Xnormalizado (i+individuosxgrupo:m,:);
      elseif(j==K) %para la última iteracion
        Ycve = Ynormalizado (1:i-1,:);
        Xcve = Xnormalizado (1:i-1,:);
      else
        
        Ycve = [Ynormalizado(1:(i-1),:);Ynormalizado((i+individuosxgrupo):m,:)];
        Xcve = [Xnormalizado(1:(i-1),:);Xnormalizado((i+individuosxgrupo):m,:)];
        
      endif      
        
        i=i+individuosxgrupo;
        totalindividuos=totalindividuos+individuosxgrupo;
        
        if(j<K)
        individuosxgrupo=round((m-totalindividuos)/(K-j));
        endif   
        
        
        %construir modelo con datos de entrenamiento
        
        [Bpls] = NIPALSreducido (Xcve, Ycve, NCOMPi);
        
        %Hacer la predicción y calcular residuos
        
        Ycvp_pred=Xcvp*Bpls;  
        Error=Ycvp-Ycvp_pred; 

        %calcular el PRESS para el grupo  
        PRESS=PRESS+norm(Error*Error');
    
     until (j==K)
    
    
    SCT=Ynormalizado'*Ynormalizado;
    
    Q2=1-(PRESS/SCT);
    
    
    [Bpls] = NIPALSreducido (Xnormalizado, Ynormalizado, NCOMPi);
    Error=Ynormalizado-(Xnormalizado*Bpls); 
    R2=1-(norm(Error*Error')/SCT);
    
    
      if(NCOMPi==1)
      R2matriz=R2;
      Q2matriz=Q2;
      NCmatriz=NCOMPi;
     
     else  
      R2matriz=[R2matriz,R2];
      Q2matriz=[Q2matriz,Q2];
      NCmatriz=[NCmatriz,NCOMPi];


    endif    
  
  endfor 
  


endfunction

 