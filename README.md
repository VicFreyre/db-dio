# Projeto de Banco de Dados - Randstad Bootcamp

## Descrição
Este projeto implementa um modelo de banco de dados para gerenciar clientes, contas, formas de pagamento e entregas, conforme os seguintes requisitos:

- **Clientes** podem ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), mas nunca ambos ao mesmo tempo.  
- **Contas** estão vinculadas a um único cliente, seja PF ou PJ.  
- **Formas de Pagamento:** Uma conta pode ter múltiplas formas de pagamento cadastradas.  
- **Entrega:** Cada entrega está associada a uma conta e possui um status e código de rastreio para acompanhamento.

---

## Modelo Conceitual – Diagrama Entidade-Relacionamento (ER)

<p align="center">
  <img src="https://github.com/user-attachments/assets/ef90dd8a-4a93-4d01-97ea-dba268ac3b08" alt="image" width="773" height="739" />
</p>

## Entidades e Atributos

### CLIENTE

| Atributo       | Tipo    | Descrição                     |
|----------------|---------|-------------------------------|
| `id_cliente`   | PK      | Identificador do cliente       |
| `nome`         | string  | Nome do cliente               |
| `telefone`     | string  | Telefone de contato           |
| `email`        | string  | E-mail do cliente             |
| `endereco`     | string  | Endereço completo             |
| `tipo_cliente` | string  | Tipo: 'Física' ou 'Jurídica'  |

---

### PESSOAFISICA

| Atributo          | Tipo     | Descrição                  |
|-------------------|----------|----------------------------|
| `id_cliente`      | PK, FK   | Referência ao cliente       |
| `cpf`             | string   | CPF da pessoa física        |
| `data_nascimento` | date     | Data de nascimento          |

---

### PESSOAJURIDICA

| Atributo          | Tipo     | Descrição                  |
|-------------------|----------|----------------------------|
| `id_cliente`      | PK, FK   | Referência ao cliente       |
| `cnpj`            | string   | CNPJ da pessoa jurídica     |
| `razao_social`    | string   | Razão social da empresa     |

---

### CONTA

| Atributo          | Tipo     | Descrição                  |
|-------------------|----------|----------------------------|
| `id_conta`        | PK       | Identificador da conta      |
| `saldo`           | decimal  | Saldo atual da conta        |
| `data_abertura`   | date     | Data de abertura            |
| `id_cliente`      | FK       | Referência ao cliente       |

---

### FORMAPAGAMENTO

| Atributo          | Tipo     | Descrição                  |
|-------------------|----------|----------------------------|
| `id_forma_pagamento` | PK     | Identificador da forma      |
| `tipo_pagamento`  | string   | Tipo (Cartão, Pix, etc.)    |
| `dados_pagamento` | string   | Informações detalhadas      |

---

### CONTAPAGAMENTO (Entidade Associativa)

| Atributo          | Tipo     | Descrição                  |
|-------------------|----------|----------------------------|
| `id_conta`        | PK, FK   | Referência à conta          |
| `id_forma_pagamento` | PK, FK | Referência à forma de pagamento |

---

### ENTREGA

| Atributo           | Tipo     | Descrição                  |
|--------------------|----------|----------------------------|
| `id_entrega`       | PK       | Identificador da entrega    |
| `id_conta`         | FK       | Referência à conta          |
| `status`           | string   | Status da entrega           |
| `codigo_rastreio`  | string   | Código de rastreio          |
| `data_entrega`     | date     | Data prevista ou realizada  |

---

## Relacionamentos

| Entidade Origem | Tipo   | Entidade Destino  | Descrição                         |
|-----------------|--------|-------------------|-----------------------------------|
| CLIENTE         | 1:1    | PESSOAFISICA      | Cliente **é** pessoa física       |
| CLIENTE         | 1:1    | PESSOAJURIDICA    | Cliente **é** pessoa jurídica     |
| CLIENTE         | 1:N    | CONTA             | Cliente **possui** conta(s)       |
| CONTA           | N:N    | FORMAPAGAMENTO    | Associado por CONTAPAGAMENTO      |
| CONTA           | 1:N    | ENTREGA           | Conta **gera** entregas           |
