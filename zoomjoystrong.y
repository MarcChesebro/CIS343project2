%{

#include <stdio.h>
#include "zoomjoystrong.h"

/*******************************************************************************
* Print char* to the error stream
* s: char* containing data to print
* returns: 0 on success
*******************************************************************************/
int yyerror(char* s);

%}

%start program

%union {
	int ival;
	float fval;
}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <ival> INT
%token <fval> FLOAT

%%

program:	stmt_list END END_STATEMENT
		{
			//program has finished so close graphics system
			finish();
			//and exit the program
			exit(0);
		}
		;

stmt_list:	stmt
		|
		stmt stmt_list
		;

stmt:		command END_STATEMENT
		;

command:	LINE INT INT INT INT
		{
			//Test the values to make sure they are within the correct range
			if($2 < 0 || $3 < 0 || $4 < 0 || $5 < 0 || $2 > WIDTH || $4 > WIDTH || $3 > HEIGHT || $5 > HEIGHT){
				//if the data is out of bounds print to the error stream
				yyerror("HEIGHT or WIDTH is out of bounds.");
			}else{
				//if the data is in range call the correct function with the data
				line($2, $3, $4, $5);
			}
		}
		|
		POINT INT INT
		{
			//Test the values to make sure they are within the correct range
			if($2 < 0 || $3 < 0 || $2 > WIDTH || $3 > HEIGHT){
				//if the data is out of bounds print to the error stream
				yyerror("HEIGHT or WIDTH is out of bounds.");
			}else{
				point($2, $3);
			}
		}
		|
		CIRCLE INT INT INT
		{
			//Test the values to make sure they are within the correct range
			if($2 < 0 || $3 < 0 || $2 > WIDTH || $3 > HEIGHT){
				//if the data is out of bounds print to the error stream
				yyerror("HEIGHT or WIDTH is out of bounds.");
			}else{
				circle($2, $3, $4);
			}
		}
		|
		RECTANGLE INT INT INT INT
		{
			//Test the values to make sure they are within the correct range
			if($2 < 0 || $3 < 0 || $2 > WIDTH || $3 > HEIGHT){
				//if the data is out of bounds print to the error stream
				yyerror("HEIGHT or WIDTH is out of bounds.");
			}else{
				rectangle($2, $3, $4, $5);
			}
		}
		|
		SET_COLOR INT INT INT
		{
			//Test the values to make sure they are within the correct range
			if($2 < 0 || $3 < 0 || $4 < 0 || $2 > 255 || $3 > 255 || $4 > 255){
				//if the data is out of bounds print to the error stream
				yyerror("Invalid RGB color value.");
			}else{
				set_color($2, $3, $4);
			}
		}
		;

%%

int main(int argc, char* argv[])
{
	//Start the graphics system
	setup();
	//parse the data
	return(yyparse());
}
/*******************************************************************************
* Print char* to the error stream
* s: char* containing data to print
* returns: 0 on success
*******************************************************************************/
int yyerror(char* s)
{
	//print s to the error stream
	fprintf(stderr, "%s\n", s);
	//retrun success
	return 0;
}
