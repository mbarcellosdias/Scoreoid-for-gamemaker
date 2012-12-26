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
/*Pushes: new y value*/
var obj,str,i,addspace,orig_addspace;
obj = argument0;
addspace = string(argument1);
if (addspace = "0")
{
    addspace = "";
}
//str=addspace+"Dumping object \#"+string(obj)+"#";
str="";
switch (obj.type)
{
    case "object":
        curr_key = json_get_first_key(obj);
        for (i=0; i< json_object_size(obj);i+=1)
        {
            str+=addspace+"Key:       "+string_replace(json_escape(string(curr_key)),"#","\#")+"#";
            str+=addspace+"Value:     \#"+string_replace(json_escape(string(json_get_value(obj,curr_key,true))),"#","\#")+"#";
            str+=json_dump(json_get_value(obj,curr_key,true),addspace+"  ");
            curr_key = json_get_next_key(obj,curr_key);
        }
        break;
    case "array":
        for (i=0; i< json_object_size(obj);i+=1)
        {
            str+=addspace+"Key:       "+string(i)+"#";
            str+=addspace+"Value:     \#"+string_replace(json_escape(string(json_get_value(obj,i,true))),"#","\#")+"#";
            str+=json_dump(json_get_value(obj,i,true),addspace+"  ");
        }
        break;
    case "nodevalue":
        str+=addspace+'Value:     '+string_replace(json_escape(string(json_get_value(obj))),"#","\#")+"#";
        break;
}
//str+=orig_addspace+"Dump End \#"+string(obj)+"#";
return str;
