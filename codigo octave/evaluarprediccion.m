clear
datos=load('BDreducido.txt');
%datos=VIPmatriz;

train=datos(31:122,:); % datos de entrenamiento
prueba=datos(1:30,:); % datos de prueba

C(1:10)={"PROTEINA",	"GRASA","HUMEDAD",	"CENIZAS",	"CLORURO",	"ARENA",	"TBVN",	"AGL",	"HISTAMINA",	"REM-A/O"};


%proteina=1, CP=15 con 250, CP=10 con 490, CP=10 con VIP>1(101 bandas+y)
%grasa=2, CP=12
%humedad=3, CP=16
%TBVN=7, CP=18
%HISTAMINA=9, CP=18

i=1;
CP=15;

vx=250; %250 incluye bandas en su expresión, 490 incluye bandas en su expresión cuadrática


%datos no usados en generación de modelo
Yprueba=prueba(:,i);
%Yprueba=bsxfun(@power, Yprueba, 0.5);

Xprueba=prueba(:,11:vx);


Yoriginal=train(:,i);%variable Y
%Yoriginal=bsxfun(@power, Yoriginal, 0.5);

Xoriginal=train(:,11:vx);%espectro

  ## Mean centering and rescaled Data X
 
  Xmeans = mean (Xoriginal);
  Xstd=std (Xoriginal);
  Xnormalizado = bsxfun (@rdivide, bsxfun (@minus,Xoriginal, Xmeans), Xstd);
 

  ## Mean centering and rescaled Data Y
  Ymeans = mean (Yoriginal);
  Ystd=std (Yoriginal);
  Ynormalizado = bsxfun (@rdivide, bsxfun (@minus, Yoriginal, Ymeans), Ystd);
  
  [Bpls] = NIPALSreducido (Xnormalizado, Ynormalizado, CP);
  
    BplsNE= bsxfun (@times,bsxfun (@rdivide, Bpls', Xstd),Ystd)';%coeficientes PLS no normalizados
    Bo=Ymeans-Xmeans*BplsNE;%coeficiente B0
 

  
  %Ypredicho=bsxfun (@plus,Xoriginal*BplsNE,Bo);
  
  
  
  Ypredichoprueba= bsxfun (@plus,Xprueba*BplsNE, Bo);
  Ypredichooriginal= bsxfun (@plus,Xoriginal*BplsNE, Bo);
  
  
  %calculo del RMSE
  Error=bsxfun (@minus,Ypredichoprueba, Yprueba);
  RMSE=Error'*Error;
  RMSE=bsxfun (@rdivide,RMSE,rows (Ypredichoprueba));
  RMSE=bsxfun(@power, RMSE, 0.5);
 
  MAE=bsxfun (@power,Error, 2);
  MAE=bsxfun(@power, MAE, 0.5);
  MaximoError=max(MAE);
  MAE=mean(MAE);
  
  SCT=(Yprueba-mean(Yprueba))'*(Yprueba-mean(Yprueba));
  SCR=Error'*Error;
  R2=1-(SCR/SCT);
  
  figure(19)
  plot(Ypredichoprueba,Yprueba,"*r;prueba;")
  %hold on
  %plot(Ypredichooriginal,Yoriginal,"*b;entrenamiento;")
  
  
  
  xlabel ("predicho");
  ylabel ("real");
  
  %text( min(Ypredichoprueba), max(Yprueba), strcat("MAE=",num2str (MAE),", RMSE=",num2str (RMSE)," ,MAX-ERROR=",num2str (MaximoError)," ,R2=",num2str (R2)));
  
  
  
  title(strcat(C(i)," - MODELO PLS CP=",num2str (CP)));
  axis ([0 5000 0 5000]);
  