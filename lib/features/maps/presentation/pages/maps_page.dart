import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/features/maps/domain/entities/map_entity.dart';
import 'package:case_digital_wallet/features/maps/presentation/bloc/maps_bloc.dart';


class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  String _selectedFilter = 'all';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationPermissionDialog();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationPermissionDialog();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      // Load nearby locations
      if (mounted) {
        context.read<MapsBloc>().add(
              LoadNearbyLocations(
                latitude: position.latitude,
                longitude: position.longitude,
                radius: 5000, // 5km radius
              ),
            );
      }
    } catch (e) {
      // Si no se puede obtener la ubicación, usar Santa Cruz, Bolivia como fallback
      setState(() {
        _currentPosition = Position(
          latitude: -17.7833, // Santa Cruz, Bolivia
          longitude: -63.1833,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        _isLoading = false;
      });

      if (mounted) {
        context.read<MapsBloc>().add(
              LoadNearbyLocations(
                latitude: -17.7833, // Santa Cruz, Bolivia
                longitude: -63.1833,
                radius: 5000, // 5km radius
              ),
            );
      }
    }
  }

  void _loadMapMarkers() {
    if (_currentPosition != null) {
      context.read<MapsBloc>().add(
            LoadNearbyLocations(
              latitude: _currentPosition!.latitude,
              longitude: _currentPosition!.longitude,
              radius: 5000, // 5km radius
            ),
          );
    }
  }

  void _updateMarkers(List<MapLocationEntity> locations) {
    final Set<Marker> markers = {};
    
    // Agregar marcador de ubicación actual
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: const InfoWindow(
            title: 'Tu ubicación',
            snippet: 'Estás aquí',
          ),
        ),
      );
    }

    // Agregar marcadores de lugares
    for (final location in locations) {
      Color markerColor;
      String snippet;
      
      switch (location.type) {
        case 'crypto_payment':
          markerColor = Colors.green;
          snippet = 'Acepta pagos con crypto';
          break;
        case 'p2p_atm':
          markerColor = Colors.blue;
          snippet = 'Cajero P2P';
          break;
        case 'exchange_office':
          markerColor = Colors.orange;
          snippet = 'Casa de cambio';
          break;
        default:
          markerColor = Colors.grey;
          snippet = 'Lugar de crypto';
      }

      markers.add(
        Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(_getMarkerHue(markerColor)),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: snippet,
            onTap: () => _showLocationDetails(location),
          ),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  double _getMarkerHue(Color color) {
    if (color == Colors.green) return BitmapDescriptor.hueGreen;
    if (color == Colors.blue) return BitmapDescriptor.hueBlue;
    if (color == Colors.orange) return BitmapDescriptor.hueOrange;
    if (color == Colors.purple) return BitmapDescriptor.hueViolet;
    return BitmapDescriptor.hueRed;
  }

  void _showLocationDetails(MapLocationEntity location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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
                    color: _getLocationColor(location.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getLocationIcon(location.type),
                    color: _getLocationColor(location.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        location.address,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _getLocationDescription(location.type),
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _getDirections(location),
                    icon: const Icon(Icons.directions),
                    label: const Text('Cómo llegar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _contactLocation(location),
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

  Color _getLocationColor(String type) {
    switch (type) {
      case 'crypto_payment':
        return Colors.green;
      case 'p2p_atm':
        return Colors.blue;
      case 'exchange_office':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getLocationIcon(String type) {
    switch (type) {
      case 'crypto_payment':
        return Icons.payment;
      case 'p2p_atm':
        return Icons.atm;
      case 'exchange_office':
        return Icons.currency_exchange;
      default:
        return Icons.location_on;
    }
  }

  String _getLocationDescription(String type) {
    switch (type) {
      case 'crypto_payment':
        return 'Este establecimiento acepta pagos con criptomonedas. Puedes pagar con Bitcoin, Ethereum, USDT y otras cryptos populares.';
      case 'p2p_atm':
        return 'Cajero automático P2P donde puedes comprar y vender criptomonedas de forma segura. Disponible 24/7.';
      case 'exchange_office':
        return 'Casa de cambio especializada en criptomonedas. Ofrece servicios de compra, venta y cambio de cryptos.';
      default:
        return 'Lugar relacionado con criptomonedas.';
    }
  }

  void _getDirections(MapLocationEntity location) {
    // Abrir Google Maps con direcciones
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${location.latitude},${location.longitude}';
    // Aquí usarías url_launcher para abrir el enlace
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abriendo direcciones a ${location.name}')),
    );
  }

  void _contactLocation(MapLocationEntity location) {
    if (location.phone != null) {
      // Aquí usarías url_launcher para hacer la llamada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Llamando a ${location.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay número de teléfono disponible')),
      );
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permisos de ubicación'),
        content: const Text(
          'Esta app necesita acceso a tu ubicación para mostrar lugares cercanos donde puedes pagar con crypto.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _getCurrentLocation();
            },
            child: const Text('Permitir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapsBloc, MapsState>(
      listener: (context, state) {
        if (state is MapsLoaded) {
          _updateMarkers(state.locations);
        } else if (state is MapsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mapa Crypto'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/home'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: _goToCurrentLocation,
            ),
            IconButton(
              icon: const Icon(Icons.add_location),
              onPressed: () => _showAddLocationDialog(),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _currentPosition == null
                ? _buildLocationError()
                : _buildMapContent(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showFilterDialog(),
          child: const Icon(Icons.filter_list),
        ),
      ),
    );
  }

  Widget _buildLocationError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: AppTheme.errorColor,
          ),
          const SizedBox(height: 16),
          const Text(
            'No se pudo obtener tu ubicación',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _getCurrentLocation,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildMapContent() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 14,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
          },
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        ),
        _buildFilterChips(),
        _buildLegend(),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('all', 'Todos', Icons.map),
              _buildFilterChip('crypto_payment', 'Pagos', Icons.payment),
              _buildFilterChip('p2p_atm', 'Cajeros P2P', Icons.atm),
              _buildFilterChip('exchange_office', 'Casas de Cambio', Icons.currency_exchange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label, IconData icon) {
    final isSelected = _selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (selected) {
          setState(() => _selectedFilter = value);
          _applyFilter();
        },
        backgroundColor: Colors.grey[100],
        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
        checkmarkColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildLegend() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Leyenda',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            _buildLegendItem('🟢', 'Pagos con Crypto'),
            _buildLegendItem('🔵', 'Cajeros P2P'),
            _buildLegendItem('🟡', 'Casas de Cambio'),
            _buildLegendItem('🟣', 'Tu ubicación'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _goToCurrentLocation() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }

  void _showAddLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar ubicación'),
        content: const Text(
          '¿Quieres agregar una nueva ubicación donde se puede pagar con crypto?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/add-location');
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrar ubicaciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFilterOption('Todos los tipos', 'all'),
            _buildFilterOption('Solo pagos con crypto', 'crypto_payment'),
            _buildFilterOption('Solo cajeros P2P', 'p2p_atm'),
            _buildFilterOption('Solo casas de cambio', 'exchange_office'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _applyFilter();
                },
                child: const Text('Aplicar filtro'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String label, String value) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _selectedFilter,
      onChanged: (newValue) {
        setState(() => _selectedFilter = newValue!);
      },
    );
  }

  void _applyFilter() {
    if (_currentPosition != null) {
      context.read<MapsBloc>().add(
            FilterLocationsByType(
              type: _selectedFilter,
              latitude: _currentPosition!.latitude,
              longitude: _currentPosition!.longitude,
            ),
          );
    }
  }
} 