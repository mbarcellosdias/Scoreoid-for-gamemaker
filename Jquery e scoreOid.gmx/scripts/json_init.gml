/*
Copyright (c) 2010, Daniel Tang
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
var obj, init_code;
if (variable_global_exists("__json_object"))
{
    if (global.__json_object[3] = true)    return 0;
}
globalvar __json_object;
/*Initialize a json object object*/
obj = object_add();
init_code =
'level = 0;
type = "object";
keyvalues = ds_map_create();';
object_event_add(obj,ev_create,0,init_code);
init_code = /*Clean up code*/
'for (i=ds_map_size(keyvalues); i>0; i-=1)
{
    key = ds_map_find_first(keyvalues);
    obj = ds_map_find_value(keyvalues,key);
    with (obj) instance_destroy(); /*Destroy any instances attached*/
    ds_map_delete(keyvalues,key);
}
ds_map_destroy(keyvalues);';
object_event_add(obj,ev_destroy,0,init_code);
__json_object[0] = obj;
/*Initialize a json array object*/
obj = object_add();
init_code =
'level = 0;
type = "array";
keyvalues = ds_list_create();';
object_event_add(obj,ev_create,0,init_code);
init_code = /*Clean up code*/
'for (i=ds_list_size(keyvalues); i>0; i-=1)
{
    obj = ds_list_find_value(keyvalues,1);
    with (obj) instance_destroy(); /*Destroy any instances attached*/
    ds_list_delete(keyvalues,1);
}
ds_list_destroy(keyvalues);';
object_event_add(obj,ev_destroy,0,init_code);
__json_object[1] = obj;
/*Initialize a json nodevalue object*/
obj = object_add();
init_code =
'level = 0;
type = "nodevalue";
value = "";';
object_event_add(obj,ev_create,0,init_code);
__json_object[2] = obj;
__json_object[3] = true;
return 0;
