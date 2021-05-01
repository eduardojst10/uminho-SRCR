%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/11 projeto2
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%:- set_prolog_flag(discontiguous_warnings,off).
%:- set_prolog_flag(single_var_warnings,off).
:- set_prolog_flag(w:unknown,fail).
:- set_prolog_flag(answer_write_options,[ quoted(true),portray(true),spacing(next_argument)]). %precisamos desta flag pois existem factos que ultrapassam o numero default de elementos no compilador
:- style_check(-singleton).
:- style_check(-discontiguous).

:- op( 1100, xfy,'::' ).
:- dynamic utente/10.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_Covid/6.
:- dynamic profissoes_risco/1.
:- dynamic fase/2.
:- dynamic '-'/1.


% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma,Fase↝ { 𝕍, 𝔽 }
%profissoes_risco:[Profissão]↝ { 𝕍, 𝔽 }
%fase:#utente,fase ↝ { 𝕍, 𝔽 }







% Sistema de inferência: Resposta -> {V,F}
si( Questao,verdadeiro ) :- Questao.
si( Questao,falso ) :- -Questao.
si(Questao,desconhecido):- nao(Questao), %se conhecimento nao existe então é desconhecido
                        nao(-Questao).
%Predicado que se não for possivel ver que questao é verdadeiro entao é falso
nao(Questao):-
    Questao,!,fail.
nao(Questao).



%%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---------------------------------Pressuposto do mundo fechado--------------------

% Pressuposto do mundo fechado para o predicado utente
-utente(IDU,NSEG,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO):-
                            nao(utente(IDU,NSEG,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO)),
                            nao(excecao(utente(IDU,NSEG,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO))).


% Pressuposto do mundo fechado para o predicado centro_saude
-centro_saude(IDCENTRO,NOME,MOR,TEL,EMAIL):-
                            nao(centro_saude(IDCENTRO,NOME,MOR,TEL,EMAIL)),
                            nao(excecao(centro_saude(IDCENTRO,NOME,MOR,TEL,EMAIL))).

                        
% Pressuposto do mundo fechado para o predicado staff
-staff(IDSTAFF, IDCENTRO, NOME, EMAIL):-
                            nao(staff(IDSTAFF, IDCENTRO, NOME, EMAIL)),
                            nao(excecao(staff(IDSTAFF, IDCENTRO, NOME, EMAIL))).

-vacinacao_Covid(STAFF, UT, DATA, VACINA, TOMA, FASE):-
                            nao(vacinacao_Covid(STAFF, UT, DATA, VACINA, TOMA, FASE)),
                            nao(excecao(vacinacao_Covid(STAFF, UT, DATA, VACINA, TOMA, FASE))).

-fase(IDU,FASE):-
            nao(fase(IDU,FASE))  ,
            nao(excecao(fase(IDU,FASE))).




%%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%--1:Representar casos de conhecimento imperfeito, pela utilização de valores nulos de todos os tipos estudados

%%--------------------------------- - - - - - - - - - -  -  -  -  -   -UTENTE
% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}


%Conhecimento Perfeito Positivo

utente(1,'1234',eduardo,10/1/1999,'eduardo@mail.com','93436278',fafe,estudante,[asma,diabetes],1).%FASE2
utente(2,'2341',monteiro,07/5/1999,'mach@mail.com','93566278',porto,taxista,[],3).%FASE4
utente(3,'3412',torgal,01/9/1989,'dsaw@mail.com','93436988',guimaraes,medico,[],2).%FASE4
utente(4,'4123',mariana,19/3/1979,'ds@mail.com','91236278',braga,tenista,[asma,hipertensao],1).%FASE2
utente(5,'1124',ze,10/2/1972,'opisa@mail.com','91244012',chaves,camionista,[bronquite],3).%FASE2

utente(6,'1134',margarida,08/12/1953,'opisa@mail.com','91244536',lisboa,policia,[asma],3).%FASE 1
utente(7,'1572',daniela,15/03/1970,'opisa@mail.com','91243671',felgueiras,medica,[hipertensao],3). %FASE2
utente(8,'1002',martim,24/1/1978,'opisa@mail.com','91240116',chaves,enfermeiro,[],3).%FASE 3

utente(9,'2564',roberta,11/12/1973,'opisa@mail.com','91244536',lisboa,medica,[asma],3).%FASE 2
utente(10,'7072',david,13/03/1960,'opisa@mail.com','91243671',felgueiras,enfermeiro,[hipertensao],3).%FASE2
utente(11,'4102',manuel,20/01/1948,'opisa@mail.com','91240116',chaves,policia,[],3).%FASE1

%Conhecimento Perfeito Negativo
-utente(12,'4444',rui,10/10/1993,'ruimanuel@email.com','912789234',fafe,bombeiro,[],4).
-utente(13,'4044',eva,03/7/1953,'evacoates@email.com','912509234',viseu,deputada,[],1).


