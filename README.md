Aquí tienes una versión mejorada y profesional del README, traducida al inglés, con el concepto de **"Resguardo"** ya incluido bajo el término "Auto-conversion to USDT (Safeguard)", y con una estructura más clara para el público internacional:

---

# 💼 CASE - Digital Wallet

A secure and user-friendly **digital wallet application built with Flutter**, tailored for the Bolivian market.

## 🔗 Backend Repository

[GitHub - Case Wallet Backend](https://github.com/moises-cisneros/Case-Wallet-Back)

---

## 🚀 Features

* 🔐 Secure authentication via **SMS OTP** and **PIN**
* 💰 Wallet balance in **Bolivianos (Bs)** and **USDT**
* 📱 **QR code-based** payments
* 🔄 **Auto-conversion between Bs and USDT** ("Safeguard")
* 📊 Transaction history
* 🆔 **KYC** (Know Your Customer) identity verification
* 🔔 Push notifications

---

## 🏗️ Architecture

Built following **Clean Architecture** principles:

* **Presentation Layer**: State management with BLoC
* **Domain Layer**: Business logic and use cases
* **Data Layer**: Repositories and data sources

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── di/              # Dependency injection
│   ├── network/         # API client
│   ├── router/          # Navigation and routing
│   └── theme/           # App theming and styling
├── features/
│   ├── auth/            # Authentication module
│   ├── home/            # Main dashboard
│   ├── wallet/          # Wallet and balance features
│   ├── kyc/             # Identity verification
│   └── crypto/          # USDT and crypto operations
└── main.dart
```

---

## 📦 Core Dependencies

* `flutter_bloc`: State management
* `go_router`: Navigation
* `dio`: HTTP client
* `retrofit`: REST API client
* `flutter_secure_storage`: Secure local storage
* `camera`: Camera access
* `qr_flutter`: QR code generation
* `qr_code_scanner`: QR scanning
* `firebase_messaging`: Push notifications

---

## ⚙️ Setup Instructions

1. Clone this repository.
2. Run `flutter pub get`.
3. Set up Firebase for push notifications.
4. Update API URLs in `lib/core/config/app_config.dart`.
5. Run the app with `flutter run`.

---

## ✅ Implemented Features

### Epic 1: Authentication

* ✅ Phone number registration
* ✅ SMS OTP verification
* ✅ Password and PIN creation
* ✅ Login

### Epic 2: Fiat Wallet

* ✅ View balance
* ✅ Quick actions dashboard
* ✅ Deposits
* ✅ Transfers 
* 🔄 Transaction history *(in progress)*

### Epic 3: KYC

* 🔄 Identity verification *(in progress)*

### Epic 4: Crypto

* ✅ "Safeguard" feature: Bs ↔ USDT auto-conversion 

---

## 📌 Next Steps

1. Implement full KYC flow
2. Enable Firebase push notifications
3. Add unit and integration tests

---

## 🔒 License

This project is **private and confidential**. All rights reserved by the development team.


