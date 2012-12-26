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
    Return:
    [0] = New string position       push'd 2nd
    [1] = Error (0 means no error)  push'd 1st
    Error:
    0 = none
    1 = end of string
    2 = unknown character
*/
var str,str_pos,stack,error;
str = argument0;
str_pos = real(argument1);
stack = argument2;
json_skip_whitespace(str,str_pos,stack);
str_pos = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error != 0)
{
    ds_stack_push(stack, error);
    ds_stack_push(stack, str_pos);
    return 0;
}
if (json_char_type(string_char_at(str,str_pos)) != 6)
{
    ds_stack_push(stack, 2);
    ds_stack_push(stack, str_pos);
    return 0;
}
ds_stack_push(stack, 0);
ds_stack_push(stack, str_pos+1);
return 0;
