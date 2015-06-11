[#ftl]
<!DOCTYPE html>
<html id="ng-app" xmlns:ng="http://angularjs.org" data-ng-app="security" >
<head>
	<link type="image/x-icon" href="/images/favicon.ico" rel="shortcut icon">
	<link type="image/x-icon" href="/images/favicon.ico" rel="icon">
    <title>Login</title>
    
	<!-- jQuery package -->
    <script type="text/javascript" src="/webjars/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="/webjars/jquery-validation/1.13.0/jquery.validate.min.js"></script>
	<!-- Bootstrap package -->
	<link rel='stylesheet' href='/webjars/bootstrap/3.3.2/css/bootstrap.min.css'>
	<link rel='stylesheet' href='/css/iservport.css'>
    <script type="text/javascript" src="/webjars/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
    <link rel='stylesheet' href="/webjars/font-awesome/4.3.0/css/font-awesome.css">
   
</head>
<body style="background-color: #f3f3f4;">

	<div id="unauth">
	<div id="main" class="container" data-ng-controller="SecurityController as securityCtrl" >
	<div class="container-small" data-ng-cloak >

	<!--
	 ! Logotipo
	 !-->
	<div class="clearfix text-center">
		<a href="#" class="text-center" target="_self"><img src="/images/logo.png" alt="TestIT" ></a>
	</div>
	<script >
		var email = [#if email??]'${email}' [#else]''[/#if];
	</script>
	
	<h3 align="middle">Bem vindo ao <strong>Testit</strong></h3>
	<p align="middle">O iservport é um aplicativo de produtividade para o seu sistema de gestão.</p>
	<br/>
	
    <!-- Login form -->
       
	<div class="panel panel-default">
	
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-12">
					<h3 class="panel-title"><span class="glyphicon  glyphicon-lock"></span> Entrar</h3>
				</div>
			</div>
		</div>
		
		<div class="panel-body">
		<form  name="form" data-ng-submit="login(username,password)">
		
		
			<!-- Possíveis mensagens de sucesso e erro -->
			[#if error?? ]
				[#if user?? && !user.accountNonExpired  ]		
					<!--
					 ! Usuário inativo
					 !-->
					<div class="alert alert-danger" role="alert">
						<i class="fa fa-lock"></i> Usuário inativo 
					</div>
				[#else]	
					<!--
					 ! Erro ao fazer login
					 !-->
					<div class="alert alert-danger" role="alert">
						<i class="fa fa-lock"></i> Erro ao fazer login
					</div>		
				[/#if]
			[/#if]
			[#if userConfirmed?? ]
					<div class="alert alert-success" role="alert"><i class="fa fa-unlock"></i> Seu usuário foi ativado, faça o login para entrar.</div>		
			[/#if]
			[#if emailRecoverySent?? ]
					<div class="alert alert-warning" role="alert">Consulte seu email para recuperar sua senha. </div>		
			[/#if]
			[#if emailRecoveryFailed?? ]
					<div class="alert alert-warning" role="alert">Falha ao enviar o email para recuperar sua senha. </div>		
			[/#if]
			[#if recoverFail?? && recoverFail="true" ]<div class="alert alert-danger" role="alert">Falha ao mudar a senha. </div>[/#if]
			
			[#if recoverFail?? && recoverFail="false"]<div class="alert alert-success" role="alert">Senha modificada com sucesso. </div>[/#if]

			<!--
			 ! Campos de email e senha
			 !-->
			<div id="form-group-email" class="form-group">
				<input type="email"  required="" name="username"  data-ng-model="username" placeholder="E-mail" class="form-control">
			</div>
			<div id="form-group-password" class="form-group">
				<input type="password"  required="" name="password" data-ng-model="password" placeholder="Senha" class="form-control">
			</div>
			
			<!--
			 ! Lembrar senha e esqueceu senha
			 !-->
			<div class="row">
				<div class="col-md-6">
					<p><input type="checkbox" name="remember-me" > Lembrar senha</p>
				</div>
				<div class="col-md-6">
					<a target="_self" class="pull-right" data-ng-href="/recovery/">Esqueceu sua senha?</a>
				</div>
			</div>
			
			<!--
			 ! Submit
			 !-->
			<hr/>
			<button type="submit" class="btn btn-primary" style="width: 100%" >Continue</button>
			
			
		</form>
		</div><!-- panel body -->
		<div class="panel-footer">
			<!--
			 ! Novo usuário
			 !-->
			<div class="row">
				<div class="col-md-6">
					<h5>Não possui acesso ainda?</h5>
				</div>
				<div class="col-md-6">
					<h5><a class="pull-right" href="/signup/">Criar conta de usuário</a></h5>
				</div>
			</div>
		</div><!-- panel footer -->
	</div>
	
<footer class="footer">
		<hr>
        <p>© i-serv Consultoria Empresarial Ltda. 2015</p>
  
  		<div class="row">
    	<div class="col-md-12">
	 		<small> 
		 			<a class="text-muted" target="_new" data-ng-href="/signup/privacy/" href="/signup/privacy/"> Politica de Privacidade</a>  |
		    		<a target="_new" class="text-muted" data-ng-href="/signup/license/" href="/signup/license/"> Termos de Uso</a>
			</small>
     	</div>
		</div>
</footer>

	</div><!-- .container-small -->
	</div><!-- #main -->
	</div><!-- #unauth -->

	<!-- AngularJs package -->
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-sanitize.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-resource.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-route.min.js"></script>
	<script type="text/javascript" src="/webjars/angularjs/1.3.1/angular-cookies.min.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-bootstrap/0.11.2/ui-bootstrap-tpls.js"></script>
	<script type="text/javascript" src="/webjars/angular-ui-utils/0.1.1/ui-utils.min.js"></script>

	<script type="text/javascript" src="/assets/security/ng-security-module.js"></script>
	<script type="text/javascript" src="/assets/services.js"></script>

</body>
</html>