close all; clear all; clc; addpath('..');
%{
I) Disponibilidade de carga: quantidade de massa disponível do elevador.

II) Distância a ser percorrida pelo elevador: é o numero de andares que 
o elevador deve percorrer desde a posição atual até o andar onde a nova
chamada ocorreu. No modelo 'elevador4', positivo indica que o elevador está
no sentindo da solicitação.

III) Tempo de espera: é o tempo desde a chamada realizada no pavimento até
a chegada da cabine. Esta medida depende diretamente dos parâmetros de 
configuração do sistema de elevadores tais como, velocidade do elevador, 
relação de aceleração, altura dos andares, tempo de abrir e fechar as 
portas. O tempo de espera depende também do NÚMERO DE PARADAS que devem 
ser realizadas pelo elevador antes de chegar ao pavimento solicitado. Este 
valor é normalizado pelo tempo máximo de espera, que corresponde à viagem 
de maior percurso no prédio (por exemplo do andar térreo ao último andar) 
considerando que o elevador para em todos os andares intermediários.

IV) Sentindo do descolacento: para o modelo 'elevador3', positivo indica
que o elevador está no sentindo da solicitação. No modelo 'elevador4' diz
se o elevador está subindo ou descendo.

%}

load('elevador1.mat');
fuzzy(elevador1);

load('elevador3.mat');
fuzzy(elevador3);

load('elevador4.mat');
fuzzy(elevador4);
