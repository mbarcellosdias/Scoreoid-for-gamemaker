/*
Script - listNumberOfPlayers(arg0)
arg0 - variável do tipo String que contém o codigo Json obtido como resposta da API pelo site scoreOid.com através da função pollCount() da extensão scoreiod.
---------------------------------

a variável lista receberá a String com o codigo Json decodificado e automaticamente criará uma lista, organizando todas as informações.
Caso Não hava nenhuma informação na string recebida, um valor default será atribuido e cairá na condição if, que destruirá a lista.

caso contrário, adicionaremos o número de jogadores a uma variável global numberOfPlayers. A pesquisa será feita através da palavra chave
"players", recebida dentro do json.

Após atribuir o valor a variável, a lista é destruída.

*/

var lista;
lista = json_decode(argument0);

if ds_map_exists(lista, "default")
{
    ds_map_destroy(lista);
    show_message("Tem informaçao nenhuma aqui");
    return false;
}
else
{
    global.numberOfPlayers = ds_map_find_value(lista,"players");
    ds_map_destroy(lista);
    show_message("Numero de jogadores:"+string(global.numberOfPlayers));
    return true;
}


