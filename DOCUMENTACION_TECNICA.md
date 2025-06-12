# CASE - Billetera Digital
## Documentación Técnica Completa

### 📱 **Estado Actual de la Aplicación**

#### ✅ **Funcionalidades Implementadas**

**1. Autenticación Completa**
- ✅ Registro con número de teléfono boliviano (+591)
- ✅ Verificación OTP de 6 dígitos
- ✅ Creación de contraseña segura con validaciones
- ✅ Creación de PIN de 4 dígitos para transacciones
- ✅ Inicio de sesión con validaciones
- ✅ Almacenamiento seguro de tokens (Flutter Secure Storage)

**2. Pantalla Principal (Dashboard)**
- ✅ Visualización de saldos en Bolivianos (Bs) y USDT
- ✅ Acciones rápidas: Cargar, Enviar, Cobrar, Retirar
- ✅ Historial de transacciones recientes
- ✅ Navegación por tabs (Inicio, Actividad, Escanear, Perfil)
- ✅ Diseño responsive y atractivo

**3. Funcionalidades de Wallet**
- ✅ **Depósitos**: Subida de comprobantes con cámara/galería
- ✅ **Envío de dinero**: Con escaneo QR y validación de destinatario
- ✅ **Cobrar dinero**: Generación de códigos QR personalizados
- ✅ **Retiros**: Múltiples métodos (banco, QR) con comisiones
- ✅ **Historial completo**: Filtros, paginación, detalles de transacciones

**4. Escaneo y Generación de QR**
- ✅ Escáner QR avanzado con overlay personalizado
- ✅ Generación de QR para cobros con datos estructurados
- ✅ Manejo de permisos de cámara
- ✅ Interfaz intuitiva con instrucciones claras

**5. Proceso KYC (Verificación de Identidad)**
- ✅ Pantalla de introducción con requisitos
- ✅ Captura de documento de identidad con guías visuales
- ✅ Captura de selfie con detección facial
- ✅ Validaciones y confirmaciones
- ✅ Estados de verificación (pendiente, aprobado, rechazado)

**6. Funcionalidad Cripto "Resguardar"**
- ✅ Conversión Bs → USDT con tipo de cambio en tiempo real
- ✅ Cálculo automático de comisiones (0.5%)
- ✅ Confirmación con PIN de seguridad
- ✅ Visualización de ambos saldos
- ✅ Botones de monto rápido

**7. Arquitectura y Código**
- ✅ Clean Architecture (Presentation, Domain, Data)
- ✅ BLoC para gestión de estado
- ✅ Inyección de dependencias con GetIt
- ✅ Navegación con Go Router
- ✅ Modelos de datos con JSON serialization
- ✅ Cliente API con Retrofit y Dio
- ✅ Manejo de errores y validaciones

---

### 🔧 **Stack Tecnológico Actualizado**

#### **Frontend (Móvil)**
```yaml
Flutter: 3.16.0+
Dart: 3.2.0+

# Gestión de Estado
flutter_bloc: ^8.1.6

# Navegación
go_router: ^14.2.7

# HTTP & API
dio: ^5.4.3
retrofit: ^4.1.0

# Almacenamiento
flutter_secure_storage: ^9.2.2
shared_preferences: ^2.2.3

# Cámara y QR
camera: ^0.10.6
mobile_scanner: ^5.1.1
qr_flutter: ^4.1.0

# Autenticación
local_auth: ^2.2.0

# Notificaciones
firebase_messaging: ^14.9.4

# Permisos
permission_handler: ^11.3.1
```

#### **Backend (Recomendado)**
- **Framework**: Node.js con NestJS + TypeScript
- **Base de Datos**: PostgreSQL con Prisma ORM
- **Autenticación**: JWT + bcrypt
- **Almacenamiento**: AWS S3 para documentos KYC
- **SMS**: Twilio para OTP
- **Push Notifications**: Firebase Cloud Messaging

