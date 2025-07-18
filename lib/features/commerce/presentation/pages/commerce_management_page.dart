import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';

class CommerceManagementPage extends StatefulWidget {
  const CommerceManagementPage({super.key});

  @override
  State<CommerceManagementPage> createState() => _CommerceManagementPageState();
}

class _CommerceManagementPageState extends State<CommerceManagementPage>
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
        title: const Text('Gestión Comercial'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business),
            onPressed: () => _showRegisterBusinessDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mis Negocios'),
            Tab(text: 'Establecimientos'),
            Tab(text: 'Transacciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyBusinessesTab(),
          _buildEstablishmentsTab(),
          _buildTransactionsTab(),
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
            icon: Icon(Icons.business),
            label: 'Mis Negocios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Establecimientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transacciones',
          ),
        ],
      ),
    );
  }

  Widget _buildMyBusinessesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBusinessCard(
          'El Fogón',
          'Restaurante',
          'Calle Sagárnaga 456, La Paz',
          '4.6 ⭐ (78 reseñas)',
          'BTC, ETH, USDT',
          'Bs 20 - Bs 2000',
          true,
          'active',
        ),
        _buildBusinessCard(
          'Digital Store',
          'Tienda de Tecnología',
          'Calle Linares 321, La Paz',
          '4.1 ⭐ (42 reseñas)',
          'BTC, ETH, USDT',
          'Bs 25 - Bs 3000',
          true,
          'active',
        ),
        _buildBusinessCard(
          'Coffee & Crypto',
          'Café',
          'Av. 6 de Agosto 789, La Paz',
          '4.4 ⭐ (56 reseñas)',
          'BTC, ETH, USDT',
          'Bs 10 - Bs 1000',
          false,
          'pending',
        ),
      ],
    );
  }

  Widget _buildEstablishmentsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEstablishmentCard(
          'Restaurante Crypto - El Fogón',
          'Restaurante gourmet que acepta pagos con criptomonedas',
          'Calle Sagárnaga 456, La Paz',
          '4.6 ⭐ (78 reseñas)',
          'BTC, ETH, USDT',
          'Bs 20 - Bs 2000',
          true,
          'restaurant',
        ),
        _buildEstablishmentCard(
          'Café Bitcoin - Coffee & Crypto',
          'Café que acepta pagos con Bitcoin, USDT y otras criptomonedas',
          'Av. 6 de Agosto 789, La Paz',
          '4.4 ⭐ (56 reseñas)',
          'BTC, ETH, USDT',
          'Bs 10 - Bs 1000',
          true,
          'cafe',
        ),
        _buildEstablishmentCard(
          'Tienda Crypto - Digital Store',
          'Tienda de tecnología que acepta pagos en crypto',
          'Calle Linares 321, La Paz',
          '4.1 ⭐ (42 reseñas)',
          'BTC, ETH, USDT',
          'Bs 25 - Bs 3000',
          true,
          'retail',
        ),
        _buildEstablishmentCard(
          'Bar Crypto - The Bitcoin Pub',
          'Bar que acepta pagos con Bitcoin',
          'Calle Jaén 987, La Paz',
          '4.3 ⭐ (67 reseñas)',
          'BTC, ETH, USDT',
          'Bs 15 - Bs 1500',
          true,
          'bar',
        ),
        _buildEstablishmentCard(
          'Hotel Crypto - Digital Inn',
          'Hotel que acepta reservas con criptomonedas',
          'Av. Arce 111, La Paz',
          '4.5 ⭐ (123 reseñas)',
          'BTC, ETH, USDT',
          'Bs 50 - Bs 5000',
          true,
          'hotel',
        ),
      ],
    );
  }

  Widget _buildTransactionsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTransactionCard(
          'Pago en El Fogón',
          '2024-01-15 19:30',
          '0.0001 BTC',
          'Bs 45',
          'completed',
          'restaurant',
        ),
        _buildTransactionCard(
          'Compra en Digital Store',
          '2024-01-14 15:20',
          '50 USDT',
          'Bs 345',
          'completed',
          'retail',
        ),
        _buildTransactionCard(
          'Café en Coffee & Crypto',
          '2024-01-13 10:45',
          '0.00005 ETH',
          'Bs 8',
          'completed',
          'cafe',
        ),
        _buildTransactionCard(
          'Reserva en Digital Inn',
          '2024-01-12 14:15',
          '0.001 BTC',
          'Bs 450',
          'pending',
          'hotel',
        ),
      ],
    );
  }

  Widget _buildBusinessCard(
    String name,
    String type,
    String address,
    String rating,
    String cryptos,
    String amountRange,
    bool isOpen,
    String status,
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getBusinessIcon(type),
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
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
                          fontSize: 18,
                        ),
                      ),
                      Text(type),
                      Text(address),
                      Text(rating),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isOpen ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isOpen ? 'Abierto' : 'Cerrado',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusChip(status),
                  ],
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
                    const Text('Rango de pagos:'),
                    Text(amountRange),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _editBusiness(name),
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _viewAnalytics(name),
                    child: const Text('Analytics'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstablishmentCard(
    String name,
    String description,
    String address,
    String rating,
    String cryptos,
    String amountRange,
    bool isOpen,
    String type,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getBusinessColor(type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getBusinessIcon(type),
            color: _getBusinessColor(type),
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(address),
            Text('$rating • $cryptos • $amountRange'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isOpen ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isOpen ? 'Abierto' : 'Cerrado',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            const SizedBox(height: 4),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
          ],
        ),
        onTap: () => _showEstablishmentDetails(name, description, address, rating, cryptos, amountRange, type),
      ),
    );
  }

  Widget _buildTransactionCard(
    String description,
    String date,
    String cryptoAmount,
    String fiatAmount,
    String status,
    String type,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getBusinessColor(type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getBusinessIcon(type),
            color: _getBusinessColor(type),
          ),
        ),
        title: Text(description),
        subtitle: Text('$date • $cryptoAmount • $fiatAmount'),
        trailing: _buildStatusChip(status),
        onTap: () => _showTransactionDetails(description, date, cryptoAmount, fiatAmount, status),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    
    switch (status) {
      case 'active':
        color = Colors.green;
        text = 'Activo';
        break;
      case 'pending':
        color = Colors.orange;
        text = 'Pendiente';
        break;
      case 'completed':
        color = Colors.green;
        text = 'Completado';
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10),
      ),
    );
  }

  IconData _getBusinessIcon(String type) {
    switch (type) {
      case 'restaurant':
        return Icons.restaurant;
      case 'cafe':
        return Icons.coffee;
      case 'retail':
        return Icons.shopping_bag;
      case 'bar':
        return Icons.local_bar;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.business;
    }
  }

  Color _getBusinessColor(String type) {
    switch (type) {
      case 'restaurant':
        return Colors.orange;
      case 'cafe':
        return Colors.brown;
      case 'retail':
        return Colors.blue;
      case 'bar':
        return Colors.purple;
      case 'hotel':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _showRegisterBusinessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar Negocio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre del negocio'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Tipo de negocio'),
              items: ['Restaurante', 'Café', 'Tienda', 'Bar', 'Hotel', 'Otro'].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Dirección'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
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
                const SnackBar(content: Text('Negocio registrado exitosamente')),
              );
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }

  void _editBusiness(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editando $name...')),
    );
  }

  void _viewAnalytics(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abriendo analytics de $name...')),
    );
  }

  void _showEstablishmentDetails(String name, String description, String address, String rating, String cryptos, String amountRange, String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getBusinessColor(type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getBusinessIcon(type),
                    color: _getBusinessColor(type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(rating),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(description),
            const SizedBox(height: 8),
            Text(address),
            const SizedBox(height: 8),
            Text('Cryptos: $cryptos'),
            Text('Rango: $amountRange'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _getDirections(address),
                    icon: const Icon(Icons.directions),
                    label: const Text('Cómo llegar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _contactBusiness(name),
                    icon: const Icon(Icons.phone),
                    label: const Text('Contactar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(String description, String date, String cryptoAmount, String fiatAmount, String status) {
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
            _buildDetailRow('Descripción', description),
            _buildDetailRow('Fecha', date),
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
                    child: const Text('Ver Recibo'),
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

  void _getDirections(String address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abriendo direcciones a $address')),
    );
  }

  void _contactBusiness(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contactando a $name...')),
    );
  }
} 