# Blockchain em Ruby on Rails (rails-chain)

![Ruby On Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

## Sobre o Projeto

Este projeto é uma implementação educacional de uma blockchain funcional, construída com Ruby on Rails. O objetivo é demonstrar na prática a arquitetura e os mecanismos de segurança por trás de sistemas de registro distribuído (DLT).

A aplicação vai além de uma simples simulação, incorporando um sistema de banco de dados persistente, autenticação de usuários, carteiras digitais com criptografia de chave pública/privada e validação de assinaturas, refletindo o funcionamento de criptomoedas reais.

## Screenshot

![Screenshot da Aplicação](public/image.png)

*(Lembre-se de atualizar o screenshot para refletir a interface atual, com a tabela de blocos e os botões de ação!)*

---

## Fluxo de Funcionamento da Aplicação

A aplicação simula um ecossistema de blockchain completo com o seguinte fluxo:

1.  **Cadastro e Criação de Carteira:** Um novo usuário se cadastra usando o sistema de autenticação `Devise`. No momento da criação, um par de chaves criptográficas RSA de 2048 bits (pública e privada) é gerado usando a biblioteca `OpenSSL`. A chave pública serve como o "endereço" da carteira, enquanto a chave privada é armazenada para assinar futuras transações.

2.  **Criação e Assinatura de Transações:** Um usuário logado pode criar uma nova transação. O remetente é sempre a carteira do usuário logado. A transação é então **assinada digitalmente** com a chave privada do usuário. Essa assinatura é a prova criptográfica de que o dono da carteira autorizou a transação.

3.  **Mempool (Sala de Espera):** A transação assinada é salva no banco de dados com um `block_id` nulo, colocando-a em um "Mempool" de transações pendentes.

4.  **Mineração e Validação:** Ao acionar a mineração, o `BlockMiner` (um Service Object dedicado) executa os seguintes passos:
    * **Verificação de Assinaturas:** Ele busca todas as transações no Mempool e verifica a assinatura de cada uma usando a chave pública do remetente. Transações com assinaturas inválidas são descartadas.
    * **Prova de Trabalho (Proof of Work):** Um novo bloco é criado com as transações válidas. O minerador então resolve um desafio computacional (encontrar um *nonce* que gere um hash com um número predefinido de zeros no início) para validar o bloco.
    * **Adição à Cadeia:** O bloco minerado é salvo no banco de dados, e as transações contidas nele são atualizadas para referenciar o novo bloco, removendo-as do Mempool.

5.  **Validação da Cadeia:** A qualquer momento, um usuário pode acionar o `ChainValidator`. Este serviço percorre toda a blockchain, do Bloco Gênesis ao mais recente, verificando a integridade de cada elo (`previous_hash`) e a validade da Prova de Trabalho de cada bloco.

## Arquitetura e Boas Práticas

* **Service Objects:** A lógica de negócio complexa (mineração e validação) foi isolada em Service Objects (`BlockMiner`, `ChainValidator`), mantendo os controllers "magros" e focados em gerenciar requisições HTTP.
* **Helpers:** Lógica de formatação de dados para a view (como truncar as chaves públicas) foi encapsulada em helpers, seguindo as convenções do Rails.
* **Segurança:** A autenticação é gerenciada pelo `Devise`. A segurança e autenticidade das transações são garantidas por assinaturas digitais RSA.

## Tecnologias Utilizadas

* **Backend:** Ruby on Rails, Puma
* **Banco de Dados:** SQLite3
* **Autenticação:** Devise
* **Criptografia:** OpenSSL (biblioteca padrão do Ruby)
* **Frontend:** HTML, CSS, ERB (Embedded Ruby)

## Funcionalidades Implementadas

-   [x] **Persistência de Dados:** A blockchain é armazenada em um banco de dados SQLite.
-   [x] **Sistema de Transações:** Implementação de um modelo `LedgerTransaction` para registros detalhados.
-   [x] **Validação da Cadeia:** Um serviço dedicado verifica a integridade da blockchain.
-   [x] **Autenticação de Usuários** com Devise.
-   [x] **Carteiras Digitais** com geração de chaves pública/privada.
-   [x] **Assinatura e Verificação** de transações com criptografia RSA.
-   [x] **Prova de Trabalho (Proof of Work)** para mineração de blocos.
-   [x] **Mempool** para transações pendentes.
-   [x] **Interface Web** para interagir com a blockchain.

## Como Executar o Projeto Localmente

### Pré-requisitos

* Ruby (versão ~3.3.x)
* Ruby on Rails (versão ~8.0.x)
* Bundler
* Node.js

### Passos para Instalação

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/marcosnobre26/BlockChain-Ruby.git](https://github.com/marcosnobre26/BlockChain-Ruby.git)
    ```

2.  **Navegue até o diretório do projeto:**
    ```bash
    cd BlockChain-Ruby
    ```

3.  **Instale as dependências:**
    ```bash
    bundle install
    ```

4.  **Prepare o banco de dados:**
    ```bash
    rails db:reset
    ```

5.  **Inicie o servidor Rails:**
    ```bash
    rails server
    ```

6.  **Acesse a aplicação:**
    Abra seu navegador e visite `http://localhost:3000`.

## Autor

**Marcos Nobre Castro Silva**

* **GitHub:** `https://github.com/marcosnobre26`
* **LinkedIn:** `https://linkedin.com/in/marcos-nobre-1363661a8`