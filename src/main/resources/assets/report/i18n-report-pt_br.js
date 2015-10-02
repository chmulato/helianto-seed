angular.module('app.services').
value('lang', {
	NO_CONTENT:'Não há conteúdo',
	CLOSE:'Fechar',
	ONE_INSTRUMENT:'Conteúdo',
	MANY_INSTRUMENT:'@{}@ conteúdos',
	STAFF_MEMBER_NOT_FOUND : 'Membro da Equipe não foi encontrado' , 
	STAFF_MEMBER_CANNOT_DELETE : 'Membro não pode ser deletado.',
	//pasta
	CONTENT_FOLDER : 'Pasta' ,
	CONTENT_BY: 'Documentos de ',
	NO_CONTENT : '',
	NO_CONTENT_MSG :'<strong>Não há documentos!</strong> clique no botão abaixo para cadastrar um Documento',
	
	//geral
	ISSUE_DATE:'Incluído em',
	NEXT_CHECK_DATE:'Próxima verificação',
	INTERNAL_NUMBER:"Número" ,
	COMPLETE:"Progresso" ,
	OWNER:"Responsável" ,
	
	SAVE_CONTENT_PUBLISH:'Confirmar publicação',	
	CONTENT_PUBLISH:'Publicação de Documentos',
	PUBLISH:'Publicar',
	
	DOCUMENT:'Documentos',
	COURSE:'Cursos',
	PRODUCT:'Produtos',
	LIBRARY:'Lições aprendidas',
	SCRIPT:'Scripts',
//	knowledge
	KNOWLEDGE_LEVEL:'Avaliação',
	KNOWLEDGE_LEVEL_0:'Não requer',
	KNOWLEDGE_LEVEL_1:'Em treinamento',
	KNOWLEDGE_LEVEL_2:'Treinado, acompanhar',
	KNOWLEDGE_LEVEL_3:'Treinado',
	KNOWLEDGE_LEVEL_4:'Pode treinar',
	RESOLUTION:'Requer reavaliação',
	RESOLUTION_T:'Sim',
	RESOLUTION_D:'Não',
	KNOWLEDGE_NOT_UNIQUE:'Já existe treinamento para este usuário e/ou Documento cadastrado'
	, PHASE:'Fase'
	, PHASES: 'Fases',	
	// Review
	DETAIL:'Detalhe',
	_getLocalizationKeys: function() {
		var keys = {};
		for (var k in this) {
			keys[k] = k;
		}
		return keys;
	}
});
