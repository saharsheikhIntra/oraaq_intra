import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/constants/asset_constants.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_state.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/request_confirmation_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';
import 'package:permission_handler/permission_handler.dart';

class PickLocationScreen extends StatefulWidget {
  final int args;
  const PickLocationScreen({super.key, required this.args});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final PickLocationCubit _cubit = getIt.get<PickLocationCubit>();
  late GoogleMapController _mapController;

  static const MarkerId _defaultMarkerId = MarkerId("defaultMarkerId");
  static const CircleId _defaultCircleId = CircleId("defaultCircleId");

  var customIcon = BitmapDescriptor.defaultMarker;
  LatLng _selectedPosition = const LatLng(25.363, 68.354);
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  double _searchRadius = 2;
  bool _isSearching = true;
  List<LatLng> _searchedResults = [];
  String _selectedAddress = "";

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetConstants.locationMarker,
    ).then((d) => customIcon = d);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _checkLocationService());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorTheme.scaffold,
        appBar: AppBar(title: const Text(StringConstants.preferredLocation)),
        body: BlocProvider(
            create: (context) => _cubit,
            child: BlocConsumer<PickLocationCubit, PickLocationState>(
              listener: (context, state) async {
                switch (state) {
                  case PickLocationStateInitial():
                    break;
                  case PickLocationStateChangeSearchRadius(
                      radius: double radius
                    ):
                    _searchRadius = radius;
                    _setPosition(shouldSearch: true);
                    break;
                  case PickLocationStateChangePosition(latlng: LatLng latlng):
                    _selectedPosition = latlng;
                    _setPosition(shouldSearch: true);
                    break;
                  case PickLocationStateSearchResults(
                      searchedResults: List<LatLng> results
                    ):
                    _searchedResults = results;
                    await _setPosition();
                    _isSearching = false;
                    _markers.addAll(results.map((e) => Marker(
                          position: e,
                          icon: customIcon,
                          consumeTapEvents: false,
                          markerId: MarkerId(e.toString()),
                        )));
                    break;
                  case PickLocationStateRecenter():
                    break;
                  case PickLocationStateLoading():
                    _isSearching = true;
                    break;
                  case PickLocationStateError(failure: Failure failure):
                    _isSearching = false;
                    Logger().e(failure.message);
                    break;
                  case PickLocationStateMerchantsLoaded(
                      merchants: List<LatLng> merchants
                    ):
                    _isSearching = false;
                    _addMarkers(merchants);
                    break;
                }
              },
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            height: ScreenUtil().screenHeight - 300,
                            child: GoogleMap(
                              markers: _markers,
                              circles: _circles,
                              compassEnabled: false,
                              buildingsEnabled: false,
                              myLocationEnabled: true,
                              mapToolbarEnabled: false,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              onTap: (latlng) => _cubit.changePosition(latlng),
                              initialCameraPosition: CameraPosition(
                                  zoom: 12, target: _selectedPosition),
                              onMapCreated: (controller) {
                                _mapController = controller;
                              },
                            ))),
                    if (_selectedAddress.isNotEmpty && !_isSearching)
                      _buildAddress(),
                    ..._buildSliderCard(),
                  ],
                );
              },
            )));
  }

  Widget _buildAddress() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: 8.allPadding,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: ColorTheme.white,
              borderRadius: 8.borderRadius,
            ),
            child: Text(
              _selectedAddress,
              textAlign: TextAlign.center,
              style: TextStyleTheme.labelSmall
                  .copyWith(color: ColorTheme.secondaryText),
            )));
  }

  void _addMarkers(List<LatLng> merchants) {
    // <--- New method to add merchant markers
    _markers.clear(); // Clear any existing markers
    _markers.add(Marker(
      zIndex: 1,
      markerId: _defaultMarkerId,
      position: _selectedPosition, // Your current position
    ));

    // Add merchant markers
    for (var merchantPosition in merchants) {
      _markers.add(Marker(
        position: merchantPosition,
        icon: customIcon, // Custom icon for merchants
        markerId: MarkerId(merchantPosition.toString()),
      ));
    }

    setState(() {}); // Trigger UI update to display the markers
  }

  List<Widget> _buildSliderCard() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: 16.allPadding,
              child: CustomButton(
                  icon: Symbols.my_location_rounded,
                  type: CustomButtonType.tertiaryBordered,
                  onPressed: () async {
                    await _checkLocationService();
                    _cubit.recenter();
                  })),
          AnimatedContainer(
              width: double.infinity,
              curve: Curves.decelerate,
              duration: 600.milliseconds,
              padding: EdgeInsets.only(
                top: 12,
                bottom: _isSearching ? 260 : 214,
              ),
              decoration: BoxDecoration(
                borderRadius: 24.topBorderRadius,
                color: ColorTheme.neutral1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorTheme.secondary.shade700,
                        backgroundColor: ColorTheme.white,
                      )),
                  16.horizontalSpace,
                  Text(
                    StringConstants.searchingSaloons,
                    style: TextStyleTheme.labelLarge
                        .copyWith(color: ColorTheme.secondary.shade900),
                  ),
                ],
              )),
        ],
      ),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.75],
                colors: [
                  ColorTheme.white,
                  ColorTheme.scaffold,
                ],
              ),
              borderRadius: 24.topBorderRadius,
              border: Border.all(
                color: ColorTheme.neutral1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              32.verticalSpace,
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: 12.borderRadius,
                    color: ColorTheme.primary.shade50,
                  ),
                  child: Text(
                    "$_searchRadius Km",
                    style: TextStyleTheme.titleLarge
                        .copyWith(color: ColorTheme.primary.shade600),
                  )),
              8.verticalSpace,
              Padding(
                  padding: 32.horizontalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "0 ${StringConstants.km}",
                        style: TextStyleTheme.labelLarge
                            .copyWith(color: ColorTheme.neutral3),
                      ),
                      Text(
                        "100 ${StringConstants.km}",
                        style: TextStyleTheme.labelLarge
                            .copyWith(color: ColorTheme.neutral3),
                      ),
                    ],
                  )),
              Padding(
                  padding: 8.horizontalPadding,
                  child: Slider(
                    min: 0.5,
                    max: 10,
                    divisions: 19,
                    activeColor: ColorTheme.primary,
                    value: _searchRadius,
                    onChanged: (value) {
                      _cubit.changeSearchRadius(value);
                    },
                  )),
              20.verticalSpace,
              CustomButton(
                text: StringConstants.continu,
                width: ScreenUtil().screenWidth - 64,
                onPressed: _searchedResults.isEmpty
                    ? null
                    : () => SheetComponenet.show(context,
                        isScrollControlled: true,
                        child: const RequestConfirmationSheet()),
              ),
              (16).verticalSpace,
            ],
          ))
    ];
  }

  ///
  ///
  ///
  ///
  ///

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _selectedPosition = LatLng(
      position.latitude,
      position.longitude,
    );
    _setPosition(shouldSearch: true);
  }

  _setPosition({bool shouldSearch = false}) async {
    _markers.clear();
    _markers.add(Marker(
      zIndex: 1,
      markerId: _defaultMarkerId,
      position: _selectedPosition,
    ));
    _circles.clear();
    _circles.add(Circle(
      radius: _searchRadius * 1000,
      strokeWidth: 3,
      circleId: _defaultCircleId,
      center: _selectedPosition,
      strokeColor: ColorTheme.secondary,
      fillColor: ColorTheme.secondary.withOpacity(0.25),
    ));
    if (shouldSearch) {
      _extractAddress();
      _cubit.search(_selectedPosition, _searchRadius);
      // _cubit.searchMerchant(_selectedPosition, _searchRadius, widget.args);
      _isSearching = true;
    }
    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: _selectedPosition,
        zoom: 12,
      )),
    );
  }

  _extractAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedPosition.latitude,
        _selectedPosition.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark first = placemarks.first;
        Set<String> tempAddress = {};

        if (first.name != null && first.name!.isNotEmpty) {
          tempAddress.add(first.name!.trim());
        }
        if (first.street != null && first.street!.isNotEmpty) {
          tempAddress.add(first.street!.trim());
        }
        if (first.subThoroughfare != null &&
            first.subThoroughfare!.isNotEmpty) {
          tempAddress.add(first.subThoroughfare!.trim());
        }
        if (first.thoroughfare != null && first.thoroughfare!.isNotEmpty) {
          tempAddress.add(first.thoroughfare!.trim());
        }
        if (first.subLocality != null && first.subLocality!.isNotEmpty) {
          tempAddress.add(first.subLocality!.trim());
        }
        if (first.locality != null && first.locality!.isNotEmpty) {
          tempAddress.add(first.locality!.trim());
        }
        if (first.subAdministrativeArea != null &&
            first.subAdministrativeArea!.isNotEmpty) {
          tempAddress.add(first.subAdministrativeArea!.trim());
        }
        if (first.administrativeArea != null &&
            first.administrativeArea!.isNotEmpty) {
          tempAddress.add(first.administrativeArea!.trim());
        }
        if (first.postalCode != null && first.postalCode!.isNotEmpty) {
          tempAddress.add(first.postalCode!.trim());
        }
        if (first.country != null && first.country!.isNotEmpty) {
          tempAddress.add(first.country!.trim());
        }

        _selectedAddress = tempAddress.join(", ");
      }
    } on Exception catch (e) {
      Logger().e(e);
    }
  }
}
