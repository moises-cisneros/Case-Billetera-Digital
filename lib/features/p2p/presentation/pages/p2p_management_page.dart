import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';

class P2PManagementPage extends StatefulWidget {
  const P2PManagementPage({super.key});

  @override
  State<P2PManagementPage> createState() => _P2PManagementPageState();
}

class _P2PManagementPageState extends State<P2PManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión P2P'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateTransactionDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mis Transacciones'),
            Tab(text: 'Cajeros P2P'),
            Tab(text: 'Historial'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyTransactionsTab(),
          _buildP2PAtmsTab(),
          _buildHistoryTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _tabController.animateTo(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transacciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.atm),
            label: 'Cajeros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }

  Widget _buildMyTransactionsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTransactionCard(
          'Compra BTC',
          'Juan Pérez',
          '0.001 BTC',
          'Bs 450',
          'completed',
          Icons.trending_up,
          Colors.green,
        ),
        _buildTransactionCard(
          'Venta USDT',
          'María García',
          '100 USDT',
          'Bs 690',
          'pending',
          Icons.trending_down,
          Colors.orange,
        ),
        _buildTransactionCard(
          'Compra ETH',
          'Carlos López',
          '0.01 ETH',
          'Bs 320',
          'cancelled',
          Icons.trending_up,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildP2PAtmsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAtmCard(
          'Juan Pérez',
          'Zona Sur, La Paz',
          '4.8 ⭐ (156 transacciones)',
          'BTC, ETH, USDT',
          '6.95 Bs/USD',
          '2.0%',
          true,
        ),
        _buildAtmCard(
          'María García',
          'Sopocachi, La Paz',
          '4.9 ⭐ (234 transacciones)',
          'BTC, ETH, USDT',
          '6.93 Bs/USD',
          '1.5%',
          true,
        ),
        _buildAtmCard(
          'Crypto ATM Plaza Mayor',
          'Centro, La Paz',
          '4.0 ⭐ (89 transacciones)',
          'BTC, ETH, USDT',
          '6.98 Bs/USD',
          '3.0%',
          false,
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHistoryCard(
          'Compra BTC',
          '2024-01-15 14:30',
          '0.002 BTC',
          'Bs 900',
          'completed',
        ),
        _buildHistoryCard(
          'Venta USDT',
          '2024-01-14 10:15',
          '50 USDT',
          'Bs 345',
          'completed',
        ),
        _buildHistoryCard(
          'Compra ETH',
          '2024-01-13 16:45',
          '0.005 ETH',
          'Bs 160',
          'completed',
        ),
      ],
    );
  }

  Widget _buildTransactionCard(
    String type,
    String counterparty,
    String cryptoAmount,
    String fiatAmount,
    String status,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(type),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Con: $counterparty'),
            Text('$cryptoAmount • $fiatAmount'),
          ],
        ),
        trailing: _buildStatusChip(status),
        onTap: () => _showTransactionDetails(type, counterparty, cryptoAmount, fiatAmount, status),
      ),
    );
  }

  Widget _buildAtmCard(
    String name,
    String location,
    String rating,
    String cryptos,
    String rate,
    String fee,
    bool isOnline,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(name[0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(location),
                      Text(rating),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isOnline ? 'En línea' : 'Desconectado',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cryptos aceptadas:'),
                    Text(cryptos),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Tipo de cambio:'),
                    Text(rate),
                    Text('Comisión: $fee'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _contactAtm(name),
                    child: const Text('Contactar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _startTransaction(name),
                    child: const Text('Transaccionar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    String type,
    String date,
    String cryptoAmount,
    String fiatAmount,
    String status,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          type.contains('Compra') ? Icons.trending_up : Icons.trending_down,
          color: type.contains('Compra') ? Colors.green : Colors.red,
        ),
        title: Text(type),
        subtitle: Text('$date • $cryptoAmount • $fiatAmount'),
        trailing: _buildStatusChip(status),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    
    switch (status) {
      case 'completed':
        color = Colors.green;
        text = 'Completado';
        break;
      case 'pending':
        color = Colors.orange;
        text = 'Pendiente';
        break;
      case 'cancelled':
        color = Colors.red;
        text = 'Cancelado';
        break;
      default:
        color = Colors.grey;
        text = 'Desconocido';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }

  void _showCreateTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Transacción P2P'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('¿Qué tipo de transacción quieres realizar?'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showBuyDialog();
                    },
                    icon: const Icon(Icons.trending_up),
                    label: const Text('Comprar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showSellDialog();
                    },
                    icon: const Icon(Icons.trending_down),
                    label: const Text('Vender'),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showBuyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comprar Crypto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Crypto'),
              items: ['BTC', 'ETH', 'USDT', 'BNB'].map((crypto) {
                return DropdownMenuItem(value: crypto, child: Text(crypto));
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Monto en Bs'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transacción iniciada')),
              );
            },
            child: const Text('Buscar vendedor'),
          ),
        ],
      ),
    );
  }

  void _showSellDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vender Crypto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Crypto'),
              items: ['BTC', 'ETH', 'USDT', 'BNB'].map((crypto) {
                return DropdownMenuItem(value: crypto, child: Text(crypto));
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Oferta publicada')),
              );
            },
            child: const Text('Publicar oferta'),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(String type, String counterparty, String cryptoAmount, String fiatAmount, String status) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles de Transacción',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Tipo', type),
            _buildDetailRow('Contraparte', counterparty),
            _buildDetailRow('Cantidad Crypto', cryptoAmount),
            _buildDetailRow('Monto Fiat', fiatAmount),
            _buildDetailRow('Estado', status),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cerrar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Acción adicional
                    },
                    child: const Text('Ver Chat'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  void _contactAtm(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contactando a $name...')),
    );
  }

  void _startTransaction(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Iniciando transacción con $name...')),
    );
  }
} 