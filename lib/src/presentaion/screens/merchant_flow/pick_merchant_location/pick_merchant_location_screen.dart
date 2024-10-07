import 'package:oraaq/src/imports.dart';
import 'package:permission_handler/permission_handler.dart';

class PickMerchantLocationScreen extends StatefulWidget {
  const PickMerchantLocationScreen({super.key});

  @override
  State<PickMerchantLocationScreen> createState() =>
      _PickMerchantLocationScreenState();
}

class _PickMerchantLocationScreenState
    extends State<PickMerchantLocationScreen> {
  GoogleMapController? _mapController;
  LatLng _selectedPosition = const LatLng(25.363, 68.354);
  Set<Marker> _markers = {};

  bool showMap = false;
  bool enableMap = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationService();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.scaffold,
      appBar: AppBar(title: const Text(StringConstants.pickLocation)),
      body: Stack(children: [
        Positioned.fill(
            child: GoogleMap(
          markers: _markers,
          compassEnabled: false,
          buildingsEnabled: false,
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onTap: onTap,
          initialCameraPosition:
              CameraPosition(zoom: 12, target: _selectedPosition),
          onMapCreated: (controller) async {
            _mapController = controller;
            await Future.delayed(1.seconds);
            showMap = true;
            setState(() {});
            await Future.delayed(600.milliseconds);
            enableMap = true;
            setState(() {});
          },
        )),
        if (!enableMap)
          Positioned.fill(
              child: AnimatedContainer(
            duration: 600.milliseconds,
            curve: Curves.decelerate,
            decoration: BoxDecoration(
              color: showMap ? null : ColorTheme.scaffold,
            ),
            alignment: Alignment.center,
            child: const LoadingIndicator(size: 24),
          )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: 16.allPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                      icon: Symbols.my_location_rounded,
                      type: CustomButtonType.tertiaryBordered,
                      onPressed: () async {
                        await _checkLocationService();
                      }),
                  12.verticalSpace,
                  CustomButton(
                    width: double.maxFinite,
                    text: StringConstants.saveAndContinue,
                    onPressed: () => context.pop(result: _selectedPosition),
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  Future<void> onTap(latlng) async {
    _markers = {
      Marker(
        markerId: const MarkerId("value"),
        position: latlng,
      )
    };
    _selectedPosition = latlng;
    setState(() {});
    _moveCamera(latlng);
  }

  void _moveCamera(latlng) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: latlng,
        zoom: 16,
      )),
    );
  }

  _checkLocationService() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      await Geolocator.openLocationSettings();
    } else {
      _checkLocationPermission();
    }
  }

  _checkLocationPermission() async {
    var status = await Permission.location.status;

    while (!status.isGranted) {
      status = await Permission.location.request();
    }

    _getLocation();
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    _moveCamera(LatLng(position.latitude, position.longitude));
  }
}
