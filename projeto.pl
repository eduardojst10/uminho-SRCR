  
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/11
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- style_check(-singleton).


:- op( 900, xfy,'::' ).
:- dynamic utente/10.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_Covid/5.


% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}

%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}

%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }

%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }


%----------------------------- BASE DE CONHECIMENTO ------------------------

utente(1,1234,'Eduardo Teixeira',1999,'eduardo@mail.com',93436278,'Fafe','Estudante',[Asma,Diabetes],1).
utente(2,2341,'Machão Monteiro',1994,'mach@mail.com',93566278,'Porto','Pimp',[Cancro],3).
utente(3,3412,'João Torgal',1989,'dsaw@mail.com',93436988,'Guimarães','Fazendeiro',[Bronquite],2).
utente(4,4123,'Mariana Tea',1979,'ds@mail.com',91236278,'Braga','Tenista',[Asma,Hipertensao],1).
utente(5,1122,'Ze tolo',1972,'opisa@mail.com',91244012,'Chaves','Camionista',[Diabetes],3).
utente(6,1122,'Margarida F.',1994,'opisa@mail.com',91244536,'Lisboa','Policia',[Asma],3).
utente(7,1122,'Daniela',1982,'opisa@mail.com',91243671,'Felgueiras','Medica',[Hipertensao],3).
utente(8,1122,'Martim',1978,'opisa@mail.com',91240116,'Chaves','Atleta',[],3).

centro_saude(1,'Alto_Ave',Povoa,234145167,'alto@mail.com').
centro_saude(2,'Chaves_meuputo',Chaves,234145006,'ch@mail.com').
centro_saude(3,'Bzaina',Portalegre,254178167,'bza@mail.com').

staff(1,1,'Rita','rti@mail.com').
staff(2,1,'Juan','juanito@mail.com').
staff(3,1,'Ramon','salmon@mail.com').
staff(4,1,'Rui','ti@mail.com').
staff(1,2,'Gili','gilberto@mail.com').
staff(2,2,'ZecaAfonso','zeca@mail.com').
staff(1,3,'Moura','çaledge@mail.com').
staff(2,3,'Belo','li4@mail.com').
staff(3,3,'Ana','charrada@mail.com').

vacinacao_Covid(1,4,'01/03/21','pfeizer',1).
vacinacao_Covid(3,3,'01/03/21','pfeizer',1).
vacinacao_Covid(4,2,'21/03/21','pfeizer',2).
vacinacao_Covid(2,1,'14/02/21','outra',1).
vacinacao_Covid(5,2,'14/02/21','outra',0).
vacinacao_Covid(2,2,'14/02/21','outra',0).
vacinacao_Covid(2,7,'15/02/21','pfizer',0).





%%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%------------------------------- Invariantes -----------------

% Extensão do Predicado comprimento: ListaElem, Comp -> {V,F}
comprimento([],0).
comprimento([X|L], C) :- comprimento(L, N), C is N+1.

%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de utente-NAO ESTA BEM

+utente(IDU,_,_,_,_,_,_,_,_,_) :: (findall( (IDU), utente(IDU,_,_,_,_,_,_,_,_,_),S),
               	comprimento(S,N), N == 1).

%-utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (findall( (IDU,_,_,_,_,_,_,_,_,IDCENTRO), (utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO)),S),
%               	comprimento(S,N),
%                N ==1).
%
%
%
%%Invariante Esttrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de centro_saúde - Verificar se está bem
%+centro_saude(IDU,IDCENTRO,_,_,_) :: (findall( (IDU,IDCENTRO), (centro_saúde(IDU,IDCENTRO,_,_,_)),S),
%               	comprimento(S,N),
%                N == 1).
%
%-centro_saude(IDU,_,_,_,_) :: (findall( (IDU), (centro_saúde(IDU,_,_,_,_)),S),
%               	comprimento(S,N),
%                N ==1).
%
%
%%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de staff - Verificar se está bem
%+staff(IDU,IDCENTRO,_,_) :: (findall( (IDU,IDCENTRO,_,_), (staff(IDU,IDCENTRO,_,_)),S),
%               	comprimento(S,N),
%                N ==1).
%
%-staff(IDU,IDCENTRO,_,_) :: (findall( (IDU,IDCENTRO,_,_), (staff(IDU,IDCENTRO,_,_)),S),
%               	comprimento(S,N),
%                N ==1).
%
%%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de vacinacao_Covid, nao pode existir mais do que duas tomas - Verificar se está bem
%+vacinacao_Covid(ID,SAFF,_,_,_) :: (findall((ID,STAFF), (vacinacao_Covid(ID,STAFF,_,_,_)),S),
%                    comprimento(S,N),
%                N =< 2).
%
%-vacinacao_Covid(ID,SAFF,_,_,_) :: (findall((ID,STAFF), (vacinacao_Covid(ID,STAFF,_,_,_)),S),
%                    comprimento(S,N),
%                    N =< 2).
%


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



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}

%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}

%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }

%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }

%---------------------------QUERIES-----------------------------------
%--------------------------<1>-------------------------------------

%Registar Utente
regista_utente(I,S,N,DA,M,T,O,P,D,C):- evolucao(utente(I,S,N,DA,M,T,O,P,D,C)).

%Prioridade de vacinação consoante o tamanho da lista de doencas crónicas
vacinar_utente(ST,UT,DATA,VAC,T):-evolucao(vacinacao_Covid(ST,UT,DATA,VAC,T)).

%--------------------------<2>-------------------------------------

%--------------------------<3>-------------------------------------


%--------------------------<4>-------------------------------------

%--------------------------<5>-------------------------------------

%--------------------------<6>-------------------------------------

%--------------------------<7>-------------------------------------








%------------------------------- Funçoes Auxiliares -----------------
%Perdicado pertence em forma de funcao elem -> {V,F}
elem(X,[H | T]):- X==H.
elem(X,[H | T]):- X\=H,
            elem(X,T).

teste([]).
teste([R|Lr]):- R, teste(Lr).