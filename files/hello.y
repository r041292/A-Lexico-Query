%token HI BYE

%%

input:
|         input hi bye
        ;

hi:     
|        HI     { printf("Hello World\n");   }
        ;
bye:    
|        BYE    { printf("Bye World\n");  }
         ;
         
%%
