# E-comerce

Este projeto foi desenvolvido para funcionar junto com [Pagamentos](https://github.com/TreinaDev/pagamentos-td08-time02).

Na aplicação podem existir três tipos de usuário, administradores(devem ter o domínio do email: @mercadores.com.rb), clientes e visitantes que apenas acessam as aplicações sem se cadastrar. Na plataforma os produtos só podem ser comprados com rubis que podem ser adicionados ao saldo do cliente por meio de api na app de pagamentos.
## Como executar o projeto

com o git já instalado use o comando:

```text
git clone git@github.com:TreinaDev/e-commerce-td08-time02.git
```

em seguida:

```text
bin/setup
```

para popular o banco:

```text
rails db:seed
```

para rodar os testes:

```text
rspec
```

para rodar a aplicação em sua máquina:

```text
bin/dev
```

acesse em seu navegador:
<http://localhost:3000/>

## Dependencias do sistema

- ruby 3.1.0
