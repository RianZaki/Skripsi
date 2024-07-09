import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/report-rubbish/report_rubbish_screen.dart';
import 'package:recything_mobile/screens/report/report_littering/pelanggaran_besar_screen.dart';
import 'package:recything_mobile/screens/report/report_littering/pelanggaran_kecil_screen.dart';
import 'package:recything_mobile/screens/report/widget/main_button_widget.dart';
import 'package:recything_mobile/screens/report/widget/text_field_report.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class MapsReportScreen extends StatefulWidget {
  final String reportType;
  const MapsReportScreen({Key? key, required this.reportType})
      : super(key: key);

  @override
  State<MapsReportScreen> createState() => _MapsReportScreenState();
}

final String kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? "no-key";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MapsReportScreenState extends State<MapsReportScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  TextEditingController _searchController = TextEditingController();

  LatLng _markerPosition = LatLng(0, 0);

  Completer<GoogleMapController> _controller = Completer();

  Position? _currentPosition;
  String? _currentAddress;
  String? _selectedLocationAddress;
  bool _isFromFloatingActionButton = false;

  /// Mendapatkan lokasi saat ini dengan izin lokasi
  Future<void> _getCurrentPosition() async {
    PermissionStatus status = await _handleLocationPermission(context);

    if (status == PermissionStatus.granted) {
      try {
        /// Mendaparkan posisi saat ini (geolocator)
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _currentPosition = position;
          print('halo1 ${_currentPosition?.latitude}');

          _getAddress(position); // get alamat saat ini
        });

        /// Menganimasikan kamera ke lokasi saat ini
        if (_controller.isCompleted) {
          final controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude),
            ),
          );
        }
      } catch (e) {
        print('Error getting location: $e');
      }
    }
  }

  /// Izin Lokasi
  Future<PermissionStatus> _handleLocationPermission(
      BuildContext context) async {
    PermissionStatus status = await Permission.location.request();

    /// Jika izin di tolak
    if (status == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          content: Text(
              'Izin lokasi ditolak. Aktifkan izin di pengaturan aplikasi.'),
        ),
      );

      /// Jika izin ditolak permanen
    } else if (status == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          content: Text(
              'Izin lokasi ditolak secara permanen. Buka pengaturan aplikasi untuk mengaktifkan izin.'),
        ),
      );

      /// Jika izin hanya sekali
    } else if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          content: Text('Izin lokasi diberikan.'),
        ),
      );
    }

    return status;
  }

  /// Mendapatkan alamat dari posisi
  Future<void> _getAddress(Position position) async {
    try {
      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then(
        (List<Placemark> listPlacemark) {
          setState(
            () {
              Placemark placemark = listPlacemark.first;
              _currentAddress =
                  '${placemark.thoroughfare}, ${placemark.subThoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
              // _updateMarker(position);
            },
          );
          _selectedLocationAddress = _currentAddress;
          Logger().e(_currentAddress);
          Logger().e(_markerPosition);
        },
      );
    } catch (e) {}
  }

  /// Memperbarui alamat dan navigasi ke halaman berikutnya
  Future<void> _updateAddress() async {
    if (_isFromFloatingActionButton) {
      _selectedLocationAddress =
          'FloatingActionButton: ${_currentAddress ?? ''}';
    } else {
      _selectedLocationAddress ??= _currentAddress;

      Navigator.of(context).pop();
      if (widget.reportType == 'rubbish') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ReportRubbishScreen(
              locationAddress: _selectedLocationAddress,
              latitude: selectedLat == null
                  ? _currentPosition?.latitude.toString()
                  : selectedLat.toString(),
              longitude: selectedLng == null
                  ? _currentPosition?.longitude.toString()
                  : selectedLng.toString(),
            ),
          ),
        );
      } else if (widget.reportType == 'littering') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LitteringKecilScreen(
              locationAddress: _selectedLocationAddress,
              latitude: selectedLat == null
                  ? _currentPosition?.latitude.toString()
                  : selectedLat.toString(),
              longitude: selectedLng == null
                  ? _currentPosition?.longitude.toString()
                  : selectedLng.toString(),
            ),
          ),
        );
      } else if (widget.reportType == 'littering-besar') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LitteringBesarScreen(
              locationAddress: _selectedLocationAddress,
              latitude: selectedLat == null
                  ? _currentPosition?.latitude.toString()
                  : selectedLat.toString(),
              longitude: selectedLng == null
                  ? _currentPosition?.longitude.toString()
                  : selectedLng.toString(),
            ),
          ),
        );
      }
    }
  }

  /// Memilih marker pada peta
  void _selectMarker(String markerId) {
    setState(
      () {
        if (markerId.isNotEmpty) {
        } else {
          _addCurrentLocationMarker();
        }
      },
    );
  }

  /// Menggerakkan kamera ke lokasi saat ini pada peta
  void _goToCurrentPosition() {
    _controller.future.then(
      (controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              _currentPosition?.latitude ?? 0.0,
              _currentPosition?.longitude ?? 0.0,
            ),
          ),
        );
        _addCurrentLocationMarker();
        setState(() {});
      },
    );
  }

  void _addCurrentLocationMarker() {
    print('adding marker at current location');
    setState(() {
      markersList.clear();
      final marker = Marker(
        markerId: const MarkerId('CurrentLocation'),
        position: LatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
      );
      markersList.add(marker);
    });
  }

  double? selectedLat;
  double? selectedLng;
  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    try {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);

      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      selectedLat = lat;
      selectedLng = lng;

      markersList.clear();
      markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
      ));

      setState(() {});

      googleMapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18.0),
      );

      // Update selected address
      _selectedLocationAddress =
          '${detail.result.name}, ${detail.result.formattedAddress}';
      _isFromFloatingActionButton = false;

      // Log the latitude and longitude
      print('Selected Location: $lat, $lng');
    } catch (error) {
      print('Error fetching place details: $error');
    }
  }

  @override
  void initState() {
    _getCurrentPosition();
    print('halo${_currentPosition?.latitude}');
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Menyimpan marker pada peta
  Set<Marker> markersList = {};

  @override
  Widget build(BuildContext context) {
    bool isNextButtonEnabled = _markerPosition.latitude != 0 ||
        (markersList.isNotEmpty && markersList.first.position.latitude != 0);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: _currentPosition != null
                  ? CameraPosition(
                      zoom: 18,
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                    )
                  : const CameraPosition(target: LatLng(0.0, 0.0), zoom: 18),
              markers: _markerPosition.latitude != 0
                  ? <Marker>[
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: _markerPosition,
                        draggable: true,
                        onDragEnd: (newPosition) {
                          setState(() {
                            _markerPosition = newPosition;
                          });
                        },
                      ),
                    ].toSet()
                  : markersList,
              onTap: (LatLng position) {
                Logger().e(position);
                _selectMarker('');
                setState(() {
                  _markerPosition = position;
                  Position pos = Position(
                    latitude: position.latitude,
                    longitude: position.longitude,
                    timestamp: DateTime.now(),
                    accuracy: 0.0,
                    altitude: 0.0,
                    heading: 0.0,
                    speed: 0.0,
                    speedAccuracy: 0.0,
                    altitudeAccuracy: 0.0,
                    headingAccuracy: 0.0,
                  );
                  _currentPosition = pos;
                  _getAddress(pos);
                });
              },
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                googleMapController = controller;
              },
            ),
            Positioned(
              top: 13,
              left: 16,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Pallete.dark2,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      IconlyLight.arrow_left,
                      size: 24.0,
                      color: Pallete.dark1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 9,
            ),
            Positioned(
              top: 13,
              left: 81,
              right: 16,
              child: TextFieldReport(
                controller: _searchController,
                focusNode: _searchFocusNode,
                prefixIcon: IconlyLight.search,
                hintText: 'Cari disini',
                onPressed: () async {
                  _searchFocusNode.unfocus();

                  try {
                    Prediction? p = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: _mode,
                        strictbounds: false,
                        types: [''],
                        components: [Component(Component.country, 'ID')]);
                    displayPrediction(p!, homeScaffoldKey.currentState);
                  } catch (e) {}
                },
              ),
            ),
            Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: MainButtonWidget(
                  onPressed: isNextButtonEnabled
                      ? () {
                          _updateAddress();
                        }
                      : null,
                  child: Text(
                    'Selanjutnya',
                    style: ThemeFont.heading6Bold.copyWith(color: Colors.white),
                  ),
                )),
            Positioned(
              bottom: 96,
              right: 16,
              child: SizedBox(
                width: 48,
                height: 48,
                child: FloatingActionButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  onPressed: () {
                    if (_currentPosition != null) {
                      _goToCurrentPosition();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Current position is not available.'),
                        ),
                      );
                    }
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.my_location,
                    color: Pallete.main,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
