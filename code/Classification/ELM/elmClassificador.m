function resultado = elmClassificador(camadasOcultas, porcentTreino, porcentTeste)

    resultado = [];
    for i = 1: size(camadasOcultas, 1)

        dados = load('prob_classification1.mat');
        X = dados.x;
        Y = dados.y;

        X = [-1*ones(size(X,1),1) X];


        %Treinamento
        quantTreino = floor(porcentTreino * size(X, 1));
        quantTeste = floor(porcentTeste * size(X, 1));

        idsEmbaralhaDados = randperm(size(X, 1));

        dadosTreinamentoX = X(idsEmbaralhaDados(1:quantTreino),:);

        dadosTreinamentoY = Y(idsEmbaralhaDados(1:quantTreino));

        dadosTesteX = X(idsEmbaralhaDados(quantTreino+1:end),:);

        dadosTesteY = Y(idsEmbaralhaDados(quantTreino+1:end));
		
		% pre-processing / 1-of-S output encoding scheme
		labels = unique(dadosTreinamentoY);
		code = zeros(length(labels), length(labels));
		for j = 1: length(labels),
			code(j, j) = 1;
		end

		for j = length(labels):-1:1,
			ind = (dadosTreinamentoY == labels(j));
			ind2 = (dadosTesteY == labels(j));
			tam = length(find(ind==1));
			tam2 = length(find(ind2==1));
			dataset.ytrain(ind, :) = repmat(code(j, :), tam, 1);
			dataset.ytest(ind2, :) = repmat(code(j, :), tam2, 1);
		end

        W = rand(camadasOcultas(i), size(dadosTreinamentoX, 2));

        U = dadosTreinamentoX * W';

        Z =  tanh(U);

        m = pinv(Z)*dataset.ytrain;


        %Teste
        linhasTeste = size(dadosTesteX, 1);

        for i = 1 : linhasTeste
           x_teste = dadosTesteX(i, :);
           Z = tanh(W * x_teste');

           erro = dataset.ytest(i) - m'*Z;
           erros(i) = erro'*erro;
        end

        resultado = [resultado; [sum(erros)/linhasTeste]];

    end
end