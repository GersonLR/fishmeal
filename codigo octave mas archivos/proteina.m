clear
%datos=load('proteina.txt');
datos=load('proteina - zona1.txt');

%PANEL 
NCOMP=12              %componentes a seleccionar
pivote=10             %valor diferente de 0 activa la evaluacion de prediccion en el NCOMP seleccionado y variando su número en el rango del pivote seleccionado
i=1                 % orden para matriz de encabezados
CPgrafico=25          %Componentes a graficar para evaluar la seleccion
Kfold=50              %kfold para significancia de Bpls
SignificanciaBpls=0   %mostrar significanciaBpls
SeleccionCP=0     %mostrar grafico seleccionCP
Evaluarprediccion=1   %mostrar grafico de prediccion vs real con datos de validación 
EvaluarVIP=0          %Obtener valores VIP para las bandas
bandas=25

Emin=65      %escala minima
Emax=71      %escala maxima
mostrarleyenda=1

% matriz de encabezados
    C(1:10)={"PROTEIN",	"FAT","MOISTURE",	"ASH",	"CLORURO",	"SAND",	"TBVN",	"AGL",	"HISTAMINE",	"REM.A/O"};

%dividimos la data en dos grupos: calibración y validación
    Ycal=datos(31:122,2); % datos de calibracion
    Xcal=datos(31:122,3:(bandas+2)); % datos de calibracion

    Yval=datos(1:30,2); % datos de validacion
    Xval=datos(1:30,3:(bandas+2)); % datos de validacion


%utilizamos funcion normalizar / devuelve matriz centralizada a 0 y reescalada a la unidad
    [Xcal,Xmeans,Xstd] = normalizar(Xcal);
    [Ycal,Ymeans,Ystd] = normalizar(Ycal);

if(SignificanciaBpls==1)

      %Obtiene coeficiente PLS original
      Bpls = NIPALSreducido (Xcal, Ycal, NCOMP);

      %realiza un registro de todos los coeficientes obtenidos cuando obtenemos Kfold modelos. 
      %Un modelo es construido dejando fuera un Kfold. 
      Bplsmatriz = validacioncoeficientesPLS (Xcal, Ycal, NCOMP,Kfold);    
      Bplsmatriz=Bplsmatriz';
 endif

 

 
 
if(SeleccionCP==1)
Bpls = NIPALSreducido (Xcal, Ycal, NCOMP);

      BplsNE= bsxfun (@times,bsxfun (@rdivide, Bpls', Xstd),Ystd)';%coeficientes PLS no normalizados
      
      Bo=Ymeans-Xmeans*BplsNE;%coeficiente B0
      
      Yvalpredicho= bsxfun (@plus,Xval*BplsNE, Bo);
      
      
      %calculo errores
          Error=bsxfun (@minus,Yvalpredicho, Yval);
          
          %RMSE
          RMSE=Error'*Error;
          RMSE=bsxfun (@rdivide,RMSE,rows (Yvalpredicho));
          RMSE=bsxfun(@power, RMSE, 0.5);
         
          %MAE
          MAE=bsxfun (@power,Error, 2);
          MAE=bsxfun(@power, MAE, 0.5);
          
          %MAXIMO ERROR
          MaximoError=max(MAE);
          MAE=mean(MAE);
          
          %R2
          SCT=(Yval-mean(Yval))'*(Yval-mean(Yval));
          SCR=Error'*Error;
          R2=1-(SCR/SCT);
      
      %GRAFICAR PREDICCION VS REAL CON UNA LINEA DIAGONAL
      figure(2)
      plot(Yvalpredicho,Yval,"*r;prueba;");
      hold on
      plot(Emin:0.1:Emax,Emin:0.1:Emax);
      xlabel ("predicho");
      ylabel ("real");
      legend("hide");
      title(strcat(C(i)," - MODELO PLS CP=",num2str (NCOMP)));
      axis ([Emin Emax Emin Emax]);
      
      if(mostrarleyenda==1)
        text( min(Yvalpredicho), mean(Yval), strcat("MAE=",num2str (MAE),", RMSE=",num2str (RMSE)," ,MAX-ERROR=",num2str (MaximoError)," ,R2=",num2str (R2)));
      endif
      
     
     
        %DAR FORMATO A GRAFICO PARA QUE SEA VISIBLE
        set(gca, "fontsize", 15)
        copied_legend = findobj(gcf(),"type","axes","Tag","legend");
        set(copied_legend, "FontSize", 20, "location", "southeast");
      

endif
if(Evaluarprediccion==1)


    if(pivote==0)
    
      Bpls = NIPALSreducido (Xcal, Ycal, NCOMP);

      BplsNE= bsxfun (@times,bsxfun (@rdivide, Bpls', Xstd),Ystd)';%coeficientes PLS no normalizados
      
      Bo=Ymeans-Xmeans*BplsNE;%coeficiente B0
      
      Yvalpredicho= bsxfun (@plus,Xval*BplsNE, Bo);
      
      
      %calculo errores
          Error=bsxfun (@minus,Yvalpredicho, Yval);
          
          %RMSE
          RMSE=Error'*Error;
          RMSE=bsxfun (@rdivide,RMSE,rows (Yvalpredicho));
          RMSE=bsxfun(@power, RMSE, 0.5);
         
          %MAE
          MAE=bsxfun (@power,Error, 2);
          MAE=bsxfun(@power, MAE, 0.5);
          
          %MAXIMO ERROR
          MaximoError=max(MAE);
          MAE=mean(MAE);
          
          %R2
          SCT=(Yval-mean(Yval))'*(Yval-mean(Yval));
          SCR=Error'*Error;
          R2=1-(SCR/SCT);
      
      %GRAFICAR PREDICCION VS REAL CON UNA LINEA DIAGONAL
      figure(20)
      plot(Yvalpredicho,Yval,"*r;prueba;");
      hold on
      plot(Emin:0.1:Emax,Emin:0.1:Emax);
      xlabel ("predicho");
      ylabel ("real");
      legend("hide");
      title(strcat(C(i)," - MODELO PLS CP=",num2str (NCOMP)));
      axis ([Emin Emax Emin Emax]);
      
      if(mostrarleyenda==1)
        text( min(Yvalpredicho), mean(Yval), strcat("MAE=",num2str (MAE),", RMSE=",num2str (RMSE)," ,MAX-ERROR=",num2str (MaximoError)," ,R2=",num2str (R2)));
      endif
      
     
     
        %DAR FORMATO A GRAFICO PARA QUE SEA VISIBLE
        set(gca, "fontsize", 15)
        copied_legend = findobj(gcf(),"type","axes","Tag","legend");
        set(copied_legend, "FontSize", 20, "location", "southeast");
      
    endif
    
    
    if(pivote>0)
    
          inicial=NCOMP-pivote;
          final=NCOMP+pivote;
          
          for j = inicial:final
            
          
          
                Bpls = NIPALSreducido (Xcal, Ycal, j);

                BplsNE= bsxfun (@times,bsxfun (@rdivide, Bpls', Xstd),Ystd)';%coeficientes PLS no normalizados
                
                Bo=Ymeans-Xmeans*BplsNE;%coeficiente B0
                
                Yvalpredicho= bsxfun (@plus,Xval*BplsNE, Bo);
                
                
                %calculo errores
                    Error=bsxfun (@minus,Yvalpredicho, Yval);
                    
                    %RMSE
                    RMSE=Error'*Error;
                    RMSE=bsxfun (@rdivide,RMSE,rows (Yvalpredicho));
                    RMSE=bsxfun(@power, RMSE, 0.5);
                   
                    %MAE
                    MAE=bsxfun (@power,Error, 2);
                    MAE=bsxfun(@power, MAE, 0.5);
                    
                    %MAXIMO ERROR
                    MaximoError=max(MAE);
                    MAE=mean(MAE);
                    
                    %R2
                    SCT=(Yval-mean(Yval))'*(Yval-mean(Yval));
                    SCR=Error'*Error;
                    R2=1-(SCR/SCT);
                
                %GRAFICAR PREDICCION VS REAL CON UNA LINEA DIAGONAL
                figure(j)
                plot(Yvalpredicho,Yval,"*r;prueba;");
                hold on
                plot(Emin:0.1:Emax,Emin:0.1:Emax);
                xlabel ("predicho");
                ylabel ("real");
                legend("hide");
                title(strcat(C(i)," - MODELO PLS CP=",num2str (j)));
                axis ([Emin Emax Emin Emax]);
                
                if(mostrarleyenda==1)
                  text( min(Yvalpredicho), mean(Yval), strcat("MAE=",num2str (MAE),", RMSE=",num2str (RMSE)," ,MAX-ERROR=",num2str (MaximoError)," ,R2=",num2str (R2)));
                endif
                
               
               
                  %DAR FORMATO A GRAFICO PARA QUE SEA VISIBLE
                  set(gca, "fontsize", 15)
                  copied_legend = findobj(gcf(),"type","axes","Tag","legend");
                  set(copied_legend, "FontSize", 20, "location", "southeast");
         endfor
    
    endif
    
    
    
endif

      
    



if(EvaluarVIP==1)

    VIP = VIP_PLS (Xcal, Ycal, NCOMP, bandas);
    figure(3)
      plot(1:1:bandas,VIP);
      hold on
      minVIP=min(VIP)
      maxVIP=max(VIP)
      plot(1:1:bandas,1:1:1);
      axis ([1 bandas minVIP maxVIP]);

endif



        
          
      
    


