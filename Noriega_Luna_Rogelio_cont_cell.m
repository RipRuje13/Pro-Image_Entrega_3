clear;
close all;
clc;

% Leer la imagen
img_NLR = imread('celulas.tif');

% Obtener el ancho y alto de la imagen
[alto_NLR, ancho_NLR, ~] = size(img_NLR);

% Dividir la imagen en tres partes
parte1_NLR = imcrop(img_NLR, [0, 0, ancho_NLR/3, alto_NLR]);
parte2_NLR = imcrop(img_NLR, [ancho_NLR/3, 0, ancho_NLR/3, alto_NLR]);
parte3_NLR = imcrop(img_NLR, [2*ancho_NLR/3, 0, ancho_NLR/3, alto_NLR]);

%------------------------------------------PARTE 1---------------------------

% Segmentación adaptativa de la parte 1
radio_NLR = 8;
umbral_NLR = adaptthresh(parte1_NLR, 0.5, 'NeighborhoodSize', 2*radio_NLR+1, 'Statistic', 'gaussian');
parte1_umbral_NLR = imbinarize(parte1_NLR, umbral_NLR);

% Interpolación bilineal de la parte 1
parte1_interp_NLR = imresize(parte1_umbral_NLR, size(parte1_umbral_NLR), 'bilinear');

% Dilatar la imagen
elem_struct1_RA_NLR = strel('disk', 2);
parte1_interp_NLR = imdilate(parte1_interp_NLR, elem_struct1_RA_NLR);

% Rellenar los huecos
parte1_interp_NLR = imfill(parte1_interp_NLR, 'holes');

% Eliminar objetos conectados a los bordes
parte1_interp_NLR = imclearborder(parte1_interp_NLR, 4);

% Contar las formas irregulares
[L_NLR, num_NLR] = bwlabel(parte1_interp_NLR);
fprintf('Número de formas irregulares encontradas: %d\n', num_NLR);

% Detectar los contornos de los objetos en la imagen interpolada
parte1_contornos_NLR = bwperim(parte1_interp_NLR);

% Superponer los contornos sobre la imagen interpolada
parte1_con_contornos_NLR = imoverlay(parte1_interp_NLR, parte1_contornos_NLR, [1 0 0]);

% Mostrar la imagen original, la imagen umbralizada, la imagen interpolada y la imagen interpolada con contornos
figure;
subplot(1,4,1);
imshow(parte1_NLR);
title('Parte 1 - Original');
subplot(1,4,2);
imshow(parte1_umbral_NLR);
title('Parte 1 - Umbralizada Adaptativamente');
subplot(1,4,3);
imshow(parte1_interp_NLR);
title('Parte 1 - Interpolada Bilinealmente');
subplot(1,4,4);
imshow(parte1_con_contornos_NLR);
title('Parte 1 - Interpolada con Contornos');

%------------------------------------------PARTE 2---------------------------

% Segmentación adaptativa de la parte 2
radio_NLR = 8;
umbral_NLR = adaptthresh(parte2_NLR, 0.5, 'NeighborhoodSize', 2*radio_NLR+1, 'Statistic', 'gaussian');
parte2_umbral_NLR = imbinarize(parte2_NLR, umbral_NLR);

% Interpolación bilineal de la parte 2
parte2_interp_NLR = imresize(parte2_umbral_NLR, size(parte1_umbral_NLR), 'bilinear');

% Dilatar la imagen
elem_struct2_RANL = strel('disk', 2);
parte2_interp_NLR = imdilate(parte2_interp_NLR, elem_struct2_RANL);

% Rellenar los huecos
parte2_interp_NLR = imfill(parte2_interp_NLR, 'holes');

% Eliminar objetos conectados a los bordes
parte2_interp_NLR = imclearborder(parte2_interp_NLR, 4);

% Contar las formas irregulares
[L_NLR, num_NLR] = bwlabel(parte2_interp_NLR);
fprintf('Número de formas irregulares encontradas: %d\n', num_NLR);

% Detectar los contornos de los objetos en la imagen interpolada
parte2_contornos_NLR = bwperim(parte2_interp_NLR);

