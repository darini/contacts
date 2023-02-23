import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/geolocation.repository.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class AddressView extends StatefulWidget {
  final ContactModel contactModel;
  const AddressView({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final GeolocationRepository _addressRepository = GeolocationRepository();
  final ContactRepository _contactRepository = ContactRepository();

  late final GoogleMapController mapController;
  LatLng _coordinates = const LatLng(45.521563, -122.677433);
  Set<Marker>? markers;

  @override
  initState() {
    super.initState();
    if (widget.contactModel.latLng != null &&
        widget.contactModel.latLng != "") {
      var values = widget.contactModel.latLng?.split(',');

      _coordinates = LatLng(
        double.parse(values![0]),
        double.parse(values[1]),
      );
    }
  }

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setMapPosition(
      widget.contactModel.addressLine1,
      widget.contactModel.addressLine2,
    );
  }

  onSearch(String address) {
    _addressRepository.searchAddress(address).then((data) {
      _coordinates = LatLng(
        data.latitude,
        data.longitude,
      );

      widget.contactModel.addressLine1 = data.longName;
      widget.contactModel.addressLine2 = data.formattedAddress;
      widget.contactModel.latLng = '${data.latitude}, ${data.longitude}';

      setMapPosition(
        data.longName,
        data.formattedAddress,
      );
    }).catchError((onError) {
      print(onError);
    });
  }

  setMapPosition(title, snnipet) {
    mapController.animateCamera(
      CameraUpdate.newLatLng(
        _coordinates,
      ),
    );

    markers = <Marker>{};

    final uuid = Uuid();
    Marker marker = Marker(
      markerId: MarkerId(uuid.v4()),
      position: _coordinates,
      infoWindow: InfoWindow(
        title: title,
        snippet: snnipet,
      ),
    );

    markers?.add(marker);
    setState(() {});
  }

  setCurrentLocation() async {
    try {
      await checkLocationPermission();

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _coordinates = LatLng(
        position.latitude,
        position.longitude,
      );

      setMapPosition('Posição atual', 'Endereço não encontrado');
    } catch (error) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Erro'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }

  checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        throw 'Localização não está disponível';
      }
    }
  }

  updateContact() {
    _contactRepository.update(widget.contactModel).then((_) {
      onSuccess();
    }).catchError((onError) {
      onError();
    });
  }

  onSuccess() {
    Navigator.pop(context);
  }

  onError() {
    SnackBar snackBar = const SnackBar(
      content: Text('Ops, algo deu errado'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Endereço do Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: updateContact,
            child: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: ListTile(
              title: const Text(
                "Endereço atual",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.contactModel.addressLine1 ??
                        'Nenhum endereço cadastrado',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.contactModel.addressLine2 ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Pesquisar...",
                ),
                onSubmitted: (value) {
                  onSearch(value);
                },
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _coordinates,
                zoom: 11.0,
              ),
              markers: markers ?? <Marker>{},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setCurrentLocation();
        },
        child: const Icon(
          Icons.my_location,
        ),
      ),
    );
  }
}
