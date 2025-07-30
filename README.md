# Gifs App

Aplicación móvil desarrollada en Flutter que muestra los GIFs más populares del momento (trending) utilizando la API de Giphy. La app permite visualizar los GIFs y también buscar GIFs específicos a través de un campo de búsqueda.

## Características

- **Visualización de GIFs en Tendencia**: Muestra una cuadrícula con los GIFs más populares.
- **Búsqueda de GIFs**: Permite buscar GIFs por término.
- **Debouncing**: Optimiza las llamadas a la API durante la búsqueda para mejorar el rendimiento.
- **Efecto Shimmer**: Muestra un efecto de carga (shimmer) mientras se obtienen los GIFs.
- **Manejo de Estados**: Gestiona de forma clara los estados de carga, éxito y error.
- **Arquitectura Limpia**: Separa la lógica de negocio de la interfaz de usuario para un código más mantenible y escalable.

## Estructura del Proyecto

El proyecto sigue una arquitectura limpia y modular, separando las responsabilidades en dos partes principales: la aplicación Flutter (`giphy_app`) y un paquete Dart independiente para la lógica de negocio (`giphy_gifs_core`).

```
.
├── giphy_app/                  # Aplicación Flutter Principal
│   ├── lib/
│   │   ├── main.dart             # Punto de entrada de la aplicación
│   │   ├── app.dart              # Configuración de MaterialApp, tema, rutas
│   │   ├── core/                 # Funcionalidad central de la aplicación (DI, Tema, Errores)
│   │   ├── features/             # Características de la aplicación (ej. Gif Viewer)
│   │   └── shared/               # Widgets y utilidades compartidas
│   └── test/                     # Pruebas de la aplicación
│
└── giphy_gifs_core/            # Paquete Dart (Dominio y Datos)
    ├── lib/
    │   ├── src/
    │   │   ├── domain/             # Lógica de Dominio (Entidades, Repositorios, Casos de Uso)
    │   │   └── data/               # Capa de Datos (Modelos, Fuentes de Datos, Repositorios)
    │   └── giphy_gifs_core.dart  # Archivo de exportación del paquete
    └── test/                     # Pruebas del paquete
```

## Paquetes Utilizados

La aplicación utiliza los siguientes paquetes principales:

- **`flutter_bloc`**: Para la gestión de estado con el patrón BLoC (usando Cubit).
- **`get_it`**: Para la inyección de dependencias.
- **`http`**: Para realizar las peticiones a la API de Giphy.
- **`flutter_dotenv`**: Para gestionar las variables de entorno (como la API Key).
- **`shimmer`**: Para el efecto de carga.
- **`flutter_staggered_grid_view`**: Para mostrar la cuadrícula de GIFs.
- **`bloc_test`**: Para facilitar las pruebas de los Cubits.
- **`mockito`**: Para crear mocks en las pruebas.

## Testing

El proyecto incluye pruebas unitarias, de widgets y golden tests para garantizar el correcto funcionamiento de la lógica de negocio y la interfaz de usuario.

### Pruebas de Widgets

A continuación, un ejemplo de una prueba de widget para la `GifListPage`, donde se verifica que el título y el campo de búsqueda se renderizan correctamente:

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_state.dart';
import 'package:gifs_app/features/gif_viewer/presentation/pages/gif_list_page.dart';

class MockGifCubit extends MockBloc<GifCubit, GifState> implements GifCubit {}

void main() {
  late MockGifCubit mockGifCubit;

  setUp(() {
    mockGifCubit = MockGifCubit();
  });

  testWidgets('GifListPage has a title and a search field', (
    WidgetTester tester,
  ) async {
    whenListen(
      mockGifCubit,
      Stream.fromIterable([GifInitial()]),
      initialState: GifInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GifCubit>(
          create: (_) => mockGifCubit,
          child: const GifListPage(),
        ),
      ),
    );

    expect(find.text('Giphy Trending'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
```

### Golden Tests

También se utilizan Golden Tests para asegurar que la UI no cambie inesperadamente. Estos tests comparan los widgets con una imagen de referencia ("golden file").

Aquí un ejemplo de un golden test para la `GifListPage` en su estado de carga:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_state.dart';
import 'package:gifs_app/features/gif_viewer/presentation/pages/gif_list_page.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart' as core;
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockGifCubit extends MockBloc<GifCubit, GifState> implements GifCubit {}

void main() {
  late MockGifCubit mockGifCubit;

  final tGif = core.GIF(
    id: '1',
    title: 'Test GIF',
    originalImage: core.ImageInfo(
      url: 'https://media.giphy.com/media/3o6Zt481isNVuQI1l6/giphy.gif',
      width: 200,
      height: 150,
    ),
  );

  setUp(() {
    mockGifCubit = MockGifCubit();
  });

  testWidgets('Golden test for GifListPage in loaded state', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      whenListen(
        mockGifCubit,
        Stream.fromIterable([GifLoaded([tGif])]),
        initialState: GifLoaded([tGif]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GifCubit>(
            create: (_) => mockGifCubit,
            child: const GifListPage(),
          ),
        ),
      );

      await expectLater(
        find.byType(GifListPage),
        matchesGoldenFile('golden/gif_list_page_loaded.png'),
      );
    });
  });
}
```

Para actualizar los golden files, ejecuta:
```bash
flutter test --update-goldens
```

## Cómo Empezar

Para ejecutar el proyecto, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone <URL_DEL_REPOSITORIO>
    ```

2.  **Crea un archivo `.env`** en la raíz del proyecto y añade tu API Key de Giphy:
    ```
    GIPHY_API_KEY=TU_API_KEY_AQUI
    ```

3.  **Instala las dependencias:**
    ```bash
    flutter pub get
    ```

4.  **Ejecuta la aplicación:**
    ```bash
    flutter run
    ```