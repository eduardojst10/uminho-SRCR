  
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/11 projeto
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


%----------------------------- BASE DE CONHECIMENTO ------------------------

% utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
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



%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
centro_saude(1,'Alto_Ave',povoa,'234145167','alto@mail.com').
centro_saude(2,'Centro saude',fafe,'254458167','saude@mail.com').
centro_saude(3,'Chaves Centro',chaves,'234145006','ch@mail.com').
centro_saude(4,'Centro_L',lisboa,'254171267','za@mail.com').
centro_saude(5,'Riba Centro',lisboa,'250878167','riza@mail.com').

%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
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


%vacinacao_Covid: #Staf, #utente, Data, Vacina, Toma, Fase↝ { 𝕍, 𝔽 } 
vacinacao_Covid(5,6,14/02/21,pfeizer,1,1).
vacinacao_Covid(5,6,21/04/21,pfeizer,2,1).
vacinacao_Covid(1,11,01/03/21,pfeizer,1,1).
vacinacao_Covid(1,11,01/04/21,pfeizer,2,1).
vacinacao_Covid(3,1,21/03/21,pfeizer,1,2).
vacinacao_Covid(3,4,21/03/21,pfeizer,1,2).
vacinacao_Covid(3,4,21/04/21,pfeizer,2,2).
vacinacao_Covid(2,7,21/03/21,pfeizer,1,3). %utente vacinado indevidamente para dar exemplo utente 7 pertence a fase 2 e não 3
vacinacao_Covid(2,8,22/03/21,pfeizer,1,2). %utente vacinado indevidamente para dar exemplo utente 8 pertence a fase 3 e não 2
vacinacao_Covid(2,8,22/04/21,pfeizer,2,2). %utente vacinado indevidamente para dar exemplo utente 8 pertence a fase 3 e não 2

%profissoes_risco:[Profissão]↝ { 𝕍, 𝔽 }
profissoes_risco([medico,medica,enfermeiro,enfermeira,auxiliar_limpeza,auxiliar_lar,professor,auxiliar_escola,policia]).

%fase:#utente,fase ↝ { 𝕍, 𝔽 }
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


%------------------------------- Invariantes Estruturais ------------------------------

%%--------------------------------- - - - - - - - - - -  -  -  -  -   - UTENTE
%Invariante Estrutural: para nao permitir inserção de ocorrências de conhecimento repetido a nivel de utente
+utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (findall( (IDU,IDCENTRO), utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO),S),
               	comprimento(S,N), N == 1).

%Invariante Estrutural: Não remover utente que nao esteja na Base de Conhecimento
-utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (findall( (IDU,IDCENTRO), (utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO)),S),
               	comprimento(S,N),
                N ==0).

%Invariante Referencial - ID sao inteiros
+utente(IDU,_,_,_,_,_,_,_,_,IDCENTRO) :: (
	integer(IDU),
    integer(IDCENTRO)
).


%%--------------------------------- - - - - - - - - - -  -  -  -  -   -CENTRO_SAUDE


%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de centro_saúde 
+centro_saude(IDCENTRO,_,_,_,_) :: (findall( (IDCENTRO), (centro_saude(IDCENTRO,_,_,_,_)),S),
               	comprimento(S,N),
                N == 1).

%Invariante Estrutural: Não remover centro_Saude que nao esteja na Base de Conhecimento
-centro_saude(IDCENTRO,_,_,_,_) :: (findall( (IDCENTRO), (centro_saude(IDCENTRO,_,_,_,_)),S),
               	comprimento(S,N),
                N ==0).
%Invariante Referencial - ID inteiro
+centro_saude(IDCENTRO,_,_,_,_) :: (
    integer(IDCENTRO)
).

%%--------------------------------- - - - - - - - - - -  -  -  -  -   -STAFF

%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de staff 
+staff(IDS,IDCENTRO,_,_) :: (findall( (IDS,IDCENTRO), (staff(IDS,IDCENTRO,_,_)),S),
               	comprimento(S,N),
                N ==1).
%Invariante Estrutural: Não remover staff que nao esteja na Base de Conhecimento
-staff(IDS,IDCENTRO,_,_) :: (findall( (IDS,IDCENTRO), (staff(IDS,IDCENTRO,_,_)),S),
               	comprimento(S,N),
                N ==0).

%Invariante Referencial - IDs sao inteiros
+staff(IDS,IDCENTRO,_,_) :: (
	integer(IDS),
    integer(IDCENTRO)
).

%%--------------------------------- - - - - - - - - - -  -  -  -  -   -VACINACAO_COVID
%Invariante Estrutural: para permitir inserção de ocorrências de conhecimento repetido a nivel de vacinacao_Covid
+vacinacao_Covid(ID,IDSTAFF,_,_,T,F) :: (findall( (ID,IDSTAFF,T,F), (vacinacao_Covid(ID,IDSTAFF,_,_,T,F)),S),
                    comprimento(S,N),
                N == 1).
