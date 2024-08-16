:- include(solucion).

%%% 2
:- begin_tests(jugador_experto_en_metales).
    test("un jugador es experto en metales",nondet):-
        expertoEnMetales(ana).
    test("un jugador no es experto en metales",fail):-
        expertoEnMetales(carola).
:- end_tests(jugador_experto_en_metales).

%%% 3
:- begin_tests(civilizacion_popular).
    test("una civilizacion es popular",nondet):-
        esPopular(romanos).
    test("un civilizacion no es popular",fail):-
        esPopular(incas).
:- end_tests(civilizacion_popular).

%%% 4
:- begin_tests(tieneAlcanceGlobal).
    test("Una Tecnologia tiene alcance Global",nondet):-tieneAlcanceGlobal(herreria).
    test("Una Tecnologia tiene NO alcance Global",fail):-tieneAlcanceGlobal(laminas).
:- end_tests(tieneAlcanceGlobal).

%%% 5
:-begin_tests(civiliazacion_Es_lider).
    test("civilizacion alcanzo todas las tecnologias",nondet):-esLider(romanos). 
    test("civilizacion no alcanzo alguna tecnologia",fail):-esLider(incas).    
:-end_tests(civiliazacion_Es_lider).

%%% 7 
:-begin_tests(unidad_con_mas_vida).
    test("la unidad con mas vida de Ana",nondet):-unidadConMasVida(ana, jinete(caballo)). 
    test("la unidad con mas vida de Ana",nondet):-unidadConMasVida2(ana, [jinete(caballo)]). 
:-end_tests(unidad_con_mas_vida).

%%% 8
:-begin_tests(unidad_le_gana_a_otra).
    test("distinta unidad, evalua por ventaja",fail):-unidadleGanaA(campeon(100),jinete(caballo)).    
    test("distinta unidad, evalua por ventaja",nondet):-unidadleGanaA(jinete(caballo),campeon(100)).    
    test("misma unidad evalua nivel de vida",nondet):-unidadleGanaA(campeon(95),campeon(50)). 
:-end_tests(unidad_le_gana_a_otra).

%%% 9 
:- begin_tests(sobre_vivir_a_un_asedio).
    test("una persona puede sobre vivir a un asedio",nondet):-
        puedeSobreVivirAUnAsedio(beto).
    test("una persona no puede sobre vivir a un asedio",fail):-
        puedeSobreVivirAUnAsedio(carola).
:- end_tests(sobre_vivir_a_un_asedio).

%%% 10
:- begin_tests(arbol_de_tecnologias).
    test("Jugador puede desarrollar tecnologia sin dependencias",nondet):- puedeDesarrollar(beto,molino).
    test("Jugador NO puede desarrollar tecnologia que ya tiene",fail):- puedeDesarrollar(beto,herreria).
    test("Jugador puede desarrollar tecnologia con dependencias",nondet):- puedeDesarrollar(ana,fundicion).
    test("Jugador NO puede desarrollar tecnologia por falta de dependencias directas",fail):- puedeDesarrollar(ana,placas).
    test("Jugador NO puede desarrollar tecnologia por falta de dependencias indirectas",fail):- puedeDesarrollar(dimitri,horno).
:- end_tests(arbol_de_tecnologias).

