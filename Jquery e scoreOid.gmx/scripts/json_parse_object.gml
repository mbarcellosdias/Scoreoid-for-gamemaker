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
/*
Returns: -1 on failure, object pointer on success
Stack return:
    [0] New string position push'd first
*/
var str,stack,i,error,level,obj,curr_char,inew,param,value,wantout,expect;
str = argument0;
i = real(argument1);
level = real(argument2);
stack = argument3;
json_skip_whitespace(str,i,stack);
i = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error = 1)
{
    return -1;
}
if (json_char_type(string_char_at(str,i)) != 3)
{
    return -1;
}
i+=1;
obj = json_new_object("object",level); /*Create an object at current level*/
if (obj = -1)
{
    return -1;
}
curr_char = "";
expect = 0; /*0 = expecting a parameter, 1 = expecting a value*/
wantout = false;
while (curr_char != "}")
{
    json_skip_whitespace(str,i,stack);
    i = ds_stack_pop(stack);
    error = ds_stack_pop(stack);
    if (error = 1)
    {
        with (obj) instance_destroy();
        return -1;
    }
    curr_char = string_char_at(str,i);
    switch (expect)
    {
        case 0: /*Expecting a parameter*/
            switch (json_char_type(curr_char))
            {
                case 1:
                    json_parse_number(str,i,stack);
                    param = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    break;
                case 2:
                    json_parse_string(str,i,stack);
                    param = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    break;
                default:
                    with (obj) instance_destroy();
                    return -1;
                    break;
            }
            json_skip_delimiter(str,i,stack);
            i = ds_stack_pop(stack);
            error = ds_stack_pop(stack);
            if (error != 0)
            {
                with (obj) instance_destroy();
                return -1;
            }
            expect = 1;
            break;
        case 1: /*Expecting a value*/
            switch (json_char_type(curr_char))
            {
                case 1:
                    json_parse_number(str,i,stack);
                    value = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    value = json_new_object("nodevalue",level+1,value);
                    break;
                case 2:
                    json_parse_string(str,i,stack);
                    value = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    value = json_new_object("nodevalue",level+1,value);
                    break;
                case 3:
                    value = json_parse_object(str,i,level+1,stack);
                    if (value = -1)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    i = ds_stack_pop(stack);
                    break;
                case 4:
                    value = json_parse_array(str,i,level+1,stack);
                    if (value = -1)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    i = ds_stack_pop(stack);
                    break;
                default:
                    with (obj) instance_destroy();
                    return -1;
                    break;
            }
            json_skip_comma(str,i,stack);
            i = ds_stack_pop(stack);
            error = ds_stack_pop(stack);
            if (error != 0)
            {
                json_skip_whitespace(str,i,stack);
                i = ds_stack_pop(stack);
                error = ds_stack_pop(stack);
                if (error != 0)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                if (string_char_at(str,i) != "}")
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                wantout = true;
            }
            expect = 0;
            json_add_value(obj,value,param);
            break;
        default:
            with (obj) instance_destroy();
            return -1;
            break;
    }
    if (wantout)
    {
        break;
    }
}
ds_stack_push(stack,i+1);
return obj;