%Invariante Estrutural: Não remover vacinacao que nao esteja na Base de Conhecimento
-vacinacao_Covid(ID,IDSTAFF,_,_,T,F) :: (findall( (ID,IDSTAFF,T,F), (vacinacao_Covid(ID,IDSTAFF,_,_,T,F)),S),
                    comprimento(S,N),
                    N == 0).

%Invariante Referencial
+vacinacao_Covid(_,_,_,_,T,_) :: (
    T=1; %operador de disjuncao -> ;
    T=2
).
%%--------------------------------- - - - - - - - - - -  -  -  -  -   -FASE


%Invariante Estrutural: para permitir insercao de ocorrências de conhecimento repetido a nível de fase
+fase(IDU,FASE) :: (findall( (IDU,FASE), (fase(IDU,FASE)),S),
               	comprimento(S,N),
                N ==1).

%Invariante Referencial - IDs sao inteiros
+fase(IDU,IDF) :: (
	integer(IDU),
    IDF = 1;
    IDF=2;
    IDF=3;
    IDF=4
).

%---------------------------QUERIES-----------------------------------

%--------------------------<1>--------------------------------------------------------------------------------

%Definir predicados para as diferentes fases de vacinacao

%Pertence à 1ª Fase? 
%%Utente pertence à 1ª fase de vacinacao se a sua idade for maior ou igual a 65.


registaUtente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):- registaUtenteFase1(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro),
                                                                    !.
registaUtente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):- registaUtenteFase2(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro),
                                                                    !.
registaUtente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):- registaUtenteFase3(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro),
                                                                    !.
registaUtente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):- registaUtenteFase4(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro),
                                                                    !.                                                                   




registaUtenteFase1(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro):-verificaIdade(X/Y/Z),
                                                                    evolucao(utente(ID,Seg,Nome,X/Y/Z,Email,Tel,Mor,Prof,Doenca,IDCentro)),
                                                                    evolucao(fase(ID,1)),
                                                                    write('Utente registado em Fase1').


verificaIdade(X/Y/Z):- A is 2021-Z,
                A >= 65.
                                
                                    
%Pertence à 2ª Fase?
%Utente pertence à 2ª fase de vacinacao se possuir doenças crónicas
registaUtenteFase2(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro):- comprimento(Doenca,N),
                                                                        N>=1,
                                                                        evolucao(utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro)),
                                                                        evolucao(fase(ID,2)),
                                                                        write('Utente registado em Fase2').



%Pertence à 3ª Fase?
%Utente pertence à 3ª fase de vacinacao se possuir uma profissão de risco
registaUtenteFase3(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro):- profissoes_risco(L),
                                                                        pertence(Prof,L),
                                                                        evolucao(utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro)),
                                                                        evolucao(fase(ID,3)),
                                                                        write('Utente registado em Fase3').

%Pertence à 4ª Fase?
%Utente pertence à 4ª fase de vacinacao se não pertencer a nenhuma das acima
registaUtenteFase4(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro):- evolucao(utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro)),
                                                                        evolucao(fase(ID,4)),
                                                                        write('Utente registado em Fase4').

%Registar Staff
registaStaff(IDS,IDC,Nome,Email):- evolucao(staff(IDS,IDC,Nome,Email)),
                               write('Staff Registado').
%Registar Centro_saude
registaCentro(IDC,Nome,Morada,Telefone,Email):-evolucao(centro_saude(IDC,Nome,Morada,Telefone,Email)),
                                            write('Centro de Saude Registado').


%Registar Vacinacao_Covid
registaVac(ID,IDSTAFF,_,_,T,F):-evolucao(vacinacao_Covid(ID,IDSTAFF,_,_,T,F)),
                                    write('Vacinacao_Covid Registada').

%--------------------------<2>------------------------------------------------------------------------------
%Identifica utentes nao vacinados  
identificaUtentesNaoVacinados(L):- findall((ID),utente(ID,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),U),
                                  utentesIdVacinados(N),
                                  eliminarComuns(N,U,X),
                                  agrupaUtentesID(X,L).

%predicado que agrupa os Utentes dado uma lista de IDs
agrupaUtentesID([],[]).
agrupaUtentesID([H|T],[X|Xs]):- agrupaUtentesID(T,Xs),
                                listaUtentes(H,[X]).
                           
%--------------------------<3>----------------------------------------------------------------------------------
%Identifica utentes vacinados Sem ser por ordem
%Utentes que foram vacinados pelo menos uma vez
identificaUtentesVacinados(L):- utentesIdVacinados(N),
                             agrupaUtentesID(N,L).                               

utentesIdVacinados(L):-findall((IDU),vacinacao_Covid(_,IDU,_,_,1,_),L).



%--------------------------<4>-------------------------------------------------------------------------------------
%Identificar Utentes vacinados indevidamente
%Utentes que foram vacinados na fase errada a que pertencem
identificaUtentesIndevidoVac(L):-findall((IDU,FASE) ,vacinacao_Covid(_,IDU,_,_,_,FASE),L1), 
                                remove_duplicados(L1,X),%Par com idutente e fase
                                listaFases(L2),%elementos a retirar
                                eliminarComuns(L2,X,I), %I lista de pares (id,fase) indevidos
                                listFaseToListId(I,IDs),
                                agrupaUtentesID(IDs,L). %transformar pares em lista de id para dps passar para lista de utentes



