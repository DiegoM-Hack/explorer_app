# GameVault

Aplicación móvil desarrollada en Flutter que permite administrar una colección de videojuegos utilizando MongoDB Atlas como base de datos en la nube y la API RAWG para consultar videojuegos.

## Integrantes

* Diego Montaluisa

## Tecnologías utilizadas

* Flutter
* Dart
* MongoDB Atlas
* mongo_dart
* Provider
* Dio
* RAWG Video Games Database API

## Funcionalidades

### CRUD Completo

* Crear videojuegos manualmente.
* Guardar videojuegos desde la API RAWG.
* Listar videojuegos almacenados en MongoDB Atlas.
* Editar videojuegos mediante formulario precargado.
* Eliminar videojuegos con confirmación.

### API Externa

La aplicación consume la API pública RAWG para consultar videojuegos.

Características:

* Búsqueda de videojuegos.
* Visualización de detalles.
* Guardar videojuegos en la colección personal.

### Infinite Scrolling

Se implementó carga infinita utilizando ScrollController y paginación de la API RAWG.

### Navegación

La aplicación cuenta con las siguientes pantallas:

1. Inicio
2. Mi Colección
3. Formulario
4. Detalle
5. Explorador API
6. Acerca de

## API utilizada

RAWG Video Games Database API

Documentación:

https://rawg.io/apidocs

### Endpoint principal

Obtener videojuegos:

GET

https://api.rawg.io/api/games

Parámetros utilizados:

| Parámetro | Descripción                      |
| --------- | -------------------------------- |
| key       | API Key                          |
| page      | Número de página                 |
| page_size | Cantidad de registros por página |
| search    | Texto de búsqueda                |

Ejemplo:

https://api.rawg.io/api/games?key=API_KEY&page=1&page_size=20

Ejemplo de búsqueda:

https://api.rawg.io/api/games?key=API_KEY&search=mario

## Base de datos

MongoDB Atlas

Base de datos:

gamevault

Colección:

games

Campos almacenados:

| Campo      | Tipo   |
| ---------- | ------ |
| id         | String |
| nombre     | String |
| genero     | String |
| plataforma | String |
| imagen     | String |
| rating     | Double |
| nota       | String |

## Estructura del proyecto

lib/

├── models/

│ └── game.dart

├── providers/

│ └── game_provider.dart

├── services/

│ ├── mongo_service.dart

│ └── rawg_service.dart

├── screens/

│ ├── home_screen.dart

│ ├── collection_screen.dart

│ ├── detail_screen.dart

│ ├── form_screen.dart

│ ├── api_screen.dart

│ └── about_screen.dart

└── main.dart

## Instrucciones de ejecución

### 1. Clonar repositorio

git clone <URL_DEL_REPOSITORIO>

### 2. Instalar dependencias

flutter pub get

### 3. Configurar MongoDB Atlas

Modificar el archivo:

lib/services/mongo_service.dart

Actualizar la variable:

static const String mongoUrl = 'TU_URI_DE_MONGODB_ATLAS';

### 4. Configurar API RAWG

Modificar el archivo:

lib/services/rawg_service.dart

Actualizar la API Key:

"key": "TU_API_KEY"

### 5. Ejecutar aplicación

flutter run

## Requisitos

* Flutter SDK
* Android Studio o VS Code
* Emulador Android o dispositivo físico
* Cuenta de MongoDB Atlas
* API Key de RAWG

## Evidencias de cumplimiento

✔ CRUD completo

✔ MongoDB Atlas

✔ API externa RAWG

✔ Infinite Scrolling

✔ Navegación entre múltiples pantallas

✔ Guardar registros desde API hacia MongoDB

✔ Gestión de detalles de videojuegos


* Evidencias
- Pantalllas 
<img width="367" height="828" alt="image" src="https://github.com/user-attachments/assets/15a0d328-6ba2-4ad4-a820-bb2229807f24" />
<img width="368" height="826" alt="image" src="https://github.com/user-attachments/assets/0c8ad2c0-a4b9-4818-9d50-a5e545efeeaa" />
<img width="359" height="748" alt="image" src="https://github.com/user-attachments/assets/6aa5bf76-a284-4bc8-b802-2a662c20565e" />
<img width="361" height="752" alt="image" src="https://github.com/user-attachments/assets/d4f3a8db-4f4a-476c-8791-ad5cf414ce58" />
<img width="368" height="798" alt="image" src="https://github.com/user-attachments/assets/8adff6f5-7511-43d0-955f-cf8c2e6d9bc5" />
<img width="366" height="796" alt="image" src="https://github.com/user-attachments/assets/4da85a45-e469-419f-bac6-8558cf76d5aa" />

- MongoDB

<img width="1749" height="796" alt="image" src="https://github.com/user-attachments/assets/9cc0bc98-bd78-462c-99ae-1ab3d0ac6e8d" />





