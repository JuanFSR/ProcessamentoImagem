pkg load image

##Carrega a imagem de entrada
imgEntrada = imread("imagem.jpg");

##Converte a imagem para double
imagemDouble = im2double(imgEntrada);

##Montando um filtro de média 9X9
filtroMedia = ones(9,9)/81;

##Replica a borda da imagem de entrada
imgPaddingReplicado = padarray(imagemDouble, [4,4], 'replicate');

##Aplicando filtro de média na imagem com a borda replicada
imgPaddingReplicado = filter2(filtroMedia, imgPaddingReplicado, 'valid'); 

##Aplicando filtro de média e adicionando padding de zeros
filtroAplicado = padarray(imagemDouble, [4,4], 0);
imgPaddingZeros = filter2(filtroMedia, imagemDouble, 'same');

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

#Cria as novas imagens após aplicar os filtros requisitados
imwrite(imgPaddingZeros, "imagPaddingZeros.jpg");
imwrite(imgPaddingReplicado, "imagBordaReplicada.jpg");
imwrite(magnitudeGradiente, "imagFiltroSobel.jpg");


##A borda fico mais escura já que antes de realizar a aplicação do filtro, nós adicionamos 4 linhas e 4 colunas de zeros, criando assim uma pequena borda preta após apicar o filtro de média
##Exibe a imagem resultante após aplicar o padding de zeros e o filtro de média
subplot(1, 3, 1)
imshow("imagPaddingZeros.jpg");
title('Imagem com padding de Zeros');

##Exibe a imagem resultante replicando as bordas
subplot(1, 3, 2)
imshow("imagBordaReplicada.jpg"); 
title('Imagem replicando a borda');

##Exibe a imagem aplicando o filtro de Sobel
subplot(1, 3, 3)
imshow("imagFiltroSobel.jpg");
title('Imagem usando os filtros de Sobel');







  