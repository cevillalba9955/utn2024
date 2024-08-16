
% CIVILIZACIONES Y TECNOLOGIA

%%% 1

% juega(Jugador,Civilizacion)
% tecnologia(Jugador,Tecnologia)

juega(ana,romanos).
juega(beto,incas).
juega(carola,romanos).
juega(dimitri,romanos).
tecnologia(ana,herreria).
tecnologia(ana,forja).
tecnologia(ana,emplumado).
tecnologia(ana,laminas).
tecnologia(beto,herreria).
tecnologia(beto,forja).
tecnologia(beto,fundicion).
tecnologia(carola,herreria).
tecnologia(dimitri,herreria).
tecnologia(dimitri,fundicion).

% elsa no es la partida por lo tanto no se modela en la base de conocimiento y todo lo que no pertenece a la base de
% conocimiento  se presume falso

% Predicados Generadores 
jugadores(Nombre):-juega(Nombre,_).
civilizaciones(Nombre):-juega(_,Nombre).
tecnologias(Nombre):-tecnologia(_,Nombre).


%%% 2
% Todos los integrantes 
% Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.


% p = tecnologia(Jugador,herreria)   q = tecnologia(Jugador,forja)
% r = tecnologia(Jugador,fundicion)  s = juega(Jugador,romanos)

% entonces segun el enunciado armo:
% (p ^ q) ^ (r v s) ,desarrollando por distributiva tenemos:

% (p ^ q  ^ r) v (p ^ q ^ s), ahora  armo el predicado expertitoEnMetales y  quedaria asi :

expertoEnMetales(Jugador):-tecnologia(Jugador,herreria),tecnologia(Jugador,forja),tecnologia(Jugador,fundicion).  
expertoEnMetales(Jugador):-tecnologia(Jugador,herreria),tecnologia(Jugador,forja),juega(Jugador,romanos).        

%%% 3

% Integrante 1  
  % Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
 
esPopular(Civilizacion):-
   civilizaciones(Civilizacion),     
   findall(Jugador, juega(Jugador,Civilizacion), Jugadores),
   length(Jugadores, Cantidad),
   Cantidad>1.



%%% 4
%-Integrante 2- 
 %Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
 %En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron.

tieneAlcanceGlobal(Tecno):-tecnologias(Tecno),
   forall(jugadores(Jugador),tecnologia(Jugador,Tecno)).


%%% 5

% Integrante 3 
% Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó
% todas las tecnologías que alcanzaron las demás. Una civilización alcanzó una tecnología cuando algún
% jugador de esa civilización la desarrolló.
% En los ejemplos, los romanos son una civilización líder pues entre Ana y Dimitri, que juegan con
% romanos, ya tienen todas las tecnologías que se alcanzaron.

% encuentra todas las tecnologias alcanzadas por una civilizacion
alcanzoTecnologia(Civilizacion, Tecnologia) :-
      juega(Jugador, Civilizacion),
      tecnologia(Jugador, Tecnologia).

% comprobar si una civilizacion es lider
esLider(Civilizacion) :- civilizaciones(Civilizacion),
   forall((alcanzoTecnologia(OtraCivilizacion, Tecnologia), OtraCivilizacion \= Civilizacion),
      alcanzoTecnologia(Civilizacion, Tecnologia)).



% UNIDADES

%%% 6
% Todos lo Integrantes

% unidad(campeon(vidas)).
% unidad(jinete(animal)).
% unidad(piquero(nivel,conEscudo o sin escudo)).

% tiene(Jugador,Unidad).
tiene(ana,jinete(caballo)).
tiene(ana,piquero(1,conEscudo)).
tiene(ana,piquero(2,sinEscudo)).
tiene(beto,campeon(100)).
tiene(beto,campeon(80)).
tiene(beto,piquero(1,conEscudo)).
tiene(beto,jinete(camello)).
tiene(carola,piquero(3,sinEscudo)).
tiene(carola,piquero(2,conEscudo)).

