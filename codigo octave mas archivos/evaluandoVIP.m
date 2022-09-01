
%por modificar



clear
datos=load('BDreducido2.txt');



train=datos(31:122,:); % datos de entrenamiento
prueba=datos(1:30,:); % datos de prueba

C(1:10)={"PROTEINA(DUMAS)",	"GRASA","HUMEDAD",	"CENIZAS",	"CLORURO",	"ARENA",	"TBVN",	"AGL",	"HISTAMINA",	"REM-A/O"};

%proteina=1, CP=15 con 250, CP=10 con 490, CP=10 con VIP>1(101 bandas+y)
%grasa=2, CP=12
%humedad=3, CP=16
%TBVN=7, CP=18
%HISTAMINA=9, CP=18

i=1;
CP=15;


vx=250; %250 incluye bandas en su expresión, 490 incluye bandas en su expresión cuadrática

bandas=vx-10;



%datos no usados en generación de modelo
Yprueba=prueba(:,i);
Xprueba=prueba(:,11:vx);





Yoriginal=train(:,i);%variable Y

Xoriginal=train(:,11:vx);%espectro

  ## Mean centering and rescaled Data X
 
  Xmeans = mean (Xoriginal);
  Xstd=std (Xoriginal);
  Xnormalizado = bsxfun (@rdivide, bsxfun (@minus,Xoriginal, Xmeans), Xstd);
 

  ## Mean centering and rescaled Data Y
  Ymeans = mean (Yoriginal);
  Ystd=std (Yoriginal);
  Ynormalizado = bsxfun (@rdivide, bsxfun (@minus, Yoriginal, Ymeans), Ystd);
  
  
  [Bpls,VIP,Rmatriz,Pmatriz] = VIP_PLS (Xnormalizado, Ynormalizado, CP,bandas);
  
  
   

  %VIPmatriz=[VIP';espectro];
  [bandasVIP1] = find (VIP>=1);
  
  %Filtrando matriz
  VIPmatriz=datos(:,1:10);
  
  for k=1:bandas
  
     if(find(bandasVIP1==k)>=1)
               
           VIPmatriz=[VIPmatriz,datos(:,k+10)];
                   
        
      endif
  
  endfor
  
 
  


  
  
  figure(10)
    plot (VIP, "-*r");
    grid on
  xlabel ("Banda espectro")
    ylabel ("VIP")
    title(C(i));
  
  
  %plot(Pmatriz(:,1),Pmatriz(:,2),"*r")
  %hold on
  %plot(Ypredichooriginal,Yoriginal,"*b;entrenamiento;")
  
  
  
  %xlabel ("predicho");
  %ylabel ("real");
  %title(C(i));
  %axis ([70 200 70 200]);
  