function [Xnormalizado,Xmeans,Xstd] = normalizar (X)

 
 
 
 %Matriz: matriz a obtener media y desv. estandar para normalizar la matriz X
 
 
  Xmeans = mean(X);
  Xstd = std (X);

  Xnormalizado = bsxfun (@rdivide, bsxfun (@minus,X, Xmeans), Xstd);
 

 
 
 
 
 
 endfunction