% Superponer los contornos sobre la imagen interpolada
parte2_con_contornos_NLR = imoverlay(parte2_interp_NLR, parte2_contornos_NLR, [1 0 0]);

% Mostrar la imagen original, la imagen umbralizada, la imagen interpolada y la imagen interpolada con contornos
figure;
subplot(1,4,1);
imshow(parte2_NLR);
title('Parte 2 - Original');
subplot(1,4,2);
imshow(parte2_umbral_NLR);
title('Parte 2 - Umbralizada Adaptativamente');
subplot(1,4,3);
imshow(parte2_interp_NLR);
title('Parte 2 - Interpolada Bilinealmente');
subplot(1,4,4);
imshow(parte2_con_contornos_NLR);
title('Parte 2 - Interpolada con Contornos');

%------------------------------------------PARTE 3---------------------------
% Segmentación adaptativa de la parte 3
radio_NLR = 8;
umbral_NLR = adaptthresh(parte3_NLR, 0.5, 'NeighborhoodSize', 2*radio_NLR+1, 'Statistic', 'gaussian');
parte3_umbral_NLR = imbinarize(parte3_NLR, umbral_NLR);

% Interpolación bilineal de la parte 3
parte3_interp_NLR = imresize(parte3_umbral_NLR, size(parte3_umbral_NLR), 'bilinear');

% Dilatar la imagen
elem_struct_RANL_NLR = strel('disk', 2);
parte3_interp_NLR = imdilate(parte3_interp_NLR, elem_struct_RANL_NLR);

% Rellenar los huecos
parte3_interp_NLR = imfill(parte3_interp_NLR, 'holes');

% Eliminar objetos conectados a los bordes
parte3_interp_NLR = imclearborder(parte3_interp_NLR, 4);

% Contar las formas irregulares
[L_NLR, num_NLR] = bwlabel(parte3_interp_NLR);
fprintf('Número de formas irregulares encontradas: %d\n', num_NLR);

% Detectar los contornos de los objetos en la imagen interpolada
parte3_contornos_NLR = bwperim(parte3_interp_NLR);

% Superponer los contornos sobre la imagen interpolada
parte3_con_contornos_NLR = imoverlay(parte3_interp_NLR, parte3_contornos_NLR, [1 0 0]);

% Mostrar la imagen original, la imagen umbralizada, la imagen interpolada y la imagen interpolada con contornos
figure;
subplot(1,4,1);
imshow(parte3_NLR);
title('Parte 3 - Original');
subplot(1,4,2);
imshow(parte3_umbral_NLR);
title('Parte 3 - Umbralizada Adaptativamente');
subplot(1,4,3);
imshow(parte3_interp_NLR);
title('Parte 3 - Interpolada Bilinealmente');
subplot(1,4,4);
imshow(parte3_con_contornos_NLR);
title('Parte 3 - Interpolada con Contornos');

%---------------------------------------------imagenes unidas---------------
%contar las fromas irregulares pero de las imagenes unidas

%unir todas las partes de las imagenes
umbral_unido_NLR = horzcat(parte1_umbral_NLR, parte2_umbral_NLR, parte3_umbral_NLR);
interp_unido_NLR = horzcat(parte1_interp_NLR, parte2_interp_NLR, parte3_interp_NLR);

% Contar las formas irregulares
[L_NLR, num_NLR] = bwlabel(interp_unido_NLR);
fprintf('Número de formas irregulares encontradas: %d\n', num_NLR);

% Detectar los contornos de los objetos en la imagen interpolada
unido_contornos_NLR = bwperim(interp_unido_NLR);

% Superponer los contornos sobre la imagen interpolada
unido_con_contornos_NLR = imoverlay(interp_unido_NLR, unido_contornos_NLR, [1 0 0]);

%imprimir lo mismo solo que con las imagenes unidas
figure;
subplot(1,4,1);
imshow(img_NLR);
title('Original');
subplot(1,4,2);
imshow(umbral_unido_NLR);
title('Umbralizada Adaptativamente');
subplot(1,4,3);
imshow(interp_unido_NLR);
title('Interpolada Bilinealmente');
subplot(1,4,4);
imshow(unido_con_contornos_NLR);
title('Interpolada con Contornos');

