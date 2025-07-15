# Projeto: Sistema de Contas com Clientes PF/PJ, Pagamento e Entrega

## Descrição

Este projeto implementa um modelo de banco de dados para gerenciar clientes, contas, formas de pagamento e entregas, conforme os seguintes requisitos:

- **Clientes** podem ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), mas nunca ambos ao mesmo tempo.  
- **Contas** estão vinculadas a um único cliente, seja PF ou PJ.  
- **Formas de Pagamento:** Uma conta pode ter múltiplas formas de pagamento cadastradas.  
- **Entrega:** Cada entrega está associada a uma conta e possui um status e código de rastreio para acompanhamento.

---

## Modelo Conceitual – Diagrama Entidade-Relacionamento (ER)

```mermaid
erDiagram
    CLIENTE {
        int id_cliente PK
        char tipo_cliente ("PF" ou "PJ")
        string nome
        string telefone
        string email
        string endereco
        char cpf
        date data_nascimento
        char cnpj
        string razao_social
    }

    CONTA {
        int id_conta PK
        decimal saldo
        date data_abertura
        int id_cliente FK
    }

    FORMAPAGAMENTO {
        int id_forma_pagamento PK
        string tipo_pagamento
        string dados_pagamento
    }

    CONTAPAGAMENTO {
        int id_conta PK, FK
        int id_forma_pagamento PK, FK
    }

    ENTREGA {
        int id_entrega PK
        int id_conta FK
        string status
        string codigo_rastreio
        date data_entrega
    }

    CLIENTE ||--o{ CONTA: possui
    CONTA ||--o{ CONTAPAGAMENTO: associa
    FORMAPAGAMENTO ||--o{ CONTAPAGAMENTO: associada
    CONTA ||--o{ ENTREGA: realiza
