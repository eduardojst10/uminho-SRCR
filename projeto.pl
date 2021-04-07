  
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/11 projeto
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%:- set_prolog_flag(discontiguous_warnings,off).
%:- set_prolog_flag(single_var_warnings,off).
:- set_prolog_flag(w:unknown,fail).
:- style_check(-singleton).
:- style_check(-discontiguous).

%:- style_check(-singleton).


:- op( 900, xfy,'::' ).
:- dynamic utente/10.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_Covid/5.
:- dynamic profissoes_risco/1.


% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }


%----------------------------- BASE DE CONHECIMENTO ------------------------

% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
utente(1,'1234',eduardo,10/1/1999,'eduardo@mail.com','93436278',fafe,estudante,[asma,diabetes],1).
utente(2,'2341',monteiro,07/5/1999,'mach@mail.com','93566278',porto,taxista,[cancro],3).
utente(3,'3412',torgal,01/9/1989,'dsaw@mail.com','93436988',guimaraes,fazendeiro,[bronquite],2).
utente(4,'4123',mariana,19/3/1979,'ds@mail.com','91236278',braga,tenista,[asma,hipertensao],1).
utente(5,'1124',ze,10/2/1972,'opisa@mail.com','91244012',chaves,camionista,[diabetes],3).
utente(6,'1134',margarida,08/12/1994,'opisa@mail.com','91244536',lisboa,policia,[asma],3).
utente(7,'1572',daniela,15/03/1982,'opisa@mail.com','91243671',felgueiras,medica,[hipertensao],3).
utente(8,'1002',martim,24/1/1978,'opisa@mail.com','91240116',chaves,atleta,[],3).

%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
centro_saude(1,'Alto_Ave',povoa,'234145167','alto@mail.com').
centro_saude(2,'Chaves',chaves,'234145006','ch@mail.com').
centro_saude(3,'Bzaina',portalegre,'254178167','bza@mail.com').

%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
staff(1,1,'Rita','rti@mail.com').
staff(2,1,'Juan','juanito@mail.com').
staff(3,1,'Ramon','salmon@mail.com').
staff(4,1,'Rui','ti@mail.com').
staff(1,2,'Gili','gilberto@mail.com').
staff(2,2,'ZecaAfonso','zeca@mail.com').
staff(1,3,'Moura','çaledge@mail.com').
staff(2,3,'Belo','li4@mail.com').
staff(3,3,'Ana','charrada@mail.com').


%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }
%vacinacao_Covid(5,8,'14/02/21','outra',0).
%vacinacao_Covid(2,6,'14/02/21','outra',0).
%vacinacao_Covid(2,7,'15/02/21','pfizer',0).
vacinacao_Covid(1,4,'01/03/21','pfeizer',1).
vacinacao_Covid(3,3,'01/03/21','pfeizer',1).
vacinacao_Covid(3,2,'21/03/21','pfeizer',1).
vacinacao_Covid(2,1,'14/02/21','outra',1).
vacinacao_Covid(3,2,'21/03/21','pfeizer',2).
vacinacao_Covid(5,5,'21/03/21','pfeizer',2).

%profissoes_risco:[Profissão]↝ { 𝕍, 𝔽 }
profissoes_risco([medico,enfermeiro,auxiliar_limpeza,auxiliar_lar,professor,auxiliar_escola,policia]).




%%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%------------------------------- Invariantes Estruturais -----------------






%%--------------------------------- - - - - - - - - - -  -  -  -  -   - UTENTE
%Invariante Estrutural: para nao permitir inserção de ocorrências de conhecimento repetido a nivel de utente
+utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (findall( (IDU,IDCENTRO), utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO),S),
               	comprimento(S,N), N == 1).

%Invariante Referencial: Não remover utente que nao esteja na Base de Conhecimento
-utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (findall( (IDU,_,_,_,_,_,_,_,_,IDCENTRO), (utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO)),S),
               	comprimento(S,N),
                N ==0).

-utente( Id,_,_,_ ) :: (
				  findall( (Id),(consulta(_,_,Id,_,_)),S ),
                  comprimento( S,N ),
				  N == 0).


%ID sao inteiros
+utente(Id,_,_,_) :: (
	integer(Id)
).

+utente(_,_,Id,_) :: (
	integer(Id)
).

%%--------------------------------- - - - - - - - - - -  -  -  -  -   -CENTRO_SAUDE


%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de centro_saúde - Verificar se está bem
+centro_saude(ID,_,_,_,_) :: (findall( (ID), (centro_saude(ID,_,_,_,_)),S),
               	comprimento(S,N),
                N == 1).

%Invariante Referencial: Não remover centro_Saude que nao esteja na Base de Conhecimento
-centro_saude(IDU,_,_,_,_) :: (findall( (IDU), (centro_saúde(IDU,_,_,_,_)),S),
               	comprimento(S,N),
                N ==0).



%%--------------------------------- - - - - - - - - - -  -  -  -  -   -STAFF

%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de staff 
+staff(IDS,IDCENTRO,_,_) :: (findall( (IDS,IDCENTRO,_,_), (staff(IDS,IDCENTRO,_,_)),S),
               	comprimento(S,N),
                N ==1).
%Invariante Referencial: Não remover staff que nao esteja na Base de Conhecimento
-staff(IDU,IDCENTRO,_,_) :: (findall( (IDU,IDCENTRO,_,_), (staff(IDU,IDCENTRO,_,_)),S),
               	comprimento(S,N),
                N ==0).



