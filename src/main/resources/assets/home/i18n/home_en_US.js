angular.module('app.services').
value('lang', {
	NO_CONTENT:'Não há conteúdo',
	CLOSE:'Fechar',
	_getLocalizationKeys: function() {
		var keys = {};
		for (var k in this) {
			keys[k] = k;
		}
		return keys;
	}
});
