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

	<h3 align="middle">Termos de uso</h3>
	<p align="middle">Atualizado em 22 de Maio de 2015.</p>
	<br/>

    <div class="panel panel-default">
	<div class="panel-body" data-slim-scroll="" data-scroll-height="320px">
	<p>
	Este Termo e Condições Gerais ("Termo") aplica-se ao uso dos serviços oferecidos pela I-SERV CONSULTORIA EMPRESARIAL LTDA., 
	sociedade devidamente inscrita no CNPJ/MF sob o nº 04.345.652/0001-19, gestora do site www.iservport.com e dos 
	serviços objeto deste Termo, doravante denominada ISERVPORT, pela PESSOA FÍSICA OU JURÍDICA, maior e capaz, 
	que tenha preenchido o Cadastro, cujos dados passam a ser parte integrante deste Termo, bem como que tenha 
	"aceitado" eletronicamente todas as cláusulas do mesmo e todas as demais políticas disponíveis no site, 
	doravante denominado USUÁRIO.
	</p>
	<p>
	Os serviços disponíveis pela ISERVPORT no site www.iservport.com serão regidos pelas cláusulas e condições abaixo.
	Ao aceitar eletronicamente o presente Termo, através do clique no botão “Li e concordo com os termos de uso” da 
	página de cadastro complementar a esta, o USUÁRIO estará automaticamente aderindo e concordando em se submeter 
	integralmente a seus termos e condições e de qualquer de suas alterações futuras, além de aceitar as disposições 
	das políticas do site.
	</p>
	<p>Cláusula 1 - do uso</p>
	<p>
	1.1 Sujeito aos termos e condições do presente instrumento, este Termo concede ao USUÁRIO uma licença revogável, não exclusiva e intransferível para usar o SERVIÇO. O USUÁRIO não poderá utilizar e nem permitir o uso do SERVIÇO para uma outra finalidade que não seja o processamento de suas informações ou de pessoas jurídicas indicadas no ato do cadastramento, neste caso, quando se tratar de empresa de consultoria que utilizar o SERVIÇO para processar informações de seus clientes, observados os limites estabelecidos neste Termo. Esta licença não implica na capacidade de acessar outros softwares além daqueles originalmente localizados no SERVIÇO. Em nenhuma hipótese o USUÁRIO terá acesso ao código fonte do SERVIÇO ora licenciado, por este se tratar de propriedade intelectual da ISERVPORT.
	</p><p>
	1.2 Em que pese ser passível de utilização a partir de qualquer parte do mundo, o USUÁRIO declara-se ciente e concordando que, independentemente do local de onde estejam sendo acessados os serviços, a relação entre o USUÁRIO e a ISERVPORT estará sempre, e em qualquer hipótese, sujeita à legislação brasileira.
	</p>
	<p>Cláusula 2 - das modificações no presente termo</p>
	<p>
	2.1. A ISERVPORT poderá alterar, a qualquer tempo, as condições do presente Termo, visando seu aprimoramento e melhoria dos serviços prestados. As novas condições entrarão em vigor 10 (dez) dias após sua publicação no SITE. Sendo assim, caso não concorde com as modificações, o USUÁRIO terá o prazo de 5 (cinco) dias, contados a partir da publicação, para comunicar por e-mail sua não concordância e requisitar o cancelamento do referido cadastro com suas informações. Neste caso, o vínculo contratual deixará de existir, e desde que não haja contas ou dívidas em aberto. No entanto, não havendo manifestação no prazo acima estipulado, entender-se-á que o USUÁRIO aceitou tacitamente as novas condições do Termo e continuará vinculando as partes.
	</p>
	<p>Cláusula 3 - das práticas proibidas</p>
	<p>
	3.1. Os serviços disponíveis no SITE da ISERVPORT poderão ser utilizadas para o gerenciamento de sistemas de gestão de empresas dos USUÁRIOS, mediante o LOGIN e SENHA do USUÁRIO no SITE. No entanto, está expressamente proibida pelo presente Termo, pelas demais políticas da ISERVPORT, ou pela lei vigente, a inserção de quaisquer informações pelo USUÁRIO na plataforma do SITE que contenham determinados dados, imagens e/ou legendas, ou que façam apologia a: (i) órgãos ou membros íntimos humanos ou de animais; (ii) armas de fogo, munições, cartuchos, silenciadores e outros acessórios, bem como lança-chamas, gases letais, gás mostarda, gás lacrimogêneo, produtos que contenham pólvora e explosivos em geral ou quaisquer produtos, que mesmo inofensivos, sejam confundidos com armas de fogo; (iii) Narcóticos; (iv) medicamentos, substâncias e produtos para a saúde ou estética que requeiram a prescrição médica, desde que o USUÁRIO não tenha meios de comprovar o respectivo registro autorizando o exercício desta atividade específica; (v) produtos que requeiram a homologação de órgãos governamentais, e que o USUÁRIO não tenha meios de comprovar o respectivo registro; (vi) propriedades roubadas, furtadas ou subtraídas, ou de qualquer origem ilícita, tais como contrabando, falsificações ou adulterações; (vii) cigarro e derivados de tabaco e/ou que façam apologia ao hábito de fumar; (viii) animais em extinção de qualquer espécie; (ix) fogos de artifício, ou qualquer artigo que contenha elementos e compostos químicos capazes de arder, e produzir um efeito sonoro, visual, mecânico ou térmico utilizável como entretenimento, desde que o USUÁRIO não tenha meios de comprovar o respectivo registro autorizando o exercício desta atividade específica; (x) Conteúdos relacionados à prostituição ou similares, e quaisquer informações sobre produtos de material pornográfico, erótico, obsceno, desde que o USUÁRIO não tenha meios de comprovar o respectivo registro autorizando o exercício desta atividade específica; (xi) que promovam a violência e/ou discriminação, baseada em questões de raça, sexo, religião, nacionalidade, orientação sexual ou de qualquer outro tipo; (xii) atividades que violem as leis sobre a propriedade intelectual, tais como cópias não autorizadas, utilização de imagens ou textos sem autorização do autor, sejam elas marcas, réplicas e/ou falsificações; (xiii) que façam indícios a loterias, rifas e jogos de azar; (xiv) inseticidas, pesticidas, raticidas e outros tipos de venenos, desde que o USUÁRIO não tenha meios de comprovar o respectivo registro autorizando o exercício desta atividade específica; e (xv) quaisquer outras atividades vedadas na legislação vigente.
	</p><p>
	3.1.1. Neste sentido, é responsabilidade exclusiva do USUÁRIO velar pela legalidade de suas atividades e a ISERVPORT não assume nenhuma responsabilidade pela existência deles no SITE, podendo a ISERVPORT suspender ou cancelar o CADASTRO destes USUÁRIOS que não cumpram com as restrições descritas no presente Termo, sem prejuízo das ações legais que possam ocorrer pela configuração de delitos ou contravenções em decorrência das atividades exercidas.
	</p><p>
	3.2. Caso a ISERVPORT verifique ou suspeite que algum USUÁRIO esteja violando alguma condição especifica do presente Termo ou que seja considerada uma atividade ilícita, além das medidas de proteção já descriminadas no presente Termo, tais como o cancelamento do referido CADASTRO, os dados do USUÁRIO infrator serão encaminhados às autoridades correspondentes, para que estas tomem as medidas judiciais cabíveis.
	</p>
	<p>Cláusula 4 - do prazo e da vigência</p>
	<p>
	4.1. O presente Termo possui prazo indeterminado, entrando em vigor na data de seu aceite eletrônico. Ambas as Partes poderão rescindir a prestação dos serviços objeto do presente Termo a qualquer momento, mediante comunicação prévia e expressa à outra parte no prazo de 15 (quinze) dias, desde eventuais débitos existentes (custos, despesas, encargos operacionais) ou eventuais indenizações decorrentes de lesão a terceiros por conta do mau-uso dos serviços pelo USUÁRIO sejam quitados. 
	</p>
	<p>Cláusula 5 - das disposições gerais e do foro</p>
	<p>
	5.1. O USUÁRIO expressamente aceita que a ISERVPORT e/ou qualquer de seus parceiros enviem aos seus assinantes mensagens de e-mail de caráter informativo, referentes a comunicações específicas inerentes aos Serviços prestados sob este Termo, bem como de natureza comercial, incluindo, entre outras, a ofertas dos parceiros da ISERVPORT , novidades no SITE, entre outras informações.
	</p><p>
	5.2. A fim de manter e atender os últimos requisitos de mercado e de desenvolvimento tecnológicos, a ISERVPORT poderá alterar, a seu critério, tanto em forma como em conteúdo, suspender ou cancelar, a seu exclusivo critério, a qualquer tempo, quaisquer dos serviços, produtos, utilidade ou aplicação, disponibilizados por si ou por terceiros, mediante prévio aviso ao USUÁRIO, inclusive com relação aos serviços disponíveis no SITE prestados nos termos do presente Instrumento.
	</p><p>
	5.3. A tolerância da ISERVPORT com o USUÁRIO, relativamente ao descumprimento de qualquer das obrigações ora assumidas, não será considerada novação ou renúncia a qualquer direito, constituindo mera liberalidade, que não impedirá a ISERVPORT de exigir posteriormente o fiel cumprimento das condições previstas neste Termo, a qualquer tempo.
	</p><p>
	5.4. O USUÁRIO declara e concorda expressamente: a) ser maior de 18 anos e/ou possuir capacidade jurídica ou autorização para contratar os serviços ISERVPORT; b) em instalar e manter atualizados programas Anti Spywares, Antivírus e outros que impeçam a violação do sistema que é utilizado para ter acesso aos serviços do ISERVPORT; c) não utilizar os serviços objeto do presente Termo para quaisquer transações ilícitas; d) em manter o sigilo de sua SENHA da conta cadastrada, não os fornecendo a terceiros; e) em notificar imediatamente a ISERVPORT caso tome ciência de qualquer violação de segurança relacionada aos serviços disponibilizados no SITE da ISERVPORT ou uso não autorizado de seu nome de USUÁRIO e SENHA; f) que leu e está ciente e de pleno acordo com todos os termos e condições do presente Termo, razão pela qual o aceita de livre e espontânea vontade.
	</p><p>
	5.5. Assim, tendo em vista as cláusulas do presente Termo, o USUÁRIO concorda integralmente com essas disposições, se comprometendo a respeitar as condições aqui previstas de forma irretratável e irrevogável, bem como a utilizar de modo proveitoso e legal os serviços a ele oferecidos.
	</p><p>
	5.6. Todos os itens deste Termo de Uso estão regidos pelas leis vigentes na República Federativa do Brasil. Para todos os assuntos referentes à sua interpretação e cumprimento, as partes se submeterão de forma irrevogável e irretratável, ao foro da Comarca da Cidade de Curitiba, Estado do Paraná, para dirimir quaisquer dúvidas ou controvérsias oriundas deste Termo, com a exclusão de qualquer outro, por mais privilegiado que seja.
	</p>
	<p>[FIM]</p>
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
	

    
    
	
		   	 </div></div>
		  	 <div class="col-md-2">
		  	 </div>
		</div>
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

	<script type="text/javascript" src="/ng/security/ng-security-module.js"></script>
	<script type="text/javascript" src="/ng/services.js"></script>
</body>
</html>
