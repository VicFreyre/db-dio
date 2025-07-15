-- Tabela Cliente com tipo PF ou PJ
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    tipo_cliente CHAR(2) NOT NULL CHECK (tipo_cliente IN ('PF', 'PJ')),  -- PF = Pessoa Física, PJ = Pessoa Jurídica
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),
    -- Campos específicos para PF
    cpf CHAR(11),
    data_nascimento DATE,
    -- Campos específicos para PJ
    cnpj CHAR(14),
    razao_social VARCHAR(150),

    -- Restrição para garantir que PF tem CPF e não CNPJ e PJ tem CNPJ e não CPF
    CONSTRAINT chk_pf_pj CHECK (
        (tipo_cliente = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL) OR
        (tipo_cliente = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
    )
);

-- Tabela Conta vinculada a Cliente
CREATE TABLE Conta (
    id_conta SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    saldo DECIMAL(15,2) DEFAULT 0,
    data_abertura DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT fk_conta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela FormaPagamento
CREATE TABLE FormaPagamento (
    id_forma_pagamento SERIAL PRIMARY KEY,
    tipo_pagamento VARCHAR(50) NOT NULL, -- Exemplo: 'Cartão de Crédito', 'Boleto', 'Pix'
    dados_pagamento VARCHAR(255) -- dados necessários para pagamento (ex: número cartão, banco, etc)
);

-- Tabela de associação Conta <-> FormaPagamento (muitos-para-muitos)
CREATE TABLE ContaPagamento (
    id_conta INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    PRIMARY KEY (id_conta, id_forma_pagamento),

    CONSTRAINT fk_conta_pagamento_conta FOREIGN KEY (id_conta) REFERENCES Conta(id_conta),
    CONSTRAINT fk_conta_pagamento_forma FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id_forma_pagamento)
);

-- Tabela Entrega vinculada a Conta (ou poderia ser Pedido, dependendo do modelo)
CREATE TABLE Entrega (
    id_entrega SERIAL PRIMARY KEY,
    id_conta INT NOT NULL,
    status VARCHAR(50) NOT NULL, -- Exemplo: 'pendente', 'em transporte', 'entregue', etc
    codigo_rastreio VARCHAR(100),
    data_entrega DATE,

    CONSTRAINT fk_entrega_conta FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
);