%%--------------------------------- - - - - - - - - - -  -  -  -  -   -VACINACAO_COVID
%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de vacinacao_Covid, nao pode existir vacinanoes repetidas
+vacinacao_Covid(ID,STAFF,_,_,T) :: (findall((ID,STAFF), (vacinacao_Covid(ID,STAFF,_,_,T)),S),
                    comprimento(S,N),
                N == 1).
%
%-vacinacao_Covid(ID,SAFF,_,_,_) :: (findall((ID,STAFF), (vacinacao_Covid(ID,STAFF,_,_,_)),S),
%                    comprimento(S,N),
%                    N =< 2).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}

%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}

%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }

%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }




%---------------------------QUERIES-----------------------------------
%--------------------------<1>-------------------------------------

%definir predicados para as diferentes fases de vacinacao

%Pertence à 1ª Fase? 
%%Utente pertence à 1ª fase de vacinacao se a sua idade for maior ou igual a 65.

registaUtenteFase1(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):-verificaIdade(X/Y/Z),
                                                                    evolucao(utente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro)).


verificaIdade(X/Y/Z):- A is 2021-Z,
                A >= 65.
                                
                                    
%Pertence à 2ª Fase?
%Utente pertence à 2ª fase de vacinacao se possuir doenças crónicas
registaUtenteFase2(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro):- comprimento(Doenca,N),
                                                                        N>=1,
                                                                        evolucao(utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro)).




%Pertence à 3ª Fase?
%Utente pertence à 3ª fase de vacinacao se possuir uma profissão de risco
registaUtenteFase3(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro):- profissoes_risco(L),
                                                                        pertence(Prof,L),
                                                                        evolucao(utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro)).

%--------------------------<2>-------------------------------------
%Identifica utentes nao vacinados  
identificaUtentesNaoVacinados(L):- findall((ID),utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),U),
                                  utentesIdVacinados(N),
                                  remove(U,N,L).


removeVacinados(U,[],U).
removeVacinados([],N,[]).
removeVacinados(U,[H|T],L):- removeVacinados(U,T,L1), 
                         removeTodasOcorrencias(H,U,L).
                            

removeTodasOcorrencias(X,[],[]).
removeTodasOcorrencias(X,[X|T],L):- removeTodasOcorrencias(X,T,L),!.
removeTodasOcorrencias(X,[H|T],[H|L]):- removeTodasOcorrencias(X,T,L). %adicionar 


%Fazer um agrupa contrário ao de baixo

%--------------------------<3>-------------------------------------
%Identifica utentes vacinados 
identificaUtentesVacinados(L):- utentesIdVacinados(N),
                             agrupaUtentesID(N,L).                               

utentesIdVacinados(L):-findall((IDU),vacinacao_Covid(_,IDU,_,_,1),L1),
                    findall((IDU), vacinacao_Covid(_,IDU,_,_,2),L2),
                    concatenar(L1,L2,X),
                    remove_duplicados(X,L).

%predicado que agrupa os Utentes dado uma lista de IDs
agrupaUtentesID([],[]).
agrupaUtentesID([H|T],[X|Xs]):- agrupaUtentesID(T,Xs),
                                listaUtentes(H,[X]).

%--------------------------<4>-------------------------------------
%Identifica Utentes bem vacinados
%utentes por toma, neste caso a toma vai ser 2

identificaUtentesBemVacinados(L):- 
            findall((IDU), vacinacao_Covid(IDS,IDU,DA,VA,2),LI),
            agrupaUtentesID(LI,L).


%Predicado que lista os utentes por id
listaUtentes(Id,Lista):-findall((Id,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),utente(Id,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),Lista).
%--------------------------<5>-------------------------------------

%--------------------------<6>-------------------------------------

%--------------------------<7>-------------------------------------

%Sistema de Inferência

%si(Questao,verdadeiro):-
%   Questao.
%si(Questao,falso):-
%   -Questao.



%nao(Questao):-
%    Questao,!,fail.
%nao(Questao).



%------------------------------- Funçoes Auxiliares -----------------
%Perdicado pertence em forma de funcao pertence -> {V,F}
pertence(X,[X|T]).
pertence(X,[H|T]):-pertence(X,T).

% testa se todos os predicados são verdadeiros
teste([]).
teste([R|Lr]):- R, teste(Lr).

%Predicado que faz concat de T e Lista para se tornar Xs
concatenar([],L,L).
concatenar(L,[],L).
concatenar([H | T], L, [H | R]) :- concatenar(T,L,R).

%remove elementos duplicados

remove_duplicados(LI,LF):-remove(LI,[],LF).


%Se não pertencer adiciona à cabeça da nossa lista vazia
remove([],L,L).
remove([H|T],L,X):- pertence(H,L),
                  remove(T,L,X).
remove([H|T],L,X):- remove(T,[H|L],X).

% Extensão do Predicado comprimento: ListaElem, Comp -> {V,F}
comprimento([],0).
comprimento([X|L], C) :- comprimento(L, N), C is N+1.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado que permite a evolucao do conhecimento

% Evolução - insercao de novo Termo
evolucao(Termo):- findall(Invariante,+Termo::Invariante,Lista),
    insercao(Termo),teste(Lista).


insercao(Termo):- assert(Termo).
insercao(Termo):- retract(Termo), !, fail. %cut operator para 

%Involucao - remocao de termo

involucao(Termo):- findall(Invariante,-Termo::Invariante,Lista),
    remocao(Termo),
    teste(Lista).

remocao(Termo):-retract(Termo).
remocao(Termo):-retract(Termo), !,fail.


