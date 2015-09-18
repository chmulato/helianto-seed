## Backlog ##

  * A Prime deve ser capaz de cadastrar um novo cliente no testit; o cliente confirma via e-mail.

  * O cliente passa a acessar o sistema com suas credencias para visualizar seus projetos; o administrador da Prime também acessa o sistema como se possuísse a mesma credencial do cliente.

  * O administrador do cliente cadastra outras pessoas de sua organização.

  * O sistema testit mantém um registro de horas trabalhadas por dia por usuário; esta horas são lidas através de uma conexão com o PE (WS); as consultas referem-se ao dia anterior e são feitas às 14h.
  
  * Uma vez que os projetos estejam já cadastrados (ver abaixo), assim como também as pessoas que neles trabalham, significa que  possuímos uma lista de projetos ATIVOS por pessoa, onde cada usuário pode fazer check-in; manteremos uma lista de eventos com o check-in de cada usuário; eventualmente ele faz check-out, mas o sistema assume que o CO é automático caso haja um novo check-in.

  * Existem atividades que subtraem o total de horas trabalhas por projeto; parte delas vem do registro de entrada e saída do ponto; parte vem de outros eventos, tais como reuniões, etc.; o sistema calcula o acumulado de horas por usuário e por projeto em um dado período.

  * O gerente de projeto cria novo projeto no Testit; atribui pessoas ao projeto, descreve requisitos e [determina cenários de teste]; o sistema sincroniza estas informações com 2 partes externas: 1) Enterprise Tester, onde os cenários serão executados, e 2) o TFS do cliente, para fins de informação.

  * O analista de teste executa os testes no ET; a execução é atualizada no Testit.

  * O analista de testes inclui bugs no ET; os bugs são atualizados no Testit e no TFS; eventualmente o cliente atualiza o bug no TFS e os dados são reproduzidos no ET.

  * O Testit consolida os dados dos projetos e de usuários para a emissão de relatórios diários para o cliente.
  
## Sprint 1 ##

### Objetivos do Sprint ###

  * Permitir cadastro de usuários;

  * Permitir cadastro de projetos e participantes;
  
  * Criar interface para check-in nos projetos;
  
  * Criar lógica de check-in/out de projetos.
  
## Sprint 2 ##

### Objetivos do Sprint 2 ###

  * Comunicar com WS PrimeSW
  
  * Incluir lógica de subtração de tempo nos processos.
  
  * Gerar gráficos de burn-up.
  
  