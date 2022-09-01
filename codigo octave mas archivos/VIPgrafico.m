clear
datos=load('ValoresVIP.txt');

% matriz de encabezados
    C(1:5)={"PROTEINA",	"GRASA","HUMEDAD",	"TBVN",	"HISTAMINA"};


    
    Bandas=datos(1:240,1); % bandas
    
    Proteina=datos(1:240,2);
    Grasa=datos(1:240,3);
    Humedad=datos(1:240,4);
    TBVN=datos(1:240,5);
    Histamina=datos(1:240,6);
    

      
      %GRAFICAR PREDICCION VS REAL CON UNA LINEA DIAGONAL
      figure(2)
      %plot(Bandas,Proteina,"-r;Proteina;","linewidth", 3);
      %hold on      
      %plot(Bandas,Grasa,"-b;Grasa;","linewidth", 3);
      %hold on
      %plot(Bandas,TBVN,"-g;TBVN;","linewidth", 3);
      %hold on
      %plot(Bandas,Histamina,":k;Histamina;","linewidth", 3);
      %hold on
      plot(Bandas,Humedad,"-b;Humedad;","linewidth", 3);
      hold on
      plot(Bandas,1);
      
      %zona1:400-450nm,
      plot(450,0.5:0.01:2);
      
      %zona2:620-690nm,
      plot(620,0.5:0.01:2);
      plot(690,0.5:0.01:2);
      
      
      %Zona3:750-805nm,
      plot(750,0.5:0.01:2);
      plot(805,0.5:0.01:2);
      
      %Zona3:865-900nm,
      plot(865,0.5:0.01:2);
      
      %Zona5:485-540nm 
      plot(485,0.5:0.01:2);
      plot(540,0.5:0.01:2);
      
      %grid on
      
      
      
      xlabel ("banda espectral");
      ylabel ("VIP");
      
      
      
      
      
      %legend("hide");
      
      
      
      
      title(" VIP de las bandas espectrales");          
      axis ([400 900 0.5 2]);
      
      
      

      
     
     
        %DAR FORMATO A GRAFICO PARA QUE SEA VISIBLE
        set(gca, "fontsize", 15)
        copied_legend = findobj(gcf(),"type","axes","Tag","legend");
        set(copied_legend, "FontSize", 20, "location", "northeast");
      
   
        
          
      
    


