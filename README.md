# CASE - Billetera Digital

Una aplicación de billetera digital desarrollada en Flutter para el mercado boliviano.
## Backend
https://github.com/moises-cisneros/Case-Wallet-Back
## Características

- 🔐 Autenticación segura con SMS y PIN
- 💰 Gestión de saldo en Bolivianos (Bs) y USDT
- 📱 Pagos mediante códigos QR
- 🔄 Conversión automática Bs ↔ USDT ("Resguardar")
- 📊 Historial de transacciones
- 🆔 Verificación de identidad (KYC)
- 🔔 Notificaciones push

## Arquitectura

La aplicación sigue los principios de Clean Architecture con:

- **Presentation Layer**: BLoC para gestión de estado
- **Domain Layer**: Casos de uso y entidades
- **Data Layer**: Repositorios y fuentes de datos

## Estructura del Proyecto

```
lib/
├── core/
│   ├── config/          # Configuración de la app
│   ├── di/              # Inyección de dependencias
│   ├── network/         # Cliente API
│   ├── router/          # Navegación
│   └── theme/           # Tema y estilos
├── features/
│   ├── auth/            # Autenticación
│   ├── home/            # Pantalla principal
│   ├── wallet/          # Funcionalidades de billetera
│   ├── kyc/             # Verificación de identidad
│   └── crypto/          # Funcionalidades cripto
└── main.dart
```

## Dependencias Principales

- `flutter_bloc`: Gestión de estado
- `go_router`: Navegación
- `dio`: Cliente HTTP
- `retrofit`: API REST
- `flutter_secure_storage`: Almacenamiento seguro
- `camera`: Acceso a cámara
- `qr_flutter`: Generación de códigos QR
- `qr_code_scanner`: Escaneo de códigos QR
- `firebase_messaging`: Notificaciones push

## Configuración

1. Clona el repositorio
2. Ejecuta `flutter pub get`
3. Configura Firebase para notificaciones push
4. Actualiza las URLs de API en `lib/core/config/app_config.dart`
5. Ejecuta `flutter run`

## Funcionalidades Implementadas

### Epic 1: Autenticación
- ✅ Registro con número de teléfono
- ✅ Verificación SMS con OTP
- ✅ Creación de contraseña y PIN
- ✅ Inicio de sesión

### Epic 2: Billetera Fiat
- ✅ Visualización de saldo
- ✅ Pantalla principal con acciones rápidas
- 🔄 Depósitos (en desarrollo)
- 🔄 Transferencias (en desarrollo)
- 🔄 Historial de transacciones (en desarrollo)

### Epic 3: KYC
- 🔄 Verificación de identidad (en desarrollo)

### Epic 4: Cripto
- 🔄 Funcionalidad "Resguardar" (en desarrollo)

## Próximos Pasos

1. Implementar las pantallas de KYC
2. Completar funcionalidades de wallet
3. Integrar APIs reales
4. Implementar notificaciones push
5. Agregar tests unitarios y de integración

## Licencia

Este proyecto es privado y confidencial.