%Predicado que lista o utentes por id
listaUtentes(Id,L):-findall((Id,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),utente(Id,Seg,Nome,Data,Email,Tel,Mor,Prof,Doenca,IDCentro),L).

%Predicad que lista todas as fase
listaFases(L):-findall((IDU,FASE), fase(IDU,FASE),L).


%Predicado que converte uma list de Fases para uma List de IDs
listFaseToListId([],L).
listFaseToListId([(ID,F)],L):- append([ID],[],L).
listFaseToListId( [(ID,F)|T] ,L):- append([ID],N,L),
                                listFaseToListId(T,N).


%IdentificarUtentesBemVac
%Todos os utentes bem vacinados que tenham o numero de tomas de vacinas correto

identificaUtentesBemVac(L):- findall((IDU), vacinacao_Covid(_,IDU,_,_,2,_),L1),
                            identificaUtentesIndevidoVac(L2),
                            listFaseToListId(L2,X),
                            eliminarComuns(X,L1,N),
                            agrupaUtentesID(N,L).



%--------------------------<5>--------------------------------------------------------------------------------------
%Identificar Utentes não vacinados e que são candidatas a vacinação por fase

identificaFase(L,N):-  utentesIdVacinadosFase(X,N), %tenho os utentes vacinados
                    findall((ID), fase(ID,N),L1), %utentes na fase N
                    eliminarComuns(X,L1,L2),
                    agrupaUtentesID(L2,L).
                    
                    
%Predicado que retorna os id dos utentes por fase de vacinacao      
utentesIdVacinadosFase(L,N):-findall((IDU),vacinacao_Covid(_,IDU,_,_,1,N),L1),
                    findall((IDU), vacinacao_Covid(_,IDU,_,_,2,N),L2),
                    concatenar(L1,L2,X),
                    remove_duplicados(X,L).              

%--------------------------<6>---------------------------------------------------------------------------------------
%Identificar Utentes para já devidamente vacinados com toma 1 a quem falta a segunda toma da vacina;

identificaFaltaToma2(L):-findall((IDU),vacinacao_Covid(_,IDU,_,_,1,_),L1),
                    findall((IDU), vacinacao_Covid(_,IDU,_,_,2,_),L2),
                    eliminarComuns(L2,L1,X),
                    agrupaUtentesID(X,T), %utentes devidamente e indevidamente vacinados a quem falta 2ªa toma
                    identificaUtentesIndevidoVac(I), %utentes indevidademente vacinados
                    eliminarComuns(I,T,L).
                    
%--------------------------<7>---------------------------------------------------------------------------------------
%Desenvolver um sistema de inferência capaz de implementar os mecanismos de raciocínio inerentes a estes sistemas.


% Sistema de inferência: Resposta -> {V,F}
si( Questao,verdadeiro ) :- Questao.
si( Questao,falso ) :- -Questao.
si(Questao,desconhecido):- nao(Questao), %se conhecimento nao existe então é desconhecido
                        nao(-Questao).
%Predicado que se não for possivel ver que questao é verdadeiro entao é falso
nao(Questao):-
    Questao,!,fail.
nao(Questao).


%------------------------------- Funçoes Auxiliares -----------------
%Perdicado pertence em forma de funcao pertence -> {V,F}
pertence(X,[X|T]).
pertence(X,[H|T]):-pertence(X,T).

% testa se todos os predicados são verdadeiros
teste([]).
teste([R|Lr]):- R, teste(Lr).

%Predicado que faz concat de T e Lista 
concatenar([],L,L).
concatenar(L,[],L).
concatenar([H | T], L, [H | R]) :- concatenar(T,L,R).

%Predicado que remove elementos duplicados

remove_duplicados(LI,LF):-remove(LI,[],LF).

%Se não pertencer adiciona à cabeça da nossa lista vazia
remove([],L,L).
remove([H|T],L,X):- pertence(H,L),
                  remove(T,L,X).
remove([H|T],L,X):- remove(T,[H|L],X).

% Extensão do Predicado comprimento: ListaElem, Comp -> {V,F}
comprimento([],0).
comprimento([X|L], C) :- comprimento(L, N), C is N+1.



%Extensao do Predicado para eliminar elementos comuns de uma lista noutra skrskr
%(lista de itens a retirar , lista onde se retira , lista return)
eliminarComuns([],[],L).
eliminarComuns(N,[],[]).
eliminarComuns([],N,N).
eliminarComuns([H|T],N,L):-removeTodasOcorrenciasElemento(H,N,L1),
                         eliminarComuns(T,L1,L).


%Extensao do Predicado para remover todas as ocorrencias de uma elemento
removeTodasOcorrenciasElemento(X,[],[]).
removeTodasOcorrenciasElemento(X,[X|T],L):- removeTodasOcorrenciasElemento(X,T,L),!.
removeTodasOcorrenciasElemento(X,[H|T],[H|L]):- removeTodasOcorrenciasElemento(X,T,L). %adicionar 


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