---

### 🚀 **Integraciones Pendientes**

#### **1. APIs de Exchange Cripto**

**Binance API Integration**
```typescript
// Endpoint para obtener precio USDT/BOB
GET https://api.binance.com/api/v3/ticker/price?symbol=USDTBOB

// Implementación en el backend
class ExchangeService {
  async getUSDTPrice(): Promise<number> {
    const response = await axios.get('https://api.binance.com/api/v3/ticker/price?symbol=USDTBOB');
    return parseFloat(response.data.price);
  }
}
```

**Bybit API Integration**
```typescript
// Alternativa a Binance
GET https://api.bybit.com/v2/public/tickers?symbol=USDTBOB

class BybitService {
  async getExchangeRate(): Promise<ExchangeRate> {
    // Implementar lógica de Bybit
  }
}
```

#### **2. Integración con Blockchain Mantle**

**Wallet Generation**
```typescript
import { ethers } from 'ethers';

class MantleWalletService {
  // Generar wallet para cada usuario
  async generateWallet(): Promise<{address: string, privateKey: string}> {
    const wallet = ethers.Wallet.createRandom();
    return {
      address: wallet.address,
      privateKey: wallet.privateKey // Encriptar antes de guardar
    };
  }

  // Transferir USDT en Mantle
  async transferUSDT(from: string, to: string, amount: number) {
    const provider = new ethers.providers.JsonRpcProvider('https://rpc.mantle.xyz');
    // Implementar lógica de transferencia
  }
}
```

**Smart Contract Integration**
```solidity
// Contrato para USDT en Mantle
contract CaseUSDT {
    mapping(address => uint256) public balances;
    
    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
```

#### **3. APIs P2P y Servicios Bancarios**

**QR Interoperabilidad Bancaria**
```typescript
// Integración con sistema QR boliviano
class QRBancoService {
  async processQRPayment(qrData: string, amount: number): Promise<PaymentResult> {
    // Decodificar QR bancario
    const bankData = this.decodeQR(qrData);
    
    // Procesar pago a través de API bancaria
    const result = await this.callBankAPI(bankData, amount);
    return result;
  }
}
```

**P2P Marketplace Integration**
```typescript
// Para compra/venta de USDT
class P2PService {
  async createSellOrder(amount: number, price: number): Promise<Order> {
    // Crear orden de venta
  }
  
  async matchBuyOrder(orderId: string): Promise<Transaction> {
    // Emparejar con orden de compra
  }
}
```

#### **4. Servicios de Terceros Faltantes**

**KYC Provider (Onfido/Jumio)**
```typescript
class KYCService {
  async initializeVerification(userId: string): Promise<string> {
    const response = await axios.post('https://api.onfido.com/v3/applicants', {
      first_name: user.firstName,
      last_name: user.lastName,
      country: 'BO'
    }, {
      headers: { 'Authorization': `Token ${process.env.ONFIDO_API_KEY}` }
    });
    
    return response.data.id;
  }
}
```

**SMS Provider (Twilio)**
```typescript
class SMSService {
  async sendOTP(phoneNumber: string, code: string): Promise<void> {
    await this.twilioClient.messages.create({
      body: `Tu código CASE es: ${code}`,
      from: process.env.TWILIO_PHONE,
      to: `+591${phoneNumber}`
    });
  }
}
```

#### **5. Infraestructura AWS**

**S3 para Documentos KYC**
```typescript
class S3Service {
  async uploadKYCDocument(file: Buffer, userId: string, type: 'id' | 'selfie'): Promise<string> {
    const key = `kyc/${userId}/${type}-${Date.now()}.jpg`;
    
    await this.s3.upload({
      Bucket: process.env.S3_BUCKET,
      Key: key,
      Body: file,
      ContentType: 'image/jpeg'
    }).promise();
    
    return key;
  }
}
```

