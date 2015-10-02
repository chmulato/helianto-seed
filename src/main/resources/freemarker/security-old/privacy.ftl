<!DOCTYPE html>
<html id="ng-app" xmlns:ng="http://angularjs.org" data-ng-app="security" >

<#import "/spring.ftl" as spring/>

<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"] />

<head>
	<link type="image/x-icon" href="/images/favicon.ico" rel="shortcut icon">
	<link type="image/x-icon" href="/images/favicon.ico" rel="icon">

    <title>SignUp Iservport</title>
    
	<!-- jQuery package -->
    <script type="text/javascript" src="/webjars/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="/webjars/jquery-validation/1.13.0/jquery.validate.min.js"></script>
	<!-- Bootstrap package -->
	<link rel='stylesheet' href='/webjars/bootstrap/3.3.2/css/bootstrap.min.css'>
	<link rel='stylesheet' href='/css/iservport.css'>

	<link rel='stylesheet' href='/css/signup.css'>

    <script type="text/javascript" src="/webjars/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
    <link rel='stylesheet' href="/webjars/font-awesome/4.3.0/css/font-awesome.css">
   
</head>
<body class="gray-bg">

	<div id="unauth">
	<div id="main" class="container" data-ng-controller="SecurityController as securityCtrl"  class="middle-box text-center loginscreen  animated fadeInDown">

	<!--
	 ! Logotipo
	 !-->
	<div class="clearfix text-center">
		<img src="/images/logo.png" alt="">
	</div>

	<h3 align="middle">Politica de Privacidade</h3>
	<p align="middle">Atualizado em 22 de Maio de 2015.</p>
	<br/>

    <div class="panel panel-default">
	<div class="panel-body" data-slim-scroll="" data-scroll-height="320px">

			<h1>Coleta de dados gerais</h1>
			<p>A prioridade do <b>iservport</b> é assegurar a privacidade e a segurança das informações cedidas pelos 
			usuários cadastrados (“Usuário”). Neste sentido, o <b>iservport</b> envidará seus melhores esforços para 
			garantir a proteção da privacidade dos Usuários no <b>iservport</b>, pois tem como política a não 
			participação na prática de venda ou intercâmbio de dados pessoais com terceiros para fins promocionais.</p>
			<p>No entanto, o <b>iservport</b>, de maneira especifica monitora algumas informações de identificação 
			pessoal necessárias para atingir os fins descritos na presente Política de Privacidade. Ao utilizar o 
			<b>iservport</b>, por meio do seu website ou aplicativo para celular, o usuário reconhece e aceita este 
			recolhimento, conforme descrito neste Instrumento.</p>
			<p>O <b>iservport</b> se reserva o direito de modificar esta Política de Privacidade a qualquer momento. 
			Todas as modificações serão avisadas através dos nossos veículos oficiais de comunicação com o 
			Usuário que, ao permanecer no sistema, demonstra que concordam com as modificações realizadas.</p>

			<h2>1 - Cadastro do Usuário</h2>
			<div class="useTermsExplanation">
				<p>O usuário cadastra-se no <b>iservport</b> por livre e espontânea vontade, informando dados 
				(nome, <em>e-mail</em>, senha e outros) que nunca serão exibidos para outros usuários.</p>
				<p>Estes dados, mesmo os obrigatórios para o cadastro, podem ser modificados apenas pelo usuário 
				posteriormente, a qualquer hora.</p>
			</div>

			<p>O objetivo do <b>iservport</b> em permitir que o Usuário voluntariamente coloque suas informações 
			é facilitar a navegação do <b>iservport</b> e o uso de suas ferramentas. A proatividade do Usuário em 
			ceder seus dados significa que ele quer ser beneficiado com as ferramentas do <b>iservport</b> e concorda 
			com os termos de privacidade.</p>
			<p>Para se tornar um Usuário, o primeiro passo é o seu cadastro pessoal, onde nome, <em>login</em>, 
			<em>e-mail</em> e senha são dados obrigatórios. O usuário pode cadastrar suas redes sociais (Twitter, 
			Facebook) para integração e pode publicar uma mensagem da <b>iservport</b> em seu perfil pessoal.</p>
			<p>As informações adicionais podem ser colocadas tanto durante o cadastro, quanto num momento posterior 
			de preferência do Usuário para alterar seu perfil pessoal e de sua empresa. Dentre as possibilidades de 
			informações adicionais, vale reforçar que o e-mail do Usuário nunca será exibido para os demais Usuários.</p>
			<p>Portanto, recomendamos que o Usuário possua cuidado ao enviar informações para o <b>iservport</b>; 
			particularmente, ao preencher campos de texto livres ou ao fazer <em>upload</em> de conteúdos, 
			documentos e outros materiais. Os serviços do <b>iservport</b> são automatizados, não sendo possível 
			reconhecer quando o Usuário nos forneceu acidentalmente informações incorretas.</p>
			<p>O Usuário tem direito de acessar, modificar, corrigir e eliminar os dados sobre ele referentes à 
			sua decisão de ter se tornado um Usuário. Se o Usuário atualizar qualquer informação, o <b>iservport</b> 
			poderá manter uma cópia das informações anteriores fornecidas por ele em nossos arquivos e 
			documentações sobre uso do sistema, por  tempo razoável, para fins de segurança e sujeito aos 
			termos da lei.</p>
			<p>Para mudanças mais importantes, o <b>iservport</b> faz uso de criptografia de senha e protocolos 
			de confirmação via e-mail.</p>

			<h2>2 - Informações pessoais coletadas pelo <b>iservport</b>.com.br</h2>
			<div class="useTermsExplanation">
				<p>O <b>iservport</b> utiliza <em>cookies</em> para melhorar a experiência do usuário com o 
				sistema. O usuário pode, no entanto, bloquear <em>cookies</em> por meio das configurações do 
				seu navegador.</p>
				<p>As informações fornecidas pelo usuário nunca serão fornecidos para terceiros, exceto 
				nos casos em que o usuário autorize, que o fornecimento seja legalmente exigido pelo governo, 
				ou que o fornecimento resguarde os direitos do usuário e do <b>iservport</b>.</p>
			</div>

			<p>O <b>iservport</b> utiliza-se da tecnologia de <em>“cookies”</em> (dados no computador ou celular 
			do Usuário) para permitir sua correta identificação, além de melhorar a qualidade das informações 
			oferecidas em seu portal para os Usuários. O uso regular de <em>cookies</em> é uma prática aceitável 
			de mercado, pois permite o armazenamento de informações importantes, como, por exemplo, os acessos 
			do Usuário no <b>iservport</b>, para posteriormente não ser apresentado um conteúdo repetido ou 
			ultrapassado. Se não for a vontade do Usuário receber cookies, ou o mesmo desejar uma notificação 
			prévia antes de seu uso, ele deverá programar, a seu critério, seu <em>web browser</em> (navegador da Web) 
			com estas opções, caso seu <em>browser</em> disponha do recurso.</p>
			<p>Além das informações pessoais fornecidas pelo Usuário, o <b>iservport</b> tem a capacidade 
			tecnológica de recolher outras informações técnicas, como o endereço de protocolo de Internet do 
			Usuário, o sistema operacional do computador ou do celular, o tipo de <em>browser</em>, o endereço 
			de <em>websites</em> de referência e a localização física do dispositivo de acesso se o Usuário 
			tiver consentido em compartilhar seu local com os serviços de geolocalização. A coleta destas 
			informações tem como objetivo possibilitar ao <b>iservport</b> aprimorar as ferramentas e serviços 
			disponíveis aos Usuários, bem como auxiliar o próprio Usuário melhorar a própria experiência de uso 
			do Usuário com o <b>iservport</b>, como, por exemplo, categorizar algumas despesas e receitas dentro 
			da plataforma móvel do <b>iservport</b>.</p>
			<p>O <b>iservport</b> não fornecerá as informações do Usuário a terceiros sem prévia autorização 
			do mesmo, com exceção de casos nos quais seja necessário o fornecimento para fins de resposta a ordens, 
			solicitações ou perguntas de entidades governamentais ou judiciais ou nos casos em que tal fornecimento 
			seja necessário para a proteção de direitos ou da segurança do <b>iservport</b>, de seus Usuários ou 
			do público em geral.</p>
			<p>O Usuário expressamente autoriza o <b>iservport</b> a divulgar estas informações pessoais para atender 
			aos fins acima indicados.</p>
			<p>O <b>iservport</b> poderá, a seu critério, fazer uso das informações armazenadas nos seus bancos 
			de dados, conforme descrito acima, por um prazo razoável, sem que exceda os requisitos ou limitações 
			legais, para dirimir quaisquer disputas, solucionar problemas e garantir os direitos do <b>iservport</b>, 
			assim como os termos e condições da presente Política de Privacidade.</p>
			<p>O <b>iservport</b> deverá também, a seu critério, examinar as informações armazenadas nos seus bancos 
			de dados com o propósito de identificar Usuários com múltiplas identidades ou pseudônimos para fins 
			legais ou de segurança.</p>
			<p>Sobre as Informações que o <b>iservport</b> coleta em relação às redes sociais, se o Usuário usar o 
			aplicativo do <b>iservport</b>, páginas ou <em>plug-ins</em> de rede sociais ou usar nossos serviços 
			que permitem a interação com redes sociais, o <b>iservport</b> poderá receber informações relativas 
			às suas contas de redes sociais, tais como detalhes básicos do perfil da rede social do Usuário, que 
			poderão depender das configurações de privacidade da conta da rede social, mas que incluirão a 
			identificação do Usuário na rede social, seu nome, sua fotografia do perfil, seu sexo e sua localidade.</p>

			<h2>3 - Permissão do Usuário para Coleta e Uso de Dados pelo <b>iservport</b></h2>
			<div class="useTermsExplanation">
				<p>As informações fornecidas pelo usuário serão utilizadas pelo <b>iservport</b> para auxiliar o desenvolvimento de novos recursos e comunicar novidades do <b>iservport</b> e de parceiros.</p>
				<p>O usuário pode, a qualquer momento, cancelar sua conta e ter seus dados totalmente removidos. 
				No entanto, a remoção dos dados não será feita quando estes forem legalmente requeridos.</p>
			</div>

			<p>As informações cedidas pelo Usuário e registradas devido ao uso do sistema (com exceção ao conteúdo 
			de mensagens pessoais) servirão como insumos para o mapeamento de informações de mercado e formação de 
			estatísticas do <b>iservport</b>. Através do cadastramento, uso e fornecimento de informações ao 
			<b>iservport</b>, o Usuário expressamente aceita  as condições desta Política de Privacidade sobre a 
			coleta, armazenamento, processamento e uso de suas informações.</p>
			<p>As informações cedidas pelo Usuário que o torna pessoalmente identificável tem como objetivo fazer 
			com os Usuários do <b>iservport</b> se relacionem melhor com as ferramentas disponíveis. Informações 
			adicionais coletadas pelo <b>iservport</b> através da análise da navegação de cada Usuário e que não 
			o torne identificável pessoalmente (como o padrão de navegação, por exemplo) são de propriedade 
			exclusiva do <b>iservport</b>, que pode usar essas informações do modo que melhor julgar apropriada, 
			sujeito aos limites e condições desta Política de Privacidade.</p>
			<p>Além disso, as informações fornecidas são usadas para: (i) administrar a conta dos Usuários a 
			fim de customizar cada vez mais os serviços; e (ii) comunicar novidades e atualizações.</p>
			<p>Porém, o <b>iservport</b> pode retransmitir mensagens de parceiros, através da tecnologia de 
			<em>opt-in</em> (aceitar) escolhida pelo Usuário.</p>
			<p>O Usuário tem o direito de cancelar o seu cadastro no <b>iservport</b> e solicitar a remoção 
			definitiva dos seus dados. Não obstante, o <b>iservport</b> poderá manter determinadas informações 
			de forma a atender o cumprimento das leis e dos regulamentos aplicáveis em matéria de conservação 
			obrigatória de certos tipos de informações relativas aos Usuários e/ou quaisquer transações comerciais 
			com eles, bem como para atender a ordens ou solicitações de autoridades governamentais ou judiciais.</p>
			<p>Neste sentido, para fechar a sua conta no <b>iservport</b>, através do painel de configurações 
			ou mediante pedido aos administradores do site pelo e-mail <em>contato@iservport.com</em>.</p>


			<h2>4 - As Obrigações do Usuário</h2>
			<div class="useTermsExplanation">
				<p>O usuário compromete-se a seguir a política de privacidade, a não informar dados 
				que possam comprometê-lo social ou profissionalmente, e não utilizar o <b>iservport</b> 
				para disseminar informações e conteúdo proibido pela lei.</p>
			</div>

			<p>É dever do Usuário obedecer aos atuais termos e condições desta Política de Privacidade, o 
			que inclui respeitar propriedade intelectual de terceiros e do <b>iservport</b>.</p>
			<p>O Usuário não deve executar <em>download</em>, <em>upload</em> ou qualquer forma de disseminação 
			de material ou informação de caráter violento, ofensivo, racista ou xenofóbico ou qualquer um 
			que viole o espírito e objetivos do <b>iservport</b> e sua comunidade de usuários.</p>
			<p>O Usuário não deve prover ao <b>iservport</b> e/ou a qualquer outro Usuário informações que ele 
			acredite serem danosas à sua pessoa, profissional ou socialmente.</p>


			<h2>5 - Canal de Comunicação com o Usuário</h2>

			<p>Se o Usuário tiver qualquer dúvida ou sugestão sobre o <b>iservport.com</b>, ele poderá encaminhar um email 
			para o <em>contato@iservport.com</em>.</p>

	
	
	</div>
	<div class="panel-footer">
		<div class="row">
			<div class="col-md-6"> Já tem uma conta?</div>
			<div class="col-md-6">	<a class="pull-right" href="/login">Login</a></div>
		</div>
	</div>
	
		
	</div><!-- #main --> 
	<div class="row">
        <div class="form-group col-lg-4">
            <!-- Add create user account link -->
           
        </div>
  <footer class="footer">
		<hr>
        <p>© i-serv Consultoria Empresarial Ltda. 2015</p>
	</footer>
	</div>
	</div><!-- #unauth -->

	<!-- AngularJs package -->
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-sanitize.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-resource.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-route.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-cookies.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/i18n/angular-locale_${locale!'pt-br'}.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-bootstrap/0.11.2/ui-bootstrap-tpls.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-utils/0.1.1/ui-utils.min.js"></script>

	<script type="text/javascript" src="/assets/security/ng-security-module.js"></script>
	<script type="text/javascript" src="/assets/services.js"></script>
</body>
</html>
