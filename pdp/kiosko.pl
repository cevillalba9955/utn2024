% El Kioskito

% Son tiempos difíciles y además de dar clases, los profesores de Paradigmas abrimos un kioskito. Para poder atenderlo como se debe, establecimos un sistema de turnos donde cada persona se hace responsable. Por ejemplo:
% dodain atiende lunes, miércoles y viernes de 9 a 15.
atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).
% lucas atiende los martes de 10 a 20
atiende(lucas,martes,10,20).
% juanC atiende los sábados y domingos de 18 a 22.
atiende(juanC,sabado,18,22).
atiende(juanC,domingo,18,22).
% juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.
atiende(juanF,jueves,10,20).
atiende(juanF,viernes,12,20).
% leoC atiende los lunes y los miércoles de 14 a 18.
atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).
% martu atiende los miércoles de 23 a 24.
atiende(martu,miercoles,23,24).

% Consideramos siempre la hora exacta, por ejemplo: 10, 14, 17. Está fuera del alcance del examen contemplar horarios como 10:15 ó 17:30.
% Punto 1: calentando motores (2 puntos)
% Definir la relación para asociar cada persona con el rango horario que cumple, e incorporar las siguientes cláusulas:
% vale atiende los mismos días y horarios que dodain y juanC.
atiende(vale,Dia,HoraInicio,HoraFinal):-atiende(dodain,Dia,HoraInicio,HoraFinal).
atiende(vale,Dia,HoraInicio,HoraFinal):-atiende(juanC,Dia,HoraInicio,HoraFinal).

% nadie hace el mismo horario que leoC
% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles

% En caso de no ser necesario hacer nada, explique qué concepto teórico está relacionado y justifique su respuesta.

% Punto 2: quién atiende el kiosko... (2 puntos)
% Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el kiosko. Algunos ejemplos:
quienAtiende(Persona,Dia,Hora):-
        atiende(Persona,Dia,HoraInicio,HoraFinal),
        between(HoraInicio,HoraFinal,Hora). 
% si preguntamos quién atiende los lunes a las 14, son dodain, leoC y vale
% si preguntamos quién atiende los sábados a las 18, son juanC y vale
% si preguntamos si juanFdS atiende los jueves a las 11, nos debe decir que sí.
% si preguntamos qué días a las 10 atiende vale, nos debe decir los lunes, miércoles y viernes.

% El predicado debe ser inversible para relacionar personas y días.


% Punto 3: Forever alone (2 puntos)
% Definir un predicado que permita saber si una persona en un día y horario determinado está atendiendo ella sola. En este predicado debe utilizar not/1, y debe ser inversible para relacionar personas.
foreverAlone(Persona,Dia,Hora):-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(OtraPersona,Dia,Hora),OtraPersona\=Persona)).

% Ejemplos:
% si preguntamos quiénes están forever alone el martes a las 19, lucas es un individuo que satisface esa relación.
% si preguntamos quiénes están forever alone el jueves a las 10, juanFdS es una respuesta posible.
% si preguntamos si martu está forever alone el miércoles a las 22, nos debe decir que no (martu hace un turno diferente)
% martu sí está forever alone el miércoles a las 23
% el lunes a las 10 dodain no está forever alone, porque vale también está


% Punto 4: posibilidades de atención (3 puntos / 1 punto)
% Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día. 
horarios(Hora):-atiende(_,_,Hora,_).
horarios(Hora):-atiende(_,_,_,Hora).
personas(Nombre):-atiende(Nombre,_,_,_).


posibilidadesDeAtencion(Dia,Posibilidades):-distinct(horarios(Hora)),
findall(ListaPersonas, listaPersonas(Dia,Hora,ListaPersonas), Posibilidades).

listaPersonas(Dia,Hora,Personas):-
findall(Persona, quienAtiende(Persona,Dia,Hora), Personas).


listaPersonas2(Dia,Personas):-
    findall(Persona, distinct(Persona,quienAtiende(Persona,Dia,_)), Personas).
    

% Por ejemplo, si preguntamos por el miércoles, tiene que darnos esta combinatoria:
% nadie
% dodain solo
% dodain y leoC
% dodain, vale, martu y leoC
% vale y martu
% etc.

% Queremos saber todas las posibilidades de atención de ese día. La única restricción es que la persona atienda ese día (no puede aparecer lucas, por ejemplo, porque no atiende el miércoles).

% Punto extra: indique qué conceptos en conjunto permiten resolver este requerimiento, justificando su respuesta.


% Punto 5: ventas / suertudas (4 puntos)
% En el kiosko tenemos por el momento tres ventas posibles:

% golosinas, en cuyo caso registramos el valor en plata
% cigarrillos, de los cuales registramos todas las marcas de cigarrillos que se vendieron (ej: Marlboro y Particulares)
% bebidas, en cuyo caso registramos si son alcohólicas y la cantidad

% Queremos agregar las siguientes cláusulas:
% dodain hizo las siguientes ventas el lunes 10 de agosto: golosinas por $ 1200, cigarrillos Jockey, golosinas por $ 50
venta(dodain,fecha(lunes,10,8),[golosina(1200),cigarrillo([jockey]),golosina(50)]).

% dodain hizo las siguientes ventas el miércoles 12 de agosto: 8 bebidas alcohólicas, 1 bebida no-alcohólica, golosinas por $ 10
venta(dodain,fecha(miercoles,10,8),[golosina(1200),cigarrillo([jockey]),golosina(50)]).

% martu hizo las siguientes ventas el miercoles 12 de agosto: golosinas por $ 1000, cigarrillos Chesterfield, Colorado y Parisiennes.
% lucas hizo las siguientes ventas el martes 11 de agosto: golosinas por $ 600.
% lucas hizo las siguientes ventas el martes 18 de agosto: 2 bebidas no-alcohólicas y cigarrillos Derby.

% Queremos saber si una persona vendedora es suertuda, esto ocurre si para todos los días en los que vendió, la primera venta que hizo fue importante. Una venta es importante:
% en el caso de las golosinas, si supera los $ 100.
% en el caso de los cigarrillos, si tiene más de dos marcas.
% en el caso de las bebidas, si son alcohólicas o son más de 5.

% El predicado debe ser inversible: martu y dodain son personas suertudas.
