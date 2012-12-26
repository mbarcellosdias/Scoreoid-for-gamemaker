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
    [0] = String                    push'd 3rd
    [1] = New string position       push'd 2nd
    [2] = Error (0 means no error)  push'd 1st
Error:
    2 = Unknown character
    3 = End of string
*/
var str,stack,i,error,rtn_str,escape_mode,curr_char;
str = argument0;
i = real(argument1);
stack = argument2;
json_skip_whitespace(str,i,stack) /*Skip whitespace to be sure*/
i = ds_stack_pop(stack); /*New string position*/
error = ds_stack_pop(stack);
if (error = 1)
{
    ds_stack_push(stack,3);
    ds_stack_push(stack,i);
    ds_stack_push(stack,"");
    return 0;
}
rtn_str = "";
escape_mode = false;
if (string_char_at(str,i) != '"')
{
    ds_stack_push(stack,2);
    ds_stack_push(stack,i);
    ds_stack_push(stack,"");
    return 0;
}
i+=1; /*Increment past the quotation mark*/
while (1)
{
    if (i > string_length(str))
    {
        ds_stack_push(stack,3); /*Unexpected end of string*/
        ds_stack_push(stack,i);
        ds_stack_push(stack,"");
        return 0;
    }
    curr_char = string_char_at(str,i);
    if (curr_char = '"' && !escape_mode) /*Check for quotation mark*/
    {
        /*Finished parsing*/
        ds_stack_push(stack,0);
        ds_stack_push(stack,i+1); /*Add one to go past the quotation mark*/
        ds_stack_push(stack,rtn_str);
        return 0;
    }
    if (escape_mode) /*Unescape if in escape mode*/
    {
        switch curr_char
        {
        case '"':
            rtn_str += '"';
            break;
        case "\":
            rtn_str += "\";
            break;
        case "b":
            rtn_str += chr(8);
            break;
        case "t":
            rtn_str += chr(9);
            break;
        case "n":
            rtn_str += chr(10);
            break;
        case "f":
            rtn_str += chr(12);
            break;
        case "r":
            rtn_str += chr(13);
            break;
        default:
            rtn_str += "\"+curr_char;
            break;
        }
        escape_mode = false; /*Not in escape mode any more*/
    }else{
    /*Otherwise, process as normal*/
        switch curr_char
        {
        case "\":
            escape_mode = true;
            break;
        default:
            rtn_str += curr_char;
        }
    }
    i+=1;
}
