function [Bplsmatriz] = validacioncoeficientesPLS(Xnormalizado, Ynormalizado, NCOMP,K)

 

  

  
    
    PRESS=0; %medida del error de predicción, valor inicial es 0
    i=1;%ubicacion de fila de la matriz
    j=0;%indica numero de grupo analizado
    
    [m,n]=size(Xnormalizado); %m es el numero de individuos
    
    individuosxgrupo=round(m/K);
    
    totalindividuos=0;
    
    
    do
        %se repite para las k iteraciones
        j=j+1;
        
               
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
        
        [Bpls] = NIPALSreducido (Xcve, Ycve, NCOMP);
        
       
           if(j==1)
            Bplsmatriz=Bpls;
           
           else  
            Bplsmatriz=[Bplsmatriz,Bpls];
 
           endif  
        
    
     
     until (j==K)
    
    
    
    
    
      
      
  

  


endfunction

 