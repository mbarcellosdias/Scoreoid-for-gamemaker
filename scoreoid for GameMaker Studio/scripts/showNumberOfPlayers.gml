var codigo;
codigo = json_decode(argument0);

if ds_map_exists(codigo, "default")
{
    ds_map_destroy(codigo);
    show_message("Tem informaçao nenhuma aqui");
    return false;
}
else
{
    global.numberOfPlayers = ds_map_find_value(codigo,"players");
}show_message("Numero de jogadores:"+string(global.numberOfPlayers));
