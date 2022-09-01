clear
datos=load('BDentrenamiento.txt');
%datos=VIPmatriz;


train=datos(31:122,:); % datos de entrenamiento
prueba=datos(1:30,:); % datos de prueba
 C(1:10)={"PROTEIN",	"FAT","MOISTURE",	"ASH",	"CLORURO",	"SAND",	"TBVN",	"AGL",	"HISTAMINE",	"REM.A/O"};


CP(1:10)={15,	12,16,	0,	0,	0,	18,	0,	18,	0};
AxesY(1:10)={70,	70,60,	100,	100,	100,	100,	100,	100,	100};


N=rows (train);

%proteina=1
%grasa=2
%humedad=3
%TBVN=7
%HISTAMINA=9

vx=250; %250 incluye bandas en su expresión, 490 incluye bandas en su expresión cuadrática
componentes=15; %por defecto 40;


  for i=1:10
  
  %if((i==1) || (i==2) || (i==3) || (i==7) || (i==9))
  if(i==1)
    Yoriginal=train(:,i);%variable Y

    Xoriginal=train(:,11:vx);

%utilizamos funcion normalizar / devuelve matriz centralizada a 0 y reescalada a la unidad
    [Xnormalizado,Xmeans,Xstd] = normalizar(Xoriginal);
    [Ynormalizado,Ymeans,Ystd] = normalizar(Yoriginal);   
    [Q2K1,R2K1,NCK1] = cvPLS (Xnormalizado, Ynormalizado, componentes,N); %N es el total de datos que se dispone
    [Q2K5,R2K5,NCK5] = cvPLS (Xnormalizado, Ynormalizado, componentes,5);
    [Q2K10,R2K10,NCK10] = cvPLS (Xnormalizado, Ynormalizado, componentes,10);
    [Q2K20,R2K20,NCK20] = cvPLS (Xnormalizado, Ynormalizado, componentes,20);
    
    
    
    
    figure(i)
    %plot (NCK1, bsxfun (@times,R2K1,100), "-*r;R2;");
    %hold on
    plot( NCK1,bsxfun (@times,Q2K1,100),  "-b;Q2 (LOO);","linewidth", 3);
    hold on
    plot( NCK1, bsxfun (@times,Q2K5,100),  "-g;Q2 (K=5);","linewidth", 3);
    hold on
    plot( NCK1, bsxfun (@times,Q2K10,100),  ":k;Q2 (K=10);","linewidth", 3);
    hold on
    plot( NCK1, bsxfun (@times,Q2K20,100),  "-r;Q2 (K=20);","linewidth", 3);
    grid on
    %legend("hide")
    xlabel ("Componentes principales PLS")
    ylabel ("%")
    title(C(i));
    
    
    
    %AGREGAR LINEA DE COMPONENTE SELECCIONADA
    %plot(CP(i),0:0.1:100)
    set(gca, "fontsize", 15)
    copied_legend = findobj(gcf(),"type","axes","Tag","legend");
    set(copied_legend, "FontSize", 20, "location", "southeast");
    
    
    
    
    #almacena los Q2 maximo y la componente donde se alcanzo por variable
    Q2maximo=max(Q2K1);
    Componente=find (Q2K1>=Q2maximo);
    HQ2=[C(:,i),Componente,Q2maximo];
      if(i==1)
          HistoricoQ2=HQ2;
          
      else  
          HistoricoQ2=[HistoricoQ2;HQ2];
          
      endif  
    endif
    
endfor