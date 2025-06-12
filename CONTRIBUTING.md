# Guía de Contribución

## Configuración del Entorno de Desarrollo

### 1. Requisitos Previos
- Flutter SDK (3.x o superior)
- Android Studio / VS Code
- Git
- Firebase CLI (solo para producción)

### 2. Clonar y Configurar
```bash
# Clonar el repositorio
git clone <repository_url>
cd case-digital-wallet

# Instalar dependencias
flutter pub get

# Generar código
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Configuración de Firebase
#### Desarrollo
La aplicación está configurada para funcionar en modo desarrollo sin Firebase usando una implementación mock:
```dart
// Credenciales de desarrollo
Teléfono: +59170986680
Contraseña: password123
PIN: 123456
```

#### Producción
1. Crear proyecto en [Firebase Console](https://console.firebase.google.com)
2. Descargar `google-services.json`
3. Colocar en `android/app/`
4. Habilitar el plugin en `android/app/build.gradle.kts`

### 4. Variables de Entorno
Copiar el archivo de ejemplo:
```bash
cp .env.example .env
```
Actualizar las variables según el ambiente.

## Estructura del Proyecto

```
lib/
├── core/                 # Configuraciones y utilidades core
│   ├── config/          # Configuraciones de la app
│   ├── di/              # Inyección de dependencias
│   ├── network/         # Cliente HTTP y configuración
│   ├── router/          # Navegación
│   └── theme/           # Tema de la app
└── features/            # Módulos de la aplicación
    ├── auth/            # Autenticación
    ├── wallet/          # Billetera
    ├── crypto/          # Criptomonedas
    └── kyc/             # Verificación de identidad
```

## Guías de Desarrollo

### Arquitectura
El proyecto sigue Clean Architecture:
- **Presentation**: BLoC pattern
- **Domain**: Use cases y entities
- **Data**: Repositories y data sources

### Convenciones de Código
- Usar `flutter_lints` para estilo de código
- Nombres descriptivos en inglés
- Documentar clases y métodos públicos
- Seguir principios SOLID

### Testing
- Tests unitarios para lógica de negocio
- Tests de integración para repositories
- Tests de widget para UI

### Gestión de Estado
- Usar BLoC para gestión de estado
- Eventos claros y estados inmutables
- Una sola responsabilidad por BLoC

## Flujo de Trabajo Git

### Branches
- `main`: Producción
- `develop`: Desarrollo
- `feature/*`: Nuevas funcionalidades
- `bugfix/*`: Correcciones
- `release/*`: Preparación de releases

### Commits
Formato:
```
<tipo>(<alcance>): <descripción>

[cuerpo]

[pie]
```
Tipos:
- feat: Nueva funcionalidad
- fix: Corrección de bug
- docs: Documentación
- style: Formato
- refactor: Refactorización
- test: Tests
- chore: Mantenimiento

### Pull Requests
1. Crear desde feature branch a develop
2. Descripción clara del cambio
3. Tests pasando
4. Code review aprobado
5. No conflictos

## Build y Deploy

### Desarrollo
```bash
# Limpiar y reconstruir
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar en modo debug
flutter run
```

### Producción
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Archivos y Directorios Ignorados

### No Versionar
- /build/
- /.dart_tool/
- Archivos de Firebase
- Archivos de IDE
- Archivos generados
- Variables de entorno

### Sí Versionar
- /lib/
- /test/
- pubspec.yaml
- analysis_options.yaml
- Archivos de ejemplo
- Documentación

## Resolución de Problemas

### Errores Comunes

1. **Error de Firebase**
```
Solution: Usar implementación de desarrollo o configurar Firebase
```

2. **Error de Generación de Código**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **Error de Dependencias**
```bash
flutter pub cache repair
flutter pub get
```

## Recursos Adicionales

- [Flutter Docs](https://flutter.dev/docs)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
