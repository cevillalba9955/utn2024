% NotiLogic
% Un grupo de periodistas quiere armar su diario NotiLogic, entonces nos piden modelar en prolog una solución para administrar sus noticias. 
% Para comenzar sabemos que las noticias tienen un autor, un artículo y una cantidad de visitas. 

%%% noticia(autor,articulo,cantidadvisitas).

% Los artículos generalmente son escritos por los autores aunque vamos a ver que no siempre ocurre lo mismo.
autores(Nombre):-noticia(Nombre,_,_).
% Todos los artículos tienen un título y un personaje involucrado en la noticia. 

%%% articulo(titulo,personaje).

% Los personajes pueden ser :
%   deportistas de los cuales sabemos la cantidad de títulos ganados, 
%   de farándula en cuyo caso conocemos con qué personaje está peleando o 
%   políticos de quien conocemos el partido político al que pertenece. 

%%% deportista(nombre,cantidadtitulos).
%%% farandula(nombre,enemigo).
%%% politico(nombre,partido).

% Por ejemplo sabemos que:
% Art Vandelay publicó una noticia con 25 visitas cuyo artículo es titulado “Nuevo título para Lloyd Braun”, que es un deportista con 5 títulos ya ganados. 
noticia("Art Vandelay",articulo("Nuevo título para Lloyd Braun",deportista("Lloyd Braun",5)),25).

% Elaine Benes publicó una noticia con 16 visitas con su artículo titulado “Primicia” involucrando a Jerry Seinfeld, quién tiene pica con Kenny Bania.
noticia("Elaine Benes",articulo("Primicia",farandula("Jerry Seinfeld","Kenny Bania")),16).

% También sacó una noticia muy popular de 150 visitas con el artículo titulado “El dólar bajó! … de un arbolito”, también del farandulero Jerry Seinfeld pero en este caso con bronca contra Newman.
noticia("Elaine Benes",articulo("El dólar bajó! … de un arbolito",farandula("Jerry Seinfeld","Newman")),150).

% Bob Sacamano, un poco más modesto tiene una noticia de 10 visitas para su artículo titulado “No consigue ganar ni una carrera”, castigando al pobre David Puddy que tiene cero títulos ganados.
noticia("Bob Sacamano",articulo("No consigue ganar ni una carrera",deportista("David Puddy",0)),10).

% Bob Sacamano también tiene una gran publicación de 155 visitas donde en su artículo destaca al político “Cosmo Kramer encabeza las elecciones” perteneciente al partido los amigos del poder.
noticia("Bob Sacamano",articulo("Cosmo Kramer encabeza las elecciones",politico("Cosmo Kramer","los amigos del poder")),155).

% George Costanza, un personaje muy audaz, roba las noticias de Bob Sacamano obteniendo la misma cantidad de visitas 
%   y todas las noticias de farándula las transforma en noticias de política involucrando al famoso como político perteneciente al partido amigos del poder, pero como la noticia es puro chamuyo obtiene la mitad de las visitas que la original.


noticia("George Costanza",articulo(Titulo,Personaje),CantidadDeVisitas):-autores(Autor),
    noticia(Autor,articulo(Titulo,Personaje),CantidadDeVisitas),
    Autor = "Bob Sacamano".


noticia("George Costanza",articulo(Titulo,politico(Famoso,"los amigos del poder")),CantidadDeVisitas):-
    noticia(_,articulo(Titulo,farandula(Famoso,_)),CantidadOriginal),
    CantidadDeVisitas is CantidadOriginal / 2.

personajeFarandula(farandula(_,_)).

% Por ejemplo, para el caso de la noticia "Primicia" de Elaine Benes, George Constanza obtendría 8 visitas, porque se trata de un artículo de alguien de la farándula. En el caso de "No consigue ganar una carrera" de Bob Sacamano, tendría 10 visitas como la historia original.


% Si bien George hace de las suyas, sabemos que Elaine Benes no roba las noticias de Art Vandelay.


% Punto 1 (4 Puntos)
% Modelar en la base de conocimiento los requerimientos anteriormente descritos. En caso de no ser necesario hacer nada, explique qué concepto teórico está relacionado y justifique su respuesta.


% Punto 2 (3 Puntos)
% Ahora empezamos a pensar en qué sitios de noticias podríamos publicar. Entonces nos interesa saber si un artículo es amarillista. Esto ocurre si el título es "Primicia" o si la persona involucrada en dicha noticia está complicada. Los deportistas con menos de tres títulos, los personajes de farándula que tienen problemas contra Jerry Seinfeld y todos los políticos están complicados.


% Por ejemplo el artículo de Elaine Benes que dice "Primicia" es amarillista, el artículo de Bob Sacamano que hizo sobre David Puddy ya que tiene cero títulos y su otra publicación de política con Cosmo Kramer también lo son. 

% Punto 3 (4 Puntos)

% También evaluamos a los autores. Entonces queremos saber 


% Si a un autor no le importa nada. Esto ocurre cuando todas sus noticias que fueron muy visitadas son amarillistas. Que una noticia sea muy visitada implica que tenga más de 15 visitas. 
% Por ejemplo, sabemos que a Bob Sacamano no le importa nada porque su única publicación con 155 visitas es de política, lo que la hace amarillista. Lo mismo ocurre con George Costanza que se la robó. Pasa lo mismo con la noticia titulada “Primicia” de Elaine Benes que es amarillista y es muy visitada pero su noticia titulada “El dólar bajó! … de un arbolito”, que también cumple con la cantidad mínima de visitas no es amarillista. 


% Si un autor es muy original, qué ocurre cuando no hay otra noticia que tenga el mismo título. 
% Por ejemplo, sabemos que George Costanza roba los artículos de Bob Sacamano y los de farándula de Elaine Benes. Por lo tanto ellos no son originales, mientras que Art Vandelay es el único que satisface la condición.


% Si un autor tuvo un traspié, es decir si tiene al menos una noticia poco visitada. 
% Por ejemplo Bob Sacamano tiene una noticia de 10 visitas. George Costanza corre con la misma suerte porque le copia la noticia, además de la noticia Primicia que la transforma en política con sólo 8 visitas.

% Nota: Todos los predicados deben ser inversibles.   

% Punto 4 (3 puntos)
% ¡Excelente! Ahora necesitamos una Edición loca: queremos armar un resumen de la semana con una combinación posible de artículos amarillistas que no superen las 50 visitas en total. El predicado debe ser inversible.

% Por ejemplo:
% Una edición posible (44 visitas) sería:
% El artículo “Primicia” de Seinfeld contra Bania (16 visitas)
% El Artículo por Bob Sacamano “No consigue ganar una carrera”  de David Puddy (10 visitas)
% El Artículo por George Costanza “No consigue ganar una carrera”  de David Puddy (10 visitas)
% El artículo de George Costanza “Primicia” mutado a política de Jerry Seinfeld (8 visitas).
% Otra edición posible (36 visitas) sería:
% El artículo “Primicia” de Seinfeld contra Bania (16 visitas)
% El Artículo por Bob Sacamano “No consigue ganar una carrera”  de David Puddy (10 visitas)
% El Artículo por George Costanza “No consigue ganar una carrera”  de David Puddy (10 visitas)
% Otra edición posible (0 visitas) sería no considerar ningún artículo
% Etc.




