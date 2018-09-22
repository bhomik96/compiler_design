%{
#include<stdio.h>
#include<string.h>

  int ids = 0;
  int assign=0;
  int intconstant = 0; 
  char str[200];
  int i=0,flag=1,length=0;
  void S();
  void E();
  void T();
  void Eprime();
  void Tprime();
  void F();
  void K();
%}
flag=0;
%%
"\n" {	//printf("hi");
		S();
		if(i==length && flag==1)
		printf("%s\t Input Accepted\n",str);
		else
		printf("%s\t Input Rejected\n",str);
		i=0;
		length=0;
		flag=1;
		strcpy(str,"");
	}
	
[a-zA-Z]+[_a-zA-Z0-9]* {strcat(str,"id");ids++;length+=2;}
[+*/^=()-]+ {strcat(str,(&*yytext));assign++;length+=1;}
[0-9]+ {strcat(str,"id");intconstant++;length+=2;}
.
%%
void S(){
	if(str[i]=='i'){
		i++;
		if(str[i]=='d'){
			i++;
			if(str[i]=='='){
				i++;
				E();
			}
			else flag=0;
		}
		else flag=0;
	}
	else flag=0;
}

void E(){
	T();
	Eprime();
}
void T(){
	F();
	Tprime();
}

void Eprime(){
	if(str[i]=='+' || str[i]=='-'){
		i++;
		T();
		Eprime();
	}
}
void F(){
	K();
	if(str[i]=='^'){
		i++;
		F();
	}
}
void K(){	
	if(str[i]=='('){
		i++;
		E();
		if(str[i]==')'){
			i++;
		}
		else flag=0;
	}
	else if(str[i]=='i'){
		i++;
		if(str[i]=='d'){
				i++;
		}
		else flag=0;
	}
	else{
	   flag=0;
	}	
}

void Tprime(){
	if(str[i]=='*' || str[i]=='/'){
		i++;
		F();
		Tprime();
	}
}

	
	
 /*  S → id = E
	E→ TE'
	E' → +TE' | -TE' | ϵ
	T→ FT' 
	T'→ *FT' | ÷FT' |ϵ
	F → K ^ F | K
	K → (E) | id 
 */

int main(int argc, char *argv[]){
 	if (argc != 2) {
		 printf("Input Usage: <exefile> <inputfile>\nTry Again\n");    
		 exit(0);
	}
	yyin = fopen(argv[1], "r");
	yylex(); 
  //printf("statements = %d ids = %d assign = %d  integers = %d \n",statements,ids,assign,intconstant);
  //printf("%s\n",str);
}