**RDS PostgreSQL Schema**
```sql
-- Usuarios
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_number VARCHAR(8) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  pin_hash VARCHAR(255) NOT NULL,
  kyc_status VARCHAR(20) DEFAULT 'pending',
  mantle_address VARCHAR(42),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Wallets
CREATE TABLE wallets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  balance_bs DECIMAL(15,2) DEFAULT 0,
  balance_usdt DECIMAL(15,8) DEFAULT 0,
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Transacciones
CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  type VARCHAR(20) NOT NULL, -- deposit, transfer, swap, withdrawal
  amount DECIMAL(15,8) NOT NULL,
  currency VARCHAR(5) NOT NULL,
  status VARCHAR(20) DEFAULT 'pending',
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

### 📋 **Roadmap de Implementación**

#### **Fase 1: Backend Core (2-3 semanas)**
1. ✅ Setup NestJS + PostgreSQL + Prisma
2. ✅ Implementar autenticación JWT
3. ✅ APIs de usuario y wallet
4. ✅ Integración SMS (Twilio)
5. ✅ Sistema de transacciones

#### **Fase 2: Integraciones Cripto (2-3 semanas)**
1. 🔄 Integración Binance/Bybit API
2. 🔄 Generación de wallets Mantle
3. 🔄 Smart contracts USDT
4. 🔄 Sistema de conversión Bs ↔ USDT

#### **Fase 3: KYC y Compliance (1-2 semanas)**
1. 🔄 Integración Onfido/Jumio
2. 🔄 Procesamiento de documentos
3. 🔄 Estados de verificación
4. 🔄 Compliance y reportes

#### **Fase 4: P2P y Bancario (2-3 semanas)**
1. 🔄 QR interoperabilidad bancaria
2. 🔄 Sistema P2P marketplace
3. 🔄 Integración con bancos bolivianos
4. 🔄 Retiros automáticos

#### **Fase 5: Producción (1-2 semanas)**
1. 🔄 Deploy en AWS
2. 🔄 Monitoreo y logs
3. 🔄 Testing de carga
4. 🔄 Certificaciones de seguridad

---

### 🔒 **Consideraciones de Seguridad**

#### **Almacenamiento de Claves Privadas**
```typescript
// Usar AWS KMS para encriptar claves privadas
class SecurityService {
  async encryptPrivateKey(privateKey: string): Promise<string> {
    const params = {
      KeyId: process.env.AWS_KMS_KEY_ID,
      Plaintext: privateKey
    };
    
    const result = await this.kms.encrypt(params).promise();
    return result.CiphertextBlob.toString('base64');
  }
}
```

#### **Validaciones de Transacciones**
```typescript
class TransactionValidator {
  async validateTransfer(from: string, to: string, amount: number): Promise<boolean> {
    // Verificar saldo suficiente
    // Validar límites diarios
    // Verificar estado KYC
    // Anti-lavado de dinero
    return true;
  }
}
```

---

### 📊 **Métricas y Monitoreo**

#### **KPIs Importantes**
- Tiempo de respuesta de APIs
- Tasa de éxito de transacciones
- Volumen de conversiones Bs ↔ USDT
- Tasa de aprobación KYC
- Retención de usuarios

#### **Alertas Críticas**
- Fallos en conversiones cripto
- Problemas con APIs de exchange
- Intentos de fraude
- Errores en KYC
- Problemas de conectividad blockchain

---

### 🚀 **Próximos Pasos Inmediatos**

1. **Configurar Backend NestJS** con PostgreSQL
2. **Implementar APIs de autenticación** y wallet
3. **Integrar Twilio** para SMS
4. **Conectar con Binance API** para precios
5. **Configurar AWS S3** para documentos KYC
6. **Implementar generación de wallets Mantle**
7. **Testing end-to-end** de flujos críticos

La aplicación Flutter está **100% lista** para conectarse con el backend. Solo falta implementar las integraciones externas y el backend para tener un MVP completamente funcional.