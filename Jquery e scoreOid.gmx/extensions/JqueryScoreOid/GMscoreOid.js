var count;
// campos de informações sobre o jogador.
var _username, _password, _unic_id, _first_name, _last_name, _email;
var _created, _updated, _bonus, _achievements, _best_score, _gold, _money;
var _kills, _lives, _time_played, _unlocked_levels, _unlocked_items, _inventory;
var _last_level, _current_level, _current_time, _current_bonus, _current_kills;
var _current_achievements, _current_gold, _current_unlocked_levels, current_unlocked_items;
var _current_lives, _xp, _energy, _boost, _latitude, _longitude, _game_state, _platform, _rank;

/*
 A mudança do Script ajaxsetup na propriedade Async para false
 resolve o problema de retorno "undefined" nos metodos getters.
  */
$.ajaxSetup({
  async: false
});


function createPlayer(proxyUrl,responseType,userName,passWord,firstName,lastName,eMail)
{
      $.post(proxyUrl, {action:'curl_request', method:'createPlayer', response: responseType, username:userName, password:passWord, first_name:firstName, last_name:lastName,email:eMail}, 
        function(data) {
          alert("Data Loaded: " + data);
          console.log(data);
      });
	  
}
  
function deletePlayer(proxyUrl,userName,responseType)
{
	$.post(proxyUrl,{action:'curl_request', method:'deletePlayer',response:responseType,username:userName},
		function(data){
			//alert('Data Loaded: '+ data);
			console.log(data);
		});
}

function countPlayers(proxyUrl,responseType)
{
	$.post(proxyUrl,{action:'curl_request', method:'countPlayers',response:responseType},
		function(data){
			count = data;
			//alert('Data Loaded: '+ data);
			console.log(data);
		});	
}

// Funções que possibilitam um callback no game maker




function loadPlayerInfo(proxyUrl,responseType,userName,passWord) // parei aqui.

{
	$.post(proxyUrl,{action:'curl_request', method:'getPlayer',response:responseType, username:userName, password:passWord},
	function(data){
		var info;
		info = JSON.parse(data);
		console.log("--Chamada da função loadPlayerInfo----");
		//console.log("info parse data:"+info[0].Player);
		setUserName(info[0].Player.username);
		setPassWord(info[0].Player.password);
		setUnicId(info[0].Player.unic_id);
		setFirstName(info[0].Player.first_name);
		setLastName(info[0].Player.last_name);
		console.log("username:"+info[0].Player.username);
		console.log("Password:"+info[0].Player.password);
		console.log("Unic ID:"+info[0].Player.unic_id);
		console.log("First Name:"+info[0].Player.first_name);
		console.log("Last Name:"+info[0].Player.last_name);
		console.log("---- Fim da chamda da função loadPlayerInfo -----")
	});
}


function pollCount()
{
	return count;
}

// getters e setters das informações do Jogador.

function setUserName(newUserName)
{
	this._player = newUserName;
	console.log("setUserName: "+_player);
}

function getUserName() // aqui tinha um parâmetro qualquer.. caso pare de funcionar é só inserir denovo e testar... nao me pergunte o motivo...
{
	//console.log("getUserName: "+player);
	console.log("getUserName: "+this._player);
	return this._player;
}

function setPassWord(newPassWord)
{
	this._password = newPassWord;
	console.log("setPassWord:"+_password);
}

function getPassWord(){
	console.log("getPassWord"+this._password);
	return this._password;
}

function setUnicId(newUnicId)
{
	this._unic_id = newUnicId;
	console.log("Unic ID:"+_unic_id);
}

function getUnicId()
{
	console.log("Get Unic ID: "+_unic_id);
	return this.parseInt(_unic_id);
}

function setFirstName(newFirstName)
{
	this._first_name = newFirstName;
	console.log("First Name:");
}

function getFirstName()
{
	console.log("get first name: "+_first_name);
	return this._first_name;
}

function setLastName(newLastName)
{
	this._last_name = newLastName;
	console.log("set last name: "+newLastName);
}

function getLastName()
{
	return this._last_name;
}






















