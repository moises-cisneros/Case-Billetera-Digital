# CASE - Digital Wallet

A complete mobile digital wallet application developed in Flutter with advanced cryptocurrency and geolocation features.

## 🚀 Main Features

### 💰 Digital Wallet
- **Balance management** in Bolivianos (Bs) and cryptocurrencies
- **Transfers** between users
- **Deposits and withdrawals** of money
- **Detailed transaction history**
- **USDT safeguarding** to protect money value

### 🪙 Crypto Features
- **Real-time cryptocurrency market**
- **Buy and sell** cryptocurrencies
- **Conversion** between fiat and crypto currencies
- **Send cryptocurrencies** to external addresses
- **Price charts** and market statistics
- **Support for multiple cryptocurrencies**: Bitcoin, Ethereum, USDT, BNB, Solana

### 🗺️ Location Map
- **Places that accept crypto** as payment method
- **P2P ATMs** (people who exchange physical money for crypto)
- **Traditional exchange houses**
- **Filters by location type**
- **Geolocation** to find nearby places
- **Detailed information** for each location
- **Interactive map** with Google Maps integration
- **Location filtering** and search functionality

### 🔐 Security and Authentication
- **KYC verification** (Know Your Customer)
- **Biometric authentication**
- **Security PIN**
- **SMS verification**
- **Data encryption** for sensitive information

## 📱 Technologies Used

- **Flutter** - Mobile development framework
- **Dart** - Programming language
- **BLoC Pattern** - State management
- **Go Router** - Navigation
- **Google Maps** - Maps and geolocation
- **Firebase** - Backend and notifications
- **Dio** - HTTP client
- **GetIt** - Dependency injection
- **Provider** - State management for BLoC

## 🛠️ Installation and Setup

### Prerequisites
- Flutter SDK (version 3.16.0 or higher)
- Dart SDK (version 3.2.0 or higher)
- Android Studio / VS Code
- Android device or emulator

### Installation Steps

1. **Clone the repository**
```bash
git clone https://github.com/moises-cisneros/Case-Billetera-Digital.git
cd Case-Billetera-Digital
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase** (optional)
- Create a project in Firebase Console
- Download `google-services.json` and place it in `android/app/`
- Uncomment Firebase lines in `main.dart`

4. **Configure Google Maps** (for map functionality)
- Get a Google Maps API key
- Add the key in `android/app/src/main/AndroidManifest.xml`

5. **Run the application**
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/          # App configurations
│   ├── di/             # Dependency injection
│   ├── network/        # HTTP client and APIs
│   ├── router/         # Route configuration
│   └── theme/          # Themes and styles
├── features/
│   ├── auth/           # Authentication and registration
│   ├── crypto/         # Cryptocurrency features
│   ├── home/           # Main page
│   ├── kyc/            # KYC verification
│   ├── maps/           # Maps and locations
│   ├── profile/        # User profile management
│   ├── qr/             # QR code functionality
│   ├── activities/     # User activity tracking
│   ├── p2p/            # P2P management
│   ├── commerce/       # Commerce management
│   └── wallet/         # Wallet features
└── main.dart           # Entry point
```

## 🔧 API Configuration

### CoinGecko API (Crypto Prices)
The app uses mock data by default. To use real data:
1. Register at [CoinGecko](https://www.coingecko.com/en/api)
2. Get API key
3. Configure in the crypto repository

### Google Maps API
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Enable Maps SDK for Android
3. Create API credentials
4. Add the key in AndroidManifest.xml

## 🎯 Key Features

### Crypto Market
- List of cryptocurrencies with real-time prices
- Historical price charts
- Buy/sell functionality
- Automatic currency conversion
- Crypto transaction history

### Interactive Map
- Location visualization on map
- Service type filters
- Detailed information for each location
- Integrated navigation
- Add new locations
- **Fixed BLoC integration** - Resolved ProviderNotFound errors

### P2P ATMs
- List of verified people
- Competitive exchange rates
- Rating system
- Contact information
- Transaction history

## 🔒 Security

- **Encryption** of sensitive data
- **Two-factor authentication**
- **Mandatory KYC verification**
- **Security PIN** for transactions
- **Audit logs** for all operations

## 📊 Project Status

- ✅ **Authentication and registration** - Completed
- ✅ **Basic wallet** - Completed
- ✅ **Crypto market** - Completed (with mock data)
- ✅ **Location map** - Completed (UI + BLoC integration fixed)
- ✅ **P2P ATMs** - Completed (UI)
- ✅ **Profile management** - Completed
- ✅ **QR functionality** - Completed
- ✅ **Activity tracking** - Completed
- 🔄 **Real API integration** - In progress
- 🔄 **Complete backend** - In development

## 🐛 Recent Fixes

### Maps Feature (Latest Update)
- **Fixed ProviderNotFound error** for MapsBloc
- **Resolved BLoC integration** issues
- **Updated dependency injection** configuration
- **Cleaned up duplicate code** in maps_page.dart
- **Added proper BlocProvider** in app router
- **Ensured proper state management** for map functionality


## 🙏 Acknowledgments

- [CoinGecko](https://www.coingecko.com/) for cryptocurrency data
- [Google Maps](https://developers.google.com/maps) for map functionality
- [Flutter](https://flutter.dev/) for the development framework
- [BLoC Pattern](https://bloclibrary.dev/) for state management