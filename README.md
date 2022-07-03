# E-commerce

Este projeto foi desenvolvido para funcionar junto com [Pagamentos](https://github.com/TreinaDev/pagamentos-td08-time02).

O projeto **E-commerce** foi pensado para funcionar como uma plataforma de _e-commerce_ focada em usuários participantes de programas de pontos, como os de cartões de crédito. Os clientes podem utilizar seu saldo de <span style="color:red">**rubis**</span> <img src="https://cdn.emojidex.com/emoji/seal/Ruby.png" width="10px"> para adquirir diversos produtos.

Os _administradores_ (usuários cadastrados com e-mail do domínio @mercadores.com.br) são responsáveis por gerir produtos, categorias, promoções e cashbacks, podendo, por exemplo, cadastrar cashbacks para algum produto específico e promoções para categorias inteiras de produtos.

Um _cliente_ (usuário comum cadastrado na plataforma) pode ver todo o catálogo de produtos ativos, filtrá-los por categorias ou buscá-los por nome, código ou descrição. Para realizar uma compra, o cliente pode adicionar produtos ao seu carrinho de compras e confirmar a compra.

_Visitantes_ podem ver todo o catálogo de produtos ativos, mas não podem realizar compras.

A partir do momento em que o cliente confirma uma compra, a mesma é processada pelo App [Pagamentos](https://github.com/TreinaDev/pagamentos-td08-time02), retornando a aprovação ou não aprovação de uma compra.

</br>

## Tipos de usuário

### **Visitante (usuário não cadastrado)**

#### **É capaz de:**

- Visualizar produtos

Categorias e produtos inativos não são exibidos para visitantes e clientes. Produtos sem preços cadastrados para os próximos 90 dias são desativados automaticamente.

### **Cliente**

#### **É capaz de:**

- Visualizar produtos
- Adicionar/Remover produtos do carrinho
- Confirmar compras
- Visualizar seu histórico de compras
- Visualizar seu saldo de rubis

Ao confirmar uma compra, um(a) cliente envia uma requisição HTTP para a API da aplicação de Pagamentos responsável por avaliar se ele(a) possui saldo suficiente para aquela compra. Caso positivo, a compra é automaticamente _aprovada_, e os rubis são debitados da sua conta; caso contrário, o status da compra é definido como _pendente_.

### **Administrador**

#### **É capaz de:**

- Cadastrar produtos
- Cadastrar categorias de produtos
- Cadastrar preços de produtos
- Cadastrar promoções
- Cadastrar cashbacks
- Vincular cashbacks a produtos
- Ativar/Desativar produtos
- Ativar/Desativar categorias
- Aprovar cadastros de outros administradores
- Visualizar compras dos clientes

Ao se cadastrar, o status de um administrador é registrado como _pendente_. Para ter acesso à aplicação, ele precisa ter seu cadastro aprovado por um administrador já cadastrado.

</br>

## Como executar o projeto

### 1. Clone o projeto a partir do seu terminal

```text
git clone git@github.com:TreinaDev/e-commerce-td08-time02.git
```

### 2. Entre no diretório da aplicação

```text
cd e-commerce-td08-time02
```

### 3. Execute a configuração inicial

```text
bin/setup
```

### 4. Execute a aplicação em sua máquina

```text
bin/dev
```

### 5. Acesse este endereço em seu navegador

```text
http://localhost:3000/
```

</br>

## Como executar os testes

```text
rspec
```

</br>

## Dependências do sistema

- ruby (3.1.0)

### Testes

- gem 'rspec-rails (5.1.2)'
- gem 'factory_bot_rails (6.2.0)'
- gem 'shoulda-matchers (5.1.0)'
- gem 'simplecov (0.21.2)'

### Linter

- gem 'rubocop-performance'
- gem 'rubocop-rails'
- gem 'rubocop-rspec'

### Requisições

- gem 'faraday (2.3.0)'

### Estilização

- gem 'tailwindcss-rails (2.0)'

### Autenticação e autorização

- gem 'devise (4.8.1)'
