pkg load image;

## Abre a imagem
img = imread('imagem.png');

## Converte a imagem para double
img = im2double(img);

## Quantidade de linhas e colunas da imagem
[linhas, colunas] = size(img);
P = 2*linhas;
Q = 2*colunas;

## A dimensão da transformada será o dobro da imagem original, ou seja, terá a 
## dimensão de 512x512
imagemRapidaFourier = fft2(img, P, Q);

## Centralizando transformada de Fourier
imagemRapidaFourier = fftshift(imagemRapidaFourier);

subplot(1,3,1);
imshow(uint8(abs(imagemRapidaFourier)));
title('Transformação Rápida de Fourier');

## Construindo filtro de passa baixa
filtroPassaBaixa = zeros(P, Q);
d = 20;

for U = 1:P
  for V = 1:Q
    D = (((U - P/2)^2) + ((V - Q/2)^2))^(1/2);
    filtroPassaBaixa(U, V) = e ^ ((-D^2)/(2*(d^2)));
  endfor
endfor
  

subplot(1,3,2)
imshow(filtroPassaBaixa);
title('Filtro de Passa-baixa Gaussiano');

## Multiplicando a matriz da transformada de Fourier pelo filtro de passa-baixo Gaussiano
filtroImg = imagemRapidaFourier.*filtroPassaBaixa;
filtroImg = fftshift(filtroImg);

## Aplicando a transformada inversa rápida de Fourier 
## Selecionando a parte real da matriz
filtroImg = ifft2(filtroImg);
filtroImg = real(filtroImg);

## Extraindo a região superior esquerda ( linhas x colunas )
imgResultante = zeros(linhas, colunas);
imgResultante = filtroImg(1:linhas, 1:colunas);

subplot(1,3,3)
imshow(im2uint8(imgResultante));
title('Imagem do resultado final');