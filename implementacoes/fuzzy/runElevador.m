close all; clear all; clc; addpath('..');
%{
A) Disponibilidade de carga: é o numero atual de vagas disponíveis no 
elevador no instante em que a chamada ocorreu.

B) Distância a ser percorrida pelo elevador: é o numero de andares que 
o elevador deve percorrer desde a posição atual até o andar onde a nova
chamada ocorreu.

C) Tempo de espera: é o tempo desde de a chamada realizada no pavimento até
a chegada da cabine. Esta medida depende diretamente dos parâmetros de 
configuração do sistema de elevadores tais como, velocidade do elevador, 
relação de aceleração, altura dos andares, tempo de abrir e fechar as 
portas. O tempo de espera depende também do número de paradas que devem 
ser realizadas pelo elevador antes de chegar ao pavimento solicitado. Este 
valor é normalizado pelo tempo máximo de espera, que corresponde à viagem 
de maior percurso no prédio (por exemplo do andar térreo ao último andar) 
considerando que o elevador para em todos os andares intermediários.

%}

load('elevador1.mat');
fuzzy(elevador1);

load('elevador2.mat');
fuzzy(elevador2);
