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
 
mude async para true, caso queira que todas as funções sejam asincronas
 porém, erros podem ocorrer.
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
		setEmail(info[0].Player.email);
		setDateCreated(info[0].Player.created);
		setDateUpdated(info[0].Player.updated);
		setBonus(info[0].Player.bonus);
		setAchievements(info[0].Player.achievements);
		setBestScore(info[0].Player.best_score);
		//console.log("username:"+info[0].Player.username);
		//console.log("Password:"+info[0].Player.password);
		//console.log("Unic ID:"+info[0].Player.unic_id);
		//console.log("First Name:"+info[0].Player.first_name);
		//console.log("Last Name:"+info[0].Player.last_name);
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
	console.log("setUserName: "+this._player);
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
	console.log("setPassWord:"+this._password);
}

function getPassWord(){
	console.log("getPassWord"+this._password);
	return this._password;
}

function setUnicId(newUnicId)
{
	this._unic_id = newUnicId;
	console.log("Unic ID:"+this._unic_id);
}

function getUnicId()
{
	console.log("Get Unic ID: "+this._unic_id);
	return this.parseInt(_unic_id);
}

function setFirstName(newFirstName)
{
	this._first_name = newFirstName;
	console.log("First Name:"+this._first_name);
}

function getFirstName()
{
	console.log("get first name: "+this._first_name);
	return this._first_name;
}

function setLastName(newLastName)
{
	this._last_name = newLastName;
	console.log("set last name: "+this._last_name);
}

function getLastName()
{
	console.log("getLastName:"+this._last_name);
	return this._last_name;
}

function setEmail(newEmail)
{
	this._email = newEmail;
	console.log("set E-mail:"+this._email);
}

function getEmail()
{
	console.log("get E-mail:"+this._email);
	return this._email;
}

function setDateCreated(newDateCreated) // revisar a gramatica do nome da função.
{
	this._created = newDateCreated;
	console.log("set date created: "+this._created);
}

function getDateCreated()
{
	console.log("get date created: "+this._created);
	return this._created;
}

function setDateUpdated(newDateUpdated) // revisar a gramatica do nome da função.
{
	this._updated = newDateUpdated;
	console.log("set date updated: "+this._updated);
}

function getDateUpdated()
{
	console.log("get date created: "+this._updated);
	return this._updated;
}

function setBonus(newBonus)
{
	this._bonus = newBonus;
	console.log("Player Bonus: "+this._bonus);
}

function getBonus()
{
	console.log("get player bonus: "+this._bonus);
	return this._bonus;
}

function setAchievement(newAchievement)
{
	this._achievements = newAchievement;
	console.log("set achievement: "+this._achievements);
}

function getAchievement()
{
	console.log("get achievement: "+this._achievements);
	return this._achievements;
}

function setBestScore(newBestScore)
{
	this._best_score = newBestScore;
	console.log("Best Score: "+this._best_score);
}

function getBestScore()
{
	console.log("Best Score: "+this._best_score);
	return this._best_score;
}

function setGold(newGold)
{
	this._gold = newGold;
	console.log("New Gold value: "+this._gold);
}

function getGold()
{
	console.log("Get Gold value: "+this._gold);
	return this._gold;
}

function setMoney(newMoney)
{
	this._money = newMoney;
	console.log("New Money value: "+this._money);
	
}

function getMoney()
{
	console.log("Get Money value: "+this._money);
	return this._money;
}

function setKills(newKill)
{
	
	this._kills = newKill;
	console.log("set kills: "+this._kills)
}

function getKills()
{
	console.log("get kills: "+this._kills)
	return this._kills;
}

function setLives(newLive)
{
	this._lives = newLive;
	console.log("set lives: "+this._lives)
}

function getLives()
{
	console.log("get lives: "+this._lives)
	return this._lives;
}

function setTimePlayed(newTimePlayed)
{
	this._time_played = newTimePlayed;
	console.log("set time played: "+this._time_played);
}

function getTimePlayed()
{
	console.log("get time played: "+this._time_played)
	return this._time_played;
}

function setUnlockedLevels(newUnlockedLevel)
{
	this._unlocked_levels = newUnlockedLevel;
	console.log("set unlocked level: "+this._unlocked_levels);
}

function getUnlockedLevel()
{
	console.log("get unlocked level:"+this._unlocked_levels);
	return this._unlocked_levels;
}

function setUnlockedItems(newUnlockedItem)
{
	console.log("set unlocked Items: "+this._unlocked_items);
	this._unlocked_items = newUnlockedItem;
}

function getUnlockedItem()
{
	console.log("get unlocked items: "+this._unlocked_items);
	return this._unlocked_items;
}

function setInventory(newInventory)
{
	this._inventory = newInventory;
	console.log("set inventory: "+this._inventory);
}

function getInventory()
{
	return this._inventory;
	console.log("get inventory: "+this._inventory);
}

function setLastLevel(newLastLevel)
{
	this._last_level = newLastLevel;
	console.log("set last level: "+this._last_level);
}

function getLastLevel()
{
	console.log("get last level: "+this._last_level;);
	return this._last_level;
}

function setCurrentLevel(newCurrentLevel)
{
	this._current_level = newCurentLevel;
	console.log("set new current level: "+this._current_level);
}

function getCurrentLevel()
{
	console.log("get new current level: "+this._current_level);
	return this._current_level;
}

function setCurrentTime(newCurrentTime)
{
	this._current_time = newCurrentTime;
	console.log("set current time: "+this._current_time);
}

function getCurrentTime()
{
	console.log("get current time: "+this._current_time);
	return this._current_time;
}

function setCurrentBonus(newCurrentBonus)
{
	this._current_bonus = newCurrentBonus;
	console.log("set current bonus: "+this._current_bonus);
}

function getCurrentBonus()
{
	console.log("get current bonus: "+this._current_bonus);
	return this._current_bonus;
}

function setCurrentKills(newCurrentKill)
{
	this._current_kills = newCurrentKill;
	console.log("set current kills: "+this._current_kills);
}

function getCurrentKills()
{
	console.log("get current kills: "+this._current_kills);
	return this._current_kills;
}

function setCurrentAchievements(newCurrentAchievement)
{
	this._current_achievements = newCurrentAchievement;
	console.log("set current achievements: "+this._current_achievements);
}

function getCurrentAchievements()
{
	console.log("get current achievements: "+this._current_achievements);
	return this._current_achievements;
}

function setCurrentGold(newCurrentGold)
{
	this._current_gold = newCurrentGold;
	console.log("set current gold: "+this._current_gold);
}

function getCurrentGold()
{
	console.log("get current gold: "+this._current_gold);
	return this._current_gold;
}

function setCurrentUnlockedLevels(newCurrentUnlockedLevel)
{
	this._current_unlocked_levels = newCurrentUnlockedLevels;
	console.log("set current unlocked level: "+this._current_unlocked_levels);
}

function getCurrentUnlockedLevels()
{
	console.log("get current unlocked level: "+this._current_unlocked_levels);
	return this._current_unlocked_levels;
}

function setCurrentUnlockedItems(newCurrentUnlockedItems)
{
	console.log("set current unlocked Items: "+this._current_unlocked_items);
	this._current_unlocked_items = newCurrentUnlockedItems;
}

function getCurrentUnlockedItems()
{
	console.log("get current unlocked items: "+this._current_unlocked_items);
	return this._current_unlocked_items;
}

function setCurrentLives(newCurrentLives)
{
	this._current_lives = newCurrentLives;
	console.log("set current lives: "+this._current_lives);
}

function getCurrentLives()
{
	console.log("get current lives: "+this._curent_lives);
	return this._current_lives;
}

function setXp(newXp)
{
	this._xp = newXp;
	console.log("set XP: "+this._xp );
}

function getXp()
{
	console.log("get XP: "+ this._xp);
	return this._xp;
}

function setBoost(newBoost)
{
	this._boost = newBoost;
	console.log("set boost: "+this._boost);
}

function getBoost()
{
	console.log("get boost: "+this._boost);
	return this._boost;
}

function setLatitude(newLatitude)
{
	this._latitude = newLatitude;
	console.log("set Latitude: "+this._latitude);
}

function getLatitude()
{
	console.log("get latitude: "+this._latitude);
	return this._latitude;
}

function setLongitude(newLongitude)
{
	this._longitude = newLongitude;
	console.log("set longitude: "+this._longitude);
}

function getLongitude()
{
	console.log("get longitude: "+this._longitude);
	return this._longitude;
}

function setGameState(newGameState)
{
	this._game_state = newGameState;
	console.log("set game state: "+this._game_state);
}

function getGameState()
{
	console.log("get game state: "+this._game_state);
	return this._game_state;
}

function setPlatform(newPlatform)
{
	this._platform = newPlatform;
	console.log("set platform: "+this._platform);
}

function getPlatform()
{
	console.log("get Platform: "+this._platform);
	return this._platform;
}

function setRank(newRank)
{
	this._rank = newRank;
	console.log("set Rank: "+this._rank);
}

function getRank()
{
	console.log("get Rank: "+this._rank);
	return this._rank;
}
