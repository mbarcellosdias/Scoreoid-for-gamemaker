var count;
var player="";
var user = "";

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

function getPlayerInfo(proxyUrl,responseType,userName,passWord) // parei aqui.

{
	$.post(proxyUrl,{action:'curl_request', method:'getPlayer',response:responseType, username:userName, password:passWord},
	function(data){
		player = JSON.parse(data);
		getUserName();
		//console.log(player[0].Player);
		//console.log(player[0].Player.best_score);
		//alert(player);
		//console.log(player);
	});
}
// Funções que possibilitam um callback no game maker

function pollCount()
{
	return count;
}

function pollGetPlayer()
{
	//alert(player)
	return player;
	
}

function getUserName()
{
	var username = player;
	console.log("getUserName: "+player[0].Player.username);
	return player[0].Player.username;
}