% Dimitri se presume falso por el principio de universo cerrado.

%%% 7

% Integrante 3

%Los jinetes a camello tienen 80 de vida y los jinetes a caballo tienen 90.
vida(jinete(caballo),90).
vida(jinete(camello),80).

%Cada campeón tiene una vida distinta.
vida(campeon(Vida),Vida).

%Los piqueros sin escudo de nivel 1 tienen vida 50, los de nivel 2 tienen vida 65 y los de nivel 3 tienen 70 de vida.
vida(piquero(1,sinEscudo),50).
vida(piquero(2,sinEscudo),65).
vida(piquero(3,sinEscudo),70).

%Los piqueros con escudo tienen 10% más de vida que los piqueros sin escudo.
vida(piquero(Nivel,conEscudo),VidaConEscudo) :- vida(piquero(Nivel,sinEscudo),VidaSinEscudo),
    VidaConEscudo is VidaSinEscudo * 1.1.
   

% Conocer la unidad con más vida que tiene un jugador
unidadConMasVida(Jugador,UnidadConMasVida):-
   jugadores(Jugador),
   aggregate_all(max(Vida),(tiene(Jugador,Unidades),vida(Unidades,Vida)),MaximaVida),
   tiene(Jugador,UnidadConMasVida),
   vida(UnidadConMasVida,MaximaVida).

% esta tambien pero devuelve una lista por si hubiera mas de una unidad con la vida maxima
unidadConMasVida2(Jugador,UnidadConMasVida):- 
   jugadores(Jugador),
   aggregate_all(max(Vida),(tiene(Jugador,Unidades),vida(Unidades,Vida)),MaximaVida), %Buscamos el valor maximo de vida de todos las unidades
   findall(Unidad,(tiene(Jugador,Unidad),vida(Unidad,MaximaVida)),UnidadConMasVida).

   


% 8 - Integrante 2
tieneVentaja(jinete(_),campeon(_)).
tieneVentaja(campeon(_),piquero(_,_)).
tieneVentaja(piquero(_,_),jinete(_)).
tieneVentaja(jinete(camello),jinete(caballo)).

unidadleGanaA(Unidad,Rival):- 
   tieneVentaja(Unidad,Rival).
  
unidadleGanaA(Unidad,Rival):- 
   not(tieneVentaja(Rival,Unidad)),
   vida(Unidad,NivelVida),vida(Rival,NivelVidaRival),
   NivelVida > NivelVidaRival.



% 9 - Integrante 1
%% -Integrante 1
/*Saber si un jugador puede sobrevivir a un asedio. Esto ocurre si tiene más piqueros con escudo que sin escudo.
En los ejemplos, Beto es el único que puede sobrevivir a un asedio, pues tiene 1 piquero con escudo y 0 sin escudo*/

puedeSobreVivirAUnAsedio(Jugador):-
   cantidadDeUnidades(Jugador,piquero(_,conEscudo),CantidadPiquerosConEscudo),
   cantidadDeUnidades(Jugador,piquero(_,sinEscudo),CantidadPiquerosSinEscudo),
   CantidadPiquerosConEscudo>CantidadPiquerosSinEscudo.
      
   
cantidadDeUnidades(Jugador,Unidad,CantidadDeUnidades):-
   jugadores(Jugador),
   findall(Unidad,tiene(Jugador,Unidad),Unidades),length(Unidades,CantidadDeUnidades).


% 10 - Arbol de Tecnologias 
% depende (hoja , raiz)
depende(emplumado,herreria).
depende(forja,herreria).
depende(laminas,herreria).
depende(punzon,emplumado).
depende(fundicion,forja).
depende(horno,fundicion).
depende(malla,laminas).
depende(placas,malla).
depende(collera,molino).
depende(arado,collera).

%% tengo que hacer una nueva lista de tecnologias porque no estan todas en la anterior..
%% no se si reemplazar la otra
listadetecnologias(Nombre):-depende(_,Nombre).
listadetecnologias(Nombre):-depende(Nombre,_).

% Tecnologias que un jugador puede desarrollar,

arbolDeDependencias(Rama,Raiz):- 
   depende(Rama,Raiz).
arbolDeDependencias(Hoja,Raiz):- 
   depende(Hoja,Rama),
   arbolDeDependencias(Rama,Raiz).
   
puedeDesarrollar(Jugador,TecnologiaADesarrollar):-
   jugadores(Jugador),
   distinct(listadetecnologias(TecnologiaADesarrollar)),
   not(tecnologia(Jugador,TecnologiaADesarrollar)),
   forall( arbolDeDependencias(TecnologiaADesarrollar,TecnologiaNecesaria),tecnologia(Jugador,TecnologiaNecesaria)).


%% 11

% esta funcion busca si la tecnologia se puede desarrollar segun la lista de tecnologias Ya desarrolladas- es inversible para el 2do argumento
sePuedeDesarrollarCon(TecnologiasPrevias,TecnologiaADesarrollar):-
   distinct(listadetecnologias(TecnologiaADesarrollar)),
   forall( arbolDeDependencias(TecnologiaADesarrollar,TecnologiaNecesaria),member(TecnologiaNecesaria,TecnologiasPrevias)),
   not(member(TecnologiaADesarrollar,TecnologiasPrevias)).

%mejora la regla del punto 10
puedeDesarrollar2(Jugador,TecnologiaADesarrollar):-
   findall(Tecnologia,tecnologia(Jugador,Tecnologia),TecnologiasDesarrolladas),
      sePuedeDesarrollarCon(TecnologiasDesarrolladas,TecnologiaADesarrollar).




ordenValido(Jugador,ListaOrdenada):-
   ordenar(ListaADesarrollar,[],ListaOrdenada).
/* length(ListaADesarrollar,CantidadInicial),
   length(ListaOrdenada,CantidadFinal),
   CantidadInicial = CantidadFinal.*/


ordenar2([], _, []). % Caso base: si la lista original está vacía, la lista resultante también lo está.

ordenar2([Tecnologia|Tecnologias], ListaPrevia, [Tecnologia|ListaOrdenada]) :- % Caso Recursivo
   sePuedeDesarrollarCon(ListaPrevia,Tecnologia),                             % si se puede desarrollar
   ordenar(Tecnologias, ListaPrevia, ListaOrdenada). 

ordenar2([Tecnologia|Tecnologias], ListaPrevia, ListaOrdenada) :-           % Caso recursivo para tecnologias que aun no se pueden desarrollar
   append(Tecnologias,[Tecnologia],TH),                                    % las mando al final de la lista
   ordenar(TH, ListaPrevia, ListaOrdenada). 




ordenar([], _, []). % Caso base: si la lista original está vacía, la lista resultante también lo está.

ordenar([Tecnologia|Tecnologias], ListaPrevia, [Tecnologia|ListaOrdenada]) :- % Caso Recursivo
   sePuedeDesarrollarCon(ListaPrevia,Tecnologia),                             % si se puede desarrollar
   append(ListaPrevia,[Tecnologia],ListaConNuevoDesarrollo),                  % Agrego la nueva tecnologia a la lista previa
   ordenar(Tecnologias, ListaConNuevoDesarrollo, ListaOrdenada). 

ordenar([Tecnologia|Tecnologias], ListaPrevia, ListaOrdenada) :-           % Caso recursivo para tecnologias que aun no se pueden desarrollar
   append(Tecnologias,[Tecnologia],TH),                                    % las mando al final de la lista
   ordenar(TH, ListaPrevia, ListaOrdenada). 

 % en el caso de dimitri , que desarrollo fundicion y no tiene forja, el 2do caso recursivo no termina nunca  



explosion([],[]).
explosion([H|T],[H|R]):-not(member(H,R)),!,explosion(T,R).
explosion([_|T],R):-explosion(T,R).



