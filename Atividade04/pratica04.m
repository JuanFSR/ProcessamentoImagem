pkg load image;

## Abre a imagem
img = imread('imagem.png');

## Converte a imagem para double
img = im2double(img);

## Quantidade de linhas e colunas da imagem
[linhas, colunas] = size(img);
P = 2*linhas;
Q = 2*colunas;

## A dimensão da transformada será o dobro da imagem original
imagemRapidaFourier = fft2(img, P, Q);

## Centralizando transformada de Fourier
imagemRapidaFourier = fftshift(imagemRapidaFourier);
espectroFourier = uint8(abs(imagemRapidaFourier));

## Criando imagem do espectro
imwrite(espectroFourier, "espectro.png");
subplot(1,2,1);
imshow(espectroFourier);
title('Espectro da Transformada de Fourier');

## Cria o filtro de Notch só com valor 1
filtroNoch = ones(P, Q);

## Cria o filtro simétrico
for x=1:1516
  if(x>758) x= x+100;
  endif
  for y=749:759
     filtroNoch(x, y) = 0;
   endfor
endfor

## Cria a imagem que representa o filtro de Notch
imwrite(filtroNoch, "filtro.png");

# Multiplicando a matriz da transformada de Fourier pelo filtro de Notch
filtroImg = imagemRapidaFourier.*filtroNoch;
filtroImg = fftshift(filtroImg);

# Aplicando a transformada inversa rápida de Fourier 
# Selecionando a parte real da matriz
filtroImg = ifft2(filtroImg);
filtroImg = real(filtroImg);

# Extraindo( linhas x colunas )
imgResultante = zeros(linhas, colunas);
imgResultante = filtroImg(1:linhas, 1:colunas);
imgResultante = im2uint8(imgResultante);

## Cria a imagem final
imwrite(imgResultante, "resultado.png");
subplot(1,2,2)
imshow(imgResultante);
title('Resultado da filtragem da imagem');