%% A Análise de Componentes Principais (ACP) ou Principal Component Analysis (PCA) é um procedimento matemático que utiliza uma transformação ortogonal 
% (ortogonalização de vetores) para converter um conjunto de observações de variáveis possivelmente correlacionadas num conjunto de valores de variáveis 
% linearmente não correlacionadas chamadas de componentes principais. O número de componentes principais é sempre menor ou igual ao número de variáveis originais. 
% Os componentes principais são garantidamente independentes apenas se os dados forem normalmente distribuídos (conjuntamente). 
% O PCA é sensível à escala relativa das variáveis originais. Dependendo da área de aplicação, o PCA é também conhecido como transformada de Karhunen-Loève (KLT) discreta, 
% transformada de Hotelling ou decomposição ortogonal própria (POD).

% O PCA foi inventado em 1901 por Karl Pearson. Agora, é mais comumente usado como uma ferramenta de Análise Exploratória de Dados e para fazer modelos preditivos. 
% PCA pode ser feito por decomposição em autovalores (Valores Próprios) de uma matriz covariância, geralmente depois de centralizar (e normalizar ou usar pontuações-Z) 
% a matriz de dados para cada atributo.[2] Os resultados de PCA são geralmente discutidos em termos pontuações (scores) de componentes, também chamados de pontuações 
% de fatores (os valores de variável transformados correspondem a um ponto de dado particular), e carregamentos (loadings), i.e., o peso pelo qual cada variável 
% normalizada original deve ser multiplicada para se obter a pontuação de componente.

% O PCA é a mais simples das verdadeiras análises multivariadas por autovetores (Vetores Próprios). Com frequência, sua operação pode ser tomada como sendo 
% eveladora da estrutura interna dos dados, de uma forma que melhor explica a variância nos dados. Se visualizarmos um conjunto de dados multivariados em um 
% espaço de alta dimensão, com 1 eixo por variável, o PCA pode ser usado para fornecer uma visualização em dimensões mais baixas dos mesmos dados, uma verdadeira 
% "sombra" do objeto original quando visto de seu ponto mais informativo. Isto é feito usando-se apenas os primeiros componentes principais, de forma que a
% dimensionalidade dos dados transformados é reduzida.

% O PCA é fortemente ligado à análise de fatores (Factorial Analysis); de fato, alguns pacotes estatísticos propositadamente confluem as técnicas. 
% A verdadeira análise de fatores faz suposições diferentes sobre a estrutura subjacente dos dados e encontra os autovetores de uma matriz levemente diferente.



close all; clear all; clc

data = load('../iris.data');
X = data(:,1:4);
Y = data(:,5:end);

X = bsxfun(@minus, X, mean(X));
[V E] = eig( cov(X) );
[E order] = sort(diag(E), 'descend');
V = V(:,order);
pca_data= X*V;

lin = 2;
col = 3;

% 1 C. sepal
% 2 L. sepal
% 3 C. petal
% 4 L. petal


subplot(lin, col, 1)
atrx = 2;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);
% legend('Setosa', 'Versicolor', 'Virgínica');

subplot(lin, col, 2)
atrx = 3;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
atrx = 4;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
atrx = 3;
atry = 2;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
atrx = 4;
atry = 2;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
atrx = 4;
atry = 3;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);
legend('Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');
