%{
#include <stdio.h>
%}

%x COMMENT

LETRA      [a-zA-Z_]
DIGITO     [0-9]

ID         {LETRA}({LETRA}|{DIGITO})*
ENTERO     {DIGITO}+
HEX        0[xX][0-9a-fA-F]+
FLOTANTE   {DIGITO}+"."{DIGITO}+
CIENTIFICO {DIGITO}+("."{DIGITO}+)?[eE][+-]?{DIGITO}+

%%

"//".*                     { }
"/*"                       { BEGIN(COMMENT); }
<COMMENT>"*/"              { BEGIN(INITIAL); }
<COMMENT>(.|\n)            { }

\"([^\\\n]|(\\.))*\"       { printf("CADENA: %s\n", yytext); }

"=="    { printf("RELACIONAL: %s\n", yytext); }
"!="    { printf("RELACIONAL: %s\n", yytext); }
"<="    { printf("RELACIONAL: %s\n", yytext); }
">="    { printf("RELACIONAL: %s\n", yytext); }
"<"     { printf("RELACIONAL: %s\n", yytext); }
">"     { printf("RELACIONAL: %s\n", yytext); }

"&&"    { printf("LOGICO: %s\n", yytext); }
"||"    { printf("LOGICO: %s\n", yytext); }
"!"     { printf("LOGICO: %s\n", yytext); }

"+"     { printf("ARITMETICO: %s\n", yytext); }
"-"     { printf("ARITMETICO: %s\n", yytext); }
"*"     { printf("ARITMETICO: %s\n", yytext); }
"/"     { printf("ARITMETICO: %s\n", yytext); }

{CIENTIFICO}   { printf("CIENTIFICO: %s\n", yytext); }
{FLOTANTE}     { printf("FLOTANTE: %s\n", yytext); }
{HEX}          { printf("HEX: %s\n", yytext); }
{ENTERO}       { printf("ENTERO: %s\n", yytext); }

{ID}           { printf("IDENTIFICADOR: %s\n", yytext); }

[ \t\r\n]+     { }

.              { printf("ERROR LEXICO: %s\n", yytext); }

%%

int yywrap(){ return 1; }

int main(){
    yylex();
    return 0;
}
