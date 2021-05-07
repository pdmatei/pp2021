
Interpretor pt calcul lambda
Autor: Matei Popovici


Pentru compilare:

ghc -o <interpreter_name> lambda.hs

Utilizare:

Interpretorul evalueaza folosind evaluarea aplicativa, expresiile introduse la input.
Pentru a construi lambda-expresii, folositi caracterul: λ

Pentru a folosi evaluarea normala, folositi comanda:

Lambda>evalnorm <expresie>

Pentru a inspecta tipul unei expresii, folositi:

Lambda>:t <expresie>

Pentru a urmari secventa de expresii reduse, folositi modul "debug". Pentru a intra in acesta, folositi comanda:

Lambda>debug

Puteti parasi modul de debugging cu comanda:

Lambda-debug>quit

In modul de debugging, puteti folosi: 

Lambda-debug>evalapp <expresie> 

sau 

Lambda-debug>evalnorm <expresie> 

urmat de "Enter", pentru a urmari secventa de reduceri.





