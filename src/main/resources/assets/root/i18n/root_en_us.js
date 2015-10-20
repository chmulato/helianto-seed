angular.module('app.services').
value('lang', {
	NO_CONTENT:'Não há conteúdo',
	CONSULTANCY:'Consultoria',
	FRANCHISE:'Franquias',
	ASSOCIATION:'Associações',
	SPORT:'Esportes',
	_getLocalizationKeys: function() {
		var keys = {};
		for (var k in this) {
			keys[k] = k;
		}
		return keys;
	}
});
angular.module('app.services').	value('lang', {_getLocalizationKeys: function() {var keys = {};for (var k in this) {keys[k] = k;}return keys;}});