import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/location/location_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GmapScreen extends StatefulWidget {
  final double lat;
  final double long;

  const GmapScreen({
    Key? key,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  State<GmapScreen> createState() => _GmapScreenState();
}

class _GmapScreenState extends State<GmapScreen> {
  final TextEditingController addressController = TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  void _createInitialMarker() {
    final marker = Marker(
      markerId: const MarkerId("position"),
      position: LatLng(widget.lat, widget.long),
    );

    _markers.add(marker);
  }

  void setNewMarker({required double lat, required double long}) async {
    _markers.clear();
    final marker = Marker(
      markerId: const MarkerId("position"),
      position: LatLng(lat, long),
    );

    _markers.add(marker);

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, long), 15),
    );

    setState(() {
      context
          .read<LocationBloc>()
          .add(LocationEvent.getSelectPosition(lat, long));
    });
  }

  void mapController(GoogleMapController value) {
    _mapController = value;
  }

  @override
  void initState() {
    _createInitialMarker();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Lokasi'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_box),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.long),
            ),
            markers: _markers,
            onMapCreated: (controller) {
              mapController(controller);
            },
            onTap: (argument) {
              setNewMarker(
                lat: argument.latitude,
                long: argument.longitude,
              );
            },
          ),
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Text('No Address'),
                loaded: (model) {
                  return Text(model.address ?? '');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
