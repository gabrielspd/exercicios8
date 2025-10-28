Execução e Verificação do Script SQL

Pré-requisitos:

• Ter o PostgreSQL instalado (ou pgAdmin).
• Ter o arquivo do script salvo, por exemplo:

```sql
cafeteria_bomgosto.sql
```

Criar o banco de dados:

• No terminal psql ou pgAdmin, crie um banco de dados (exemplo: bomgosto):

```sql
CREATE DATABASE bomgosto;
```

Executar o script
Usando o pgAdmin:

• Abra o banco de dados bomgosto.
• Vá em Query Tool → File → Open File… → selecione Atividade8.sql.
• Clique em Execute (F5) para rodar todo o script.

Verificar os dados

• Após executar o script, você pode testar as consultas usando:

-- Listar todo o cardápio
```sql
SELECT * FROM cardapio;
```
(exemplo exec 01)

• Repita para as consultas das demais questões (2 a 5) para conferir os resultados.
• As tabelas são criadas do zero, então não é necessário ter nenhum dado pré-existente.
• O script inclui exemplos de comandas e itens, permitindo verificar todos os resultados sem precisar inserir novos dados.
