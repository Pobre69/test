# Sistema de Busca - Stay Go Turismo

## Como funciona a busca

O sistema de busca foi implementado com PHP e integra perfeitamente com o design existente do site. Aqui está como usar:

### 1. Configuração do Banco de Dados

1. Execute o arquivo `stayGo.sql` no seu MySQL para criar o banco
2. Execute `adicionar_pontos.php` para adicionar os pontos turísticos extras
3. Verifique se a conexão em `BDconection.php` está correta

### 2. Como a busca funciona

- **Página inicial**: Digite o nome do ponto turístico na barra de pesquisa
- **Busca parcial**: O sistema encontra resultados mesmo com nomes parciais
- **Links dinâmicos**: Cada resultado leva para a página HTML correta do ponto turístico

### 3. Pontos turísticos cadastrados

- **Mercado Central de Belo Horizonte** → `mercCentralBH.html`
- **Parque Municipal Américo Renné Giannetti** → `parqMunAmericoBH.html`  
- **Praça da Liberdade** → `pracLiberdBH.html`

### 4. Exemplos de busca

- Digite "Mercado" → Encontra o Mercado Central
- Digite "Parque" → Encontra o Parque Municipal
- Digite "Praça" → Encontra a Praça da Liberdade
- Digite "Belo Horizonte" → Encontra todos os pontos da cidade

### 5. Design integrado

- Mantém o mesmo visual da página principal
- Mostra informações do banco de dados (endereço, horário, avaliação)
- Página de "não encontrado" com sugestões
- Links funcionais para as páginas específicas

### 6. Para adicionar novos pontos

1. Adicione no banco usando a procedure `AdicionarPontoTuristico`
2. Crie a página HTML correspondente na pasta `html/`
3. Adicione o mapeamento no array `$paginas` em `BDconection.php`

O sistema está pronto para uso e pode ser facilmente expandido!