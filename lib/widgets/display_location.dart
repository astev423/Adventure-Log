import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String? _locationText;
  bool _loadingLocation = false;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _loadingLocation = true;
      _locationError = null;
    });

    try {
      final pos = await _getUserLocation();
      setState(() {
        _locationText =
            'Lat: ${pos.latitude.toStringAsFixed(6)}, Lng: ${pos.longitude.toStringAsFixed(6)}';
      });
    } catch (e) {
      setState(() {
        _locationError = e.toString();
        _locationText = null;
      });
    } finally {
      setState(() {
        _loadingLocation = false;
      });
    }
  }

  Future<Position> _getUserLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final locationWidget = _loadingLocation
        ? const CircularProgressIndicator()
        : _locationError != null
        ? Text('Location error: $_locationError')
        : Text(_locationText ?? 'No location yet');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _loadingLocation ? null : _fetchLocation,
            icon: const Icon(Icons.my_location),
            tooltip: 'Refresh location',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            locationWidget,
            const SizedBox(height: 24),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
