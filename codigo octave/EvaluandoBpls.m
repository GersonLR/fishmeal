clear
datos=load('BDreducido2.txt');


train=datos(31:122,:); % datos de entrenamiento
prueba=datos(1:30,:); % datos de prueba
C(1:10)={"PROTEINA",	"GRASA","HUMEDAD",	"CENIZAS",	"CLORURO",	"ARENA",	"TBVN",	"AGL",	"HISTAMINA",	"REM.A/O"};


%CP(1:10)={15,	12,16,	0,	0,	0,	18,	0,	18,	0};


N=rows (train);

%proteina=1
%grasa=2
%humedad=3
%TBVN=7
%HISTAMINA=9

vx=250; %250 incluye bandas en su expresión, 490 incluye bandas en su expresión cuadrática

NCOMP=15;


  for i=1:10
  
  %if((i==1) || (i==2) || (i==3) || (i==7) || (i==9))
  if(i==1)
    Yoriginal=train(:,i);%variable Y

    Xoriginal=train(:,11:vx);

    ## Mean centering and rescaled Data X
   
    Xmeans = mean (Xoriginal);
    Xstd=std (Xoriginal);
    Xnormalizado = bsxfun (@rdivide, bsxfun (@minus,Xoriginal, Xmeans), Xstd);

    ## Mean centering and rescaled Data Y
    Ymeans = mean (Yoriginal);
    Ystd=std (Yoriginal);
    Ynormalizado = bsxfun (@rdivide, bsxfun (@minus, Yoriginal, Ymeans), Ystd);
    
    
    

    [Bplsmatriz] = coeficientesPLS (Xnormalizado, Ynormalizado, NCOMP,50);
    
    
    Bplsmatriz=Bplsmatriz';
    
          
         
         
      endif  
      
  
    
endfor