pkg load image

##Carrega a imagem de entrada
imgEntrada = imread("imagem.jpg");

##Converte a imagem para double
imagemDouble = im2double(imgEntrada);

##Montando um filtro de média 9X9
filtroMedia = ones(9,9)/81;

##Adicionando padding de zeros
imgPaddingReplicado = padarray(imagemDouble, [4,4], 'replicate');

##Usar filter2(b, x, shape) para aplicar o filtro de média
filtroAplicado = padarray(imagemDouble, [4,4], 0);
filtroAplicado = filter2(filtroMedia, imagemDouble, 'same');


##Replicando a borda da imagem
replicandoBorda = filter2(filtroMedia, imgPaddingReplicado, 'valid'); 


##Criando os filtros de Sobel
primeiroFiltroSobel = [-1,-2,-1; 0,0,0; 1,2,1];
segundoFiltroSobel = [-1,0,1; -2,0,2; -1,0,1]

##Adicionando padding de 1 linha e 1 coluna na imagem
sobelPadding = padarray(imagemDouble, [1,1], 0);

##Aplicando filtros de Sobel na imagem
filtroSobelAplicadoHorizontal = filter2(primeiroFiltroSobel, imagemDouble, 'same');
filtroSobelAplicadoVertical = filter2(segundoFiltroSobel, imagemDouble, 'same');

##Aplicando a operação de modulo nos valores encontrados aplicando os filtros de Sobel
filtroSobelAplicadoHorizontal = abs(filtroSobelAplicadoHorizontal);
filtroSobelAplicadoVertical = abs(filtroSobelAplicadoVertical);

#Calculando a magnitude do gradiente
magnitudeGradiente = filtroSobelAplicadoHorizontal+filtroSobelAplicadoVertical;

##A borda fico mais escura já que antes de realizar a aplicação do filtro, nós adicinamos 4 linhas e 4 colunas de zeros, criando assim uma pequena borda preta após apicar o filtro de média
##Exibir a imagem resultante adicionando um padding de zeros
##figure(1);
subplot(1, 3, 1)
imshow(filtroAplicado);
title('Imagem com padding de Zeros');

##Exibe a imagem resultante replicando as bordas
##figure(2);
subplot(1, 3, 2)
imshow(replicandoBorda); 
title('Imagem replicando a borda');

##Exibe a imagem aplicando o filtro de Sobel
##figure(3);
subplot(1, 3, 3)
imshow(magnitudeGradiente);
title('Imagem usando os filitros de Sobel');







  