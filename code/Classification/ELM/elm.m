cont = 1;
for neCO = 10 : 10 : 1000

dados = load('prob_regression1.mat');
X = dados.x;
Y = dados.y;

X = [-1*ones(size(X,1),1) X];

quantTreino = floor(0.80 * size(X, 1));
quantTeste = floor(0.20 * size(X, 1));
    
idsEmbaralhaDados = randperm(size(X, 1));
    
dadosTreinamentoX = X(idsEmbaralhaDados(1:quantTreino),:);

dadosTreinamentoY = Y(idsEmbaralhaDados(1:quantTreino));

dadosTesteX = X(idsEmbaralhaDados(quantTreino+1:end),:);

dadosTesteY = Y(idsEmbaralhaDados(quantTreino+1:end));

W = rand(neCO, size(dadosTreinamentoX, 2));

U = dadosTreinamentoX * W';

Z =  tanh(U);

m = inv(Z'*Z)*Z'*dadosTreinamentoY; 

%Teste

linhasTeste = size(dadosTesteX, 1);

for i = 1 : linhasTeste
   x_teste = dadosTesteX(i, :);
   Z = tanh(W * x_teste');
   
   erro = dadosTesteY(i) - m'*Z;
   erros(i) = erro*erro;
end

result(cont) = sum(erros)/linhasTeste;
cont = cont + 1;
end