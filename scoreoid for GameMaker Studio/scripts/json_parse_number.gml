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
Returns:
    [0] = Number                    push'd 3rd
    [1] = New string position       push'd 2nd
    [2] = Error (0 means no error)  push'd 1st
Error:
    1 = unknown character
    3 = end of string
*/
var str,stack,i,error,rtn,curr_char,powerof,temp;
str = string(argument0);
i = real(argument1);
stack = argument2;
json_skip_whitespace(str,i,stack) /*Skip whitespace to be sure*/
i = ds_stack_pop(stack); /*New string position*/
error = ds_stack_pop(stack);
if (error = 1)
{
    ds_stack_push(stack,3);
    ds_stack_push(stack,i);
    ds_stack_push(stack,0);
    return 0;
}
rtn = "";
if (json_char_type(string_char_at(str,i)) != 1)
{
    ds_stack_push(stack,1);
    ds_stack_push(stack,i);
    ds_stack_push(stack,0);
    return 0;
}
powerof = false;
temp = "";
while (1)
{
    curr_char = string_lower(string_char_at(str,i));
    if (json_char_type(curr_char)) != 1 || (i > string_length(str))
    {
        break;
    }
    if (curr_char = "e" && !powerof)
    {
        powerof = true;
        temp = rtn;
        rtn = "";
    }else{
        rtn += curr_char;
    }
    i=i+1
}
if (powerof)
{
    rtn = real(temp) * power(10, real(rtn));
}
ds_stack_push(stack,0);
ds_stack_push(stack,i);
ds_stack_push(stack,real(rtn));
return 0;
