pkg load image

#imagem original
imagemEinstein = imread("imagem.jpg");

#histograma da imagem original
[histograma, nivelIntensidade] = imhist(imagemEinstein);

#tamanho da matriz da imagem
[nlinhas, ncolunas] = size (imagemEinstein);
tamanhoMatriz = nlinhas*ncolunas;

#Cria uma matriz de zeros do mesmo tamanho da imagem original
imagemEqualizada = zeros(nlinhas, ncolunas, "uint8");

#vetor de todos valores de pr(rk)
pr = []

for i = 1:256
    pr(i) = histograma(i) / (tamanhoMatriz);
  endfor

  #Novos níveis de cinza que serão utilizados na nova imagem
  novoHistograma = []

  for k = 1:256
  aux = 0;    
    
    #Realizando o somatório de pr
    for j = 1:k
        aux = aux + pr(j);
    endfor
   
   #arredondando para o inteiro mais próximo e multiplicando por L-1
   novoHistograma(k) = round(aux*255);
  endfor

#Escreve as novas intensidade na imagem equalizada
for m = 1:nlinhas
   for n = 1:ncolunas
     imagemEqualizada(m, n) = novoHistograma(imagemEinstein(m, n));
   endfor
endfor


#Escreve as novas intensidades da imagem
imwrite(imagemEqualizada, "imagemResultado.jpg");

histogramaNovaImagem = imread("imagemResultado.jpg");

[counts, x] = imhist(h);

#Abre a imagem equalizada
figure(1);
imshow("imagemResultado.jpg");

#Abre o plot do histograma antigo
figure(2);
plot(nivelIntensidade, histograma);

#Figura antes da transformação
figure(3)
imshow("imagem.jpg");

#Histograma equalizado
figure(4)
plot(x, counts);