%---------------------Conhecimento Imperfeito Incerto----------------------------
%Não se sabe a idade do David pois a data é desconhecida:
utente(14,'3301',david,data_desconhecida,'davifutsal@hotmail.com','931114678',felgueiras,[asma],4).
excecao(utente(IDU,NSEG,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO)):-utente(IDU,NSEG,NOME,data_desconhecida,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO).



%---------------------Conhecimento Imperfeito Impreciso----------------------------
%Não se sabe se a Renata mora em Felgueiras ou no Porto
excecao(utente(15,'1201',renata,24/01/1990,'rtass@hotmail.com','931314678',felgueiras,[asma],4)).
excecao(utente(15,'1201',renata,24/01/1990,'rtass@hotmail.com','931314678',porto,[asma],4)).



%---------------------Conhecimento Imperfeito Interdito----------------------------
% Não se sabe nem é possível saber o Nº de Segurança Social do Tomás.
utente(16,desconhecido,tomas,30/6/1995,'ttscp@mail.com','942114678',felgueiras,[asma],4).
nulo(desconhecido).
excecao(utente(IDU,NSEG,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO)):-utente(IDU,desconhecido,NOME,DNASC,EMAIL,TEL,MOR,PROF,DOEN,IDCENTRO).



%%--------------------------------- - - - - - - - - - -  -  -  -  -   -CENTRO_SAUDE
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}

%Conhecimento Perfeito Positivo
centro_saude(1,'Alto_Ave',povoa,'234145167','alto@mail.com').
centro_saude(2,'Centro saude',fafe,'254458167','saude@mail.com').
centro_saude(3,'Chaves Centro',chaves,'234145006','ch@mail.com').
centro_saude(4,'Centro_L',lisboa,'254171267','za@mail.com').
centro_saude(5,'Riba Centro',lisboa,'250878167','riza@mail.com').

%Conhecimento Perfeito Negativo
-centro_saude(6,'Clipovoa',povoa,'253498167','povoa@mail.com').

%---------------------Conhecimento Imperfeito Incerto----------------------------
%Não se sabe a cidade da morada do centro de Riba Sul pois esta é desconhecida:
centro_saude(7,'Riba Sul',morada_desconhecida,'250878142','rsul@mail.com').
excecao(centro_saude(IDCENTRO,NOME,MOR,TEL,EMAIL)):-centro_saude(IDCENTRO,NOME,morada_desconhecida,TEL,EMAIL).

%---------------------Conhecimento Imperfeito Impreciso----------------------------
%Não se sabe se o Centro_Saude está localizado em Setubal ou em Lisboa
excecao(centro_saude(8,'Moreira Centro',setubal,'250878200','mmor@mail.com')).
excecao(centro_saude(8,'Moreira Centro',lisboa,'250878200','mmor@mail.com')).

%---------------------Conhecimento Imperfeito Interdito----------------------------
% Não se sabe nem é possível saber o Nº de telefone de MediBeja.
centro_saude(9,'MediBeja',beja,desconhecido,'medi@mail.com').
nulo(desconhecido).
excecao(centro_saude(IDCENTRO,NOME,MOR,TEL,EMAIL)):-centro_saude(IDCENTRO,NOME,MOR,desconhecido,EMAIL).


%%--------------------------------- - - - - - - - - - -  -  -  -  -   -STAFF
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }

%Conhecimento Perfeito Positivo
staff(1,1,rita,'rti@mail.com').
staff(2,1,gilberto,'gilberto@mail.com').
staff(3,1,monica,'saledge@mail.com').
staff(1,2,joao,'juanito@mail.com').
staff(2,2,andreia,'zeca@mail.com').
staff(3,2,belo,'li4@mail.com').
staff(1,3,rui,'salmon@mail.com').
staff(2,3,ze,'salmonze@mail.com').
staff(3,3,ana,'cena@mail.com').
staff(1,4,guilherme,'ti@mail.com').
staff(2,4,carolina,'carol@mail.com').

%Conhecimento Perfeito Negativo
-staff(2,4,ramiro,'ramen@mail.com').
-staff(3,4,valentina,'tina@mail.com').

%---------------------Conhecimento Imperfeito Incerto----------------------------
%Não se sabe a cidade da morada do centro de Riba Sul pois esta é desconhecida:
staff(4,idcentro_desconhecido,antonio,'tone@mail.com').
excecao(staff(IDSTAFF, IDCENTRO, NOME, EMAIL)):-staff(IDSTAFF, idcentro_desconhecido, NOME, EMAIL).

%---------------------Conhecimento Imperfeito Impreciso----------------------------
%Não se sabe se que email pertence realmente a Vicente
excecao(staff(4,2,vicente,'bibaofir@mail.com')).
excecao(staff(4,2,vicente,'forte@mail.com')).

%---------------------Conhecimento Imperfeito Interdito----------------------------
% Não se sabe nem é possível saber o email de Pedro.
staff(4,3,pedro,desconhecido).
nulo(desconhecido).
excecao(staff(IDSTAFF, IDCENTRO, NOME, EMAIL)):-staff(IDSTAFF, IDCENTRO, NOME, desconhecido).


%%--------------------------------- - - - - - - - - - -  -  -  -  -   -VACINACAO_COVID
%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma, Fase↝ { 𝕍, 𝔽 } 

%Conhecimento Perfeito Positivo
vacinacao_Covid(5,6,14/02/21,pfeizer,1,1).
vacinacao_Covid(5,6,21/04/21,pfeizer,2,1).
vacinacao_Covid(1,11,01/03/21,pfeizer,1,1).
vacinacao_Covid(1,11,01/04/21,pfeizer,2,1).
vacinacao_Covid(3,1,21/03/21,pfeizer,1,2).
vacinacao_Covid(3,4,21/03/21,pfeizer,1,2).
vacinacao_Covid(3,4,21/04/21,pfeizer,2,2).


%Conhecimento Perfeito Negativo
-vacinacao_Covid(3,5,21/04/21,pfeizer,1,2).
-vacinacao_Covid(3,5,21/06/21,pfeizer,2,2).


%---------------------Conhecimento Imperfeito Incerto----------------------------
%Não se sabe a cidade da morada do centro de Riba Sul pois esta é desconhecida:
vacinacao_Covid(2,10,24/05/21,vacina_desconhecida,1,2).
excecao(vacinacao_Covid(STAFF, UT, DATA, VACINA, TOMA, FASE)):-vacinacao_Covid(STAFF, UT, DATA, vacina_desconhecida, TOMA, FASE).

%---------------------Conhecimento Imperfeito Impreciso----------------------------
%Não se sabe se que vacina realmente tomou o utente numero 10
vacinacao_Covid(2,9,24/05/21,pfizer,1,2).
vacinacao_Covid(2,9,24/05/21,astrazeneca,1,2).

%---------------------Conhecimento Imperfeito Interdito----------------------------
% Não se sabe nem é possível saber o email de Pedro.
vacinacao_Covid(3,4,30/06/21,deconhecida,1,2).
nulo(desconhecida).
excecao(vacinacao_Covid(STAFF, UT, DATA, VACINA, TOMA, FASE)):-vacinacao_Covid(STAFF, UT, DATA, desconhecida, TOMA, FASE).




%%--------------------------------- - - - - - - - - - -  -  -  -  -   -FASE
%fase:#utente,fase ↝ { 𝕍, 𝔽 }

%Conhecimento Perfeito Positivo
fase(6,1).
fase(11,1).
fase(1,2).
fase(4,2).
fase(5,2).
fase(7,2).
fase(9,2).
fase(10,2). 
fase(8,3).
fase(2,4).
fase(3,4).

%Conhecimento Perfeito Negativo
-fase(11,2).

%---------------------Conhecimento Imperfeito Incerto----------------------------
%Não se sabe a fase em que o utente 11 está:
fase(11,fase_desconhecida).
excecao(fase(IDU,FASE)):-fase(IDU,desconhecida).


%---------------------Conhecimento Imperfeito Impreciso----------------------------
%Não se sabe em que fase está realmente o utente numero 11
fase(12,3).
fase(12,4).



%---------------------Conhecimento Imperfeito Interdito----------------------------
% Não se sabe nem é possível saber o email de Pedro.
fase(13,desconhecida).
nulo(desconhecida).
excecao(fase(IDU,FASE)):-fase(IDU,desconhecida).




%%--------------------------------- - - - - - - - - - -  -  -  -  -   -PROFISSOES_RISCO - CONHECIMENTO FIXO
%profissoes_risco:[Profissão]↝ { 𝕍, 𝔽 }
profissoes_risco([medico,medica,enfermeiro,enfermeira,auxiliar_limpeza,auxiliar_lar,professor,auxiliar_escola,policia]).






%------------------------------- Funçoes Auxiliares -----------------

%Perdicado pertence em forma de funcao pertence -> {V,F}
pertence(X,[X|T]).
pertence(X,[H|T]):-pertence(X,T).

%Predicado que faz concat de T e Lista 
concatenar([],L,L).
concatenar(L,[],L).
concatenar([H | T], L, [H | R]) :- concatenar(T,L,R).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado que permite a evolucao do conhecimento

% Evolução - insercao de novo Termo
evolucao(Termo):- findall(Invariante,+Termo::Invariante,Lista),
    insercao(Termo),teste(Lista).


insercao(Termo):- assert(Termo).
insercao(Termo):- retract(Termo), !, fail. %cut operator para 

%Involucao - remocao de Termo

involucao(Termo):- findall(Invariante,-Termo::Invariante,Lista),
    remocao(Termo),
    teste(Lista).

remocao(Termo):-retract(Termo).
remocao(Termo):-retract(Termo), !,fail.

