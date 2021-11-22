## Prueba Rappi ##

+ Se utilizó CLEAN como arquitectura

# Capas Proyecto #

El proyecto se encuentra bien distribuidas las capas implementando el clean arquitecture

## Capa Presentacion ( capa de vista ) ##

 + Coordinador de flujo de todas las vistas que se presenta al usuario
     Ruta= Presentation: RappiMoviesScene: Flows: RappiMoviesSearchFlowCoordinator.swift 
 + Se implemento MVVM por cada una de las funacionalidades de la app en este case 3 (Menu categoria, RappiMovieCatergory, RAppiMovieDetails), cada una las funcionalidades implementa el viemModel el cual mapeo los objetos de la vista en algunos caso implementa el patron Observador con el fin de tener una accion reactiva al momento de la interacion con esta
          Ruta= Presentation: RappiMoviesScene:
 

## Capa Data ( capa de almaceniamiento y mapeo de datos) ##

 + Almacenamiento en cache, base de datos local
     Ruta= Data: PersistenciaStorages: CoreDataStorage: CoreDataStorage.swift y CoreDataStorage.xcdatamodeld
 + Consulta de data con Repository
     Ruta= Data: Repositories: DefaultRappiMoviesRepository.swift y DefaultPosterImagesRepository
 + Mapeo de respuesta del servicio a Entidades legibles para la capa Doamin
     Ruta = Data: Network: DataMapping RappiMOviesRequestDTO.swift y RappiMoviesResponseDTO.swift 

## Capa Domain ( capa de Negocio y interfases Repository) ##

    + Contiene las Entidades del ejemplo la cual es la capa central del clean arquitecture.
        Ruta= Domain: Entities RappiMovie.Swift
    + Consulta las reglas del negocio el cual contiene los casos de uso que aplican al uso o alcance de la aplicacion
        Ruta= Domain: UsesCase: SearchRappiMoviesUseCase.Swift
    + Interfaces de los repositorios  son los encargados de en rutar la peticion del repositorio de la regla de negocio
        Ruta= Domain: Interfaces: Repositories: RappiMoviesRepository
        
## Capa Infrastructure ##

    + Es la capa encargada de construir los EndPoint que se implementara en el  consumo de los servicios, en este caso se registo en el infoplist la url base y la password del consumo y estas se consutan y arma la peticion dependiendo del metodo que acceda y los parametros que envie.
        Ruta: Infrastructure: Network: EndPoint.Swift.
        
## FastLane y SwiftLint##

    + herramientas de automatizacion ya se para revision de codigo integrado con sonar, tambien sirven para automatizar salidas a produccion o  envios a testflight, hasta se pueden combinar con pipeline  y realizar revision de codigos automatizadas
    
### ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito? ###
+ Consiste en establecer una parte de la funcionalidad a una unica clase o modulo, el prosito seria poder implementar varias veces estas funcionalidades en diferente proyecto sin caer en concurrencia de codigo. este es el primer principio de SOLID "Single Resposibility Principle"

### ¿Que caracteristicas tiene un buen codigo? ###

+ Escalable
+ Mantenible
+ Testeable
