import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String _selectedFilter = 'all';
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // Mock transactions data
  final List<TransactionItem> _transactions = [
    TransactionItem(
      id: '1',
      type: 'deposit',
      title: 'Depósito',
      subtitle: 'Banco Nacional',
      amount: 500.00,
      currency: 'BS',
      status: 'completed',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isPositive: true,
    ),
    TransactionItem(
      id: '2',
      type: 'transfer_out',
      title: 'Envío a Juan Pérez',
      subtitle: '+591 12345678',
      amount: 150.00,
      currency: 'BS',
      status: 'completed',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isPositive: false,
    ),
    TransactionItem(
      id: '3',
      type: 'swap',
      title: 'Resguardo USDT',
      subtitle: 'Conversión BS → USDT',
      amount: 200.00,
      currency: 'BS',
      status: 'completed',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isPositive: false,
    ),
    TransactionItem(
      id: '4',
      type: 'transfer_in',
      title: 'Recibido de María García',
      subtitle: '+591 87654321',
      amount: 75.50,
      currency: 'BS',
      status: 'completed',
      date: DateTime.now().subtract(const Duration(days: 3)),
      isPositive: true,
    ),
    TransactionItem(
      id: '5',
      type: 'withdrawal',
      title: 'Retiro',
      subtitle: 'Transferencia bancaria',
      amount: 300.00,
      currency: 'BS',
      status: 'pending',
      date: DateTime.now().subtract(const Duration(days: 4)),
      isPositive: false,
    ),
  ];

  List<TransactionItem> get _filteredTransactions {
    if (_selectedFilter == 'all') return _transactions;
    return _transactions.where((t) => t.type == _selectedFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreTransactions();
    }
  }

  void _loadMoreTransactions() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('all', 'Todas'),
                _buildFilterChip('deposit', 'Depósitos'),
                _buildFilterChip('transfer_out', 'Enviados'),
                _buildFilterChip('transfer_in', 'Recibidos'),
                _buildFilterChip('withdrawal', 'Retiros'),
                _buildFilterChip('swap', 'Conversiones'),
              ],
            ),
          ),

          // Transactions list
          Expanded(
            child: _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        _filteredTransactions.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _filteredTransactions.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final transaction = _filteredTransactions[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = value);
        },
        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
        checkmarkColor: AppTheme.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionItem transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showTransactionDetails(transaction),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTransactionColor(transaction).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTransactionIcon(transaction),
                    color: _getTransactionColor(transaction),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              transaction.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            '${transaction.isPositive ? '+' : '-'}${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: transaction.isPositive
                                  ? AppTheme.successColor
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              transaction.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              _buildStatusChip(transaction.status),
                              const SizedBox(width: 8),
                              Text(
                                _formatDate(transaction.date),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;

    switch (status) {
      case 'completed':
        color = AppTheme.successColor;
        text = 'Completado';
        break;
      case 'pending':
        color = AppTheme.warningColor;
        text = 'Pendiente';
        break;
      case 'failed':
        color = AppTheme.errorColor;
        text = 'Fallido';
        break;
      default:
        color = AppTheme.textTertiary;
        text = 'Desconocido';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppTheme.textTertiary,
          ),
          SizedBox(height: 16),
          Text(
            'No hay transacciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tus transacciones aparecerán aquí',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(TransactionItem transaction) {
    switch (transaction.type) {
      case 'deposit':
        return Icons.arrow_downward;
      case 'transfer_out':
        return Icons.arrow_upward;
      case 'transfer_in':
        return Icons.arrow_downward;
      case 'withdrawal':
        return Icons.arrow_upward;
      case 'swap':
        return Icons.swap_horiz;
      default:
        return Icons.help_outline;
    }
  }

  Color _getTransactionColor(TransactionItem transaction) {
    switch (transaction.type) {
      case 'deposit':
      case 'transfer_in':
        return AppTheme.successColor;
      case 'transfer_out':
      case 'withdrawal':
        return AppTheme.errorColor;
      case 'swap':
        return AppTheme.primaryColor;
      default:
        return AppTheme.textTertiary;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return DateFormat('dd/MM').format(date);
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrar por tipo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFilterOption('all', 'Todas las transacciones'),
            _buildFilterOption('deposit', 'Depósitos'),
            _buildFilterOption('transfer_out', 'Transferencias enviadas'),
            _buildFilterOption('transfer_in', 'Transferencias recibidas'),
            _buildFilterOption('withdrawal', 'Retiros'),
            _buildFilterOption('swap', 'Conversiones'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String value, String label) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedFilter,
        onChanged: (String? newValue) {
          setState(() => _selectedFilter = newValue!);
          Navigator.pop(context);
        },
      ),
      onTap: () {
        setState(() => _selectedFilter = value);
        Navigator.pop(context);
      },
    );
  }

  void _showTransactionDetails(TransactionItem transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Transaction details
              const Text(
                'Detalles de la transacción',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              _buildDetailRow('ID', transaction.id),
              _buildDetailRow('Tipo', transaction.title),
              _buildDetailRow('Descripción', transaction.subtitle),
              _buildDetailRow('Monto',
                  '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}'),
              _buildDetailRow('Estado', transaction.status),
              _buildDetailRow('Fecha',
                  DateFormat('dd/MM/yyyy HH:mm').format(transaction.date)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem {
  final String id;
  final String type;
  final String title;
  final String subtitle;
  final double amount;
  final String currency;
  final String status;
  final DateTime date;
  final bool isPositive;

  TransactionItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.currency,
    required this.status,
    required this.date,
    required this.isPositive,
  });
}
