import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Screen/Home/myActivity.dart';
import 'package:flutter_taxi_app_driver/Screen/Request/requestDetail.dart';
import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taxi_app_driver/Screen/Menu/Menu.dart';
import 'package:flutter_taxi_app_driver/data/Model/placeItem.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'radioSelectMapType.dart';
import 'package:flutter_taxi_app_driver/data/Model/mapTypeModel.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import '../../Components/itemRequest.dart';
import '../../google_map_helper.dart';
import '../../data/Model/direction_model.dart';
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final String screenName = "HOME";
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  CircleId selectedCircle;
  GoogleMapController _mapController;

  String currentLocationName;
  String newLocationName;
  String _placemark = '';
  GoogleMapController mapController;
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  bool checkPlatform = Platform.isIOS;
  double distance = 0;
  bool nightMode = false;
  VoidCallback showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = new List<MapTypeModel>();
  PersistentBottomSheetController _controller;
  List<Map<String, dynamic>> listRequest = List<Map<String, dynamic>>();

  List<Routes> routesData;
  final GMapViewHelper _gMapViewHelper = GMapViewHelper();
  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  PolylineId selectedPolyline;
  bool isShowDefault = false;
  Position currentLocation;
  Position _lastKnownPosition;
  bool isEnabledLocation = false;

  final Geolocator _locationService = Geolocator();
  PermissionStatus permission;

  @override
  void initState() {
    super.initState();
//    _initLastKnownLocation();
//    _initCurrentLocation();
    fetchLocation();
    showPersBottomSheetCallBack = _showBottomSheet;
    sampleData.add(MapTypeModel(1,true, 'assets/style/maptype_nomal.png', 'Nomal', 'assets/style/nomal_mode.json'));
    sampleData.add(MapTypeModel(2,false, 'assets/style/maptype_silver.png', 'Silver', 'assets/style/sliver_mode.json'));
    sampleData.add(MapTypeModel(3,false, 'assets/style/maptype_dark.png', 'Dark', 'assets/style/dark_mode.json'));
    sampleData.add(MapTypeModel(4,false, 'assets/style/maptype_night.png', 'Night', 'assets/style/night_mode.json'));
    sampleData.add(MapTypeModel(5,false, 'assets/style/maptype_netro.png', 'Netro', 'assets/style/netro_mode.json'));
    sampleData.add(MapTypeModel(6,false, 'assets/style/maptype_aubergine.png', 'Aubergine', 'assets/style/aubergine_mode.json'));

    listRequest = [
      {"id": '0',
        "avatar" : "https://source.unsplash.com/1600x900/?portrait",
        "userName" : "Olivia Nastya",
        "date" : '08 Jan 2019 at 12:00 PM',
        "price" : 150,
        "distance" : "21km",
        "addFrom": "2536 Flying Taxicabs",
        "addTo" : "2536 Flying Taxicabs",
        "locationForm" : LatLng(42.535003,-71.873626),
        "locationTo" : LatLng(42.551746, -71.958439),
      },
      {"id": '1',
        "avatar" : "https://source.unsplash.com/1600x900/?portrait",
        "userName" : "Callie Greer",
        "date" : '08 Jan 2019 at 12:00 PM',
        "price" : 150,
        "distance" : "5km",
        "addFrom": "36 Flying Taxicabs",
        "addTo" : "2536 Icie Park Suite 572",
        "locationForm" : LatLng(42.557152,-72.023708),
        "locationTo" : LatLng(42.460815, -72.203673),
      },
      {"id": '2',
        "avatar" : "https://source.unsplash.com/1600x900/?portrait",
        "userName" : "Olivia Nastya",
        "date" : '08 Jan 2019 at 12:00 PM',
        "price" : 152,
        "distance" : "10km",
        "addFrom": "2536 Flying Taxicabs",
        "addTo" : "2 William St, Chicago, US",
        "locationForm" : LatLng(42.305444,-72.201658),
        "locationTo" : LatLng(42.327784, -71.953803),
      },

    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkPermission() async {
    isEnabledLocation = await Permission.location.serviceStatus.isEnabled;
  }

  void fetchLocation(){
    checkPermission()?.then((_) {
      if(isEnabledLocation){
        _initCurrentLocation();
      }
    });
  }

  ///Get last known location
  Future<void> _initLastKnownLocation() async {
    Position position;
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator?.getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    } on PlatformException {
      position = null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _lastKnownPosition = position;
    });
  }

  /// Get current location
  Future<void> _initCurrentLocation() async {
    currentLocation = await _locationService.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

      List<Placemark> placemarks = await _locationService.placemarkFromCoordinates(currentLocation?.latitude, currentLocation?.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        final Placemark pos = placemarks[0];
        setState(() {
          _placemark = pos.name + ', ' + pos.thoroughfare;
          print(_placemark);
          currentLocationName = _placemark;
        });
      }
    if(currentLocation != null){
      moveCameraToMyLocation();
    }
  }

  void moveCameraToMyLocation(){
    _mapController?.animateCamera(
      CameraUpdate?.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation?.latitude,currentLocation?.longitude),
          zoom: 17.0,
        ),
      ),
    );
  }


  void _onMapCreated(GoogleMapController controller) async {
    this._mapController = controller;
    addMarker(listRequest[0]['locationForm'], listRequest[0]['locationTo']);
  }

  Future<String> _getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  void _setMapStyle(String mapStyle) {
    setState(() {
      nightMode = true;
      _mapController.setMapStyle(mapStyle);
    });
  }

  void changeMapType(int id, String fileName){
    print(fileName);
    if (fileName == null) {
      setState(() {
        nightMode = false;
        _mapController.setMapStyle(null);
      });
    } else {
      _getFileData(fileName).then(_setMapStyle);
    }
  }

  void _showBottomSheet() async {
    setState(() {
      showPersBottomSheetCallBack = null;
    });
    _controller = await _scaffoldKey.currentState
        .showBottomSheet((context) {
      return new Container(
        height: 300.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Map type",style: heading18Black,),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close,color: blackColor,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child:
                new GridView.builder(
                  itemCount: sampleData.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      highlightColor: primaryColor,
                      splashColor: Colors.blueAccent,
                      onTap: () {
                        _closeModalBottomSheet();
                        sampleData.forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                        changeMapType(sampleData[index].id, sampleData[index].fileName);

                      },
                      child: new MapTypeItem(sampleData[index]),
                    );
                  },
                ),
              )

            ],
          ),
        )
      );
    });
  }

  void _closeModalBottomSheet() {
    if (_controller != null) {
      _controller.close();
      _controller = null;
    }
  }

  addMarker(LatLng locationForm, LatLng locationTo){
    _markers.clear();
    final MarkerId _markerFrom = MarkerId("fromLocation");
    final MarkerId _markerTo = MarkerId("toLocation");
    _markers[_markerFrom] = GMapViewHelper.createMaker(
      markerIdVal: "fromLocation",
      icon: checkPlatform ? "assets/image/gps_point_24.png" : "assets/image/gps_point.png",
      lat: locationForm.latitude,
      lng: locationForm.longitude,
    );

    _markers[_markerTo] = GMapViewHelper.createMaker(
      markerIdVal: "toLocation",
      icon: checkPlatform ? "assets/image/ic_marker_32.png" : "assets/image/ic_marker_128.png",
      lat: locationTo.latitude,
      lng: locationTo.longitude,
    );
    _gMapViewHelper?.cameraMove(fromLocation: locationForm,toLocation: locationTo,mapController: _mapController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: new MenuScreens(activeScreenName: screenName),
        body: Container(
            color: whiteColor,
            child: Stack(
              children: <Widget>[
                _buildMapLayer(),
                Positioned(
                  bottom: isShowDefault == false ? 330 : 250,
                  right: 16,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0),),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.my_location,size: 20.0,color: blackColor,),
                      onPressed: (){
                        _initCurrentLocation();
                      },
                    ),
                  )
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0),),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.layers,size: 20.0,color: blackColor,),
                      onPressed: (){
                        _showBottomSheet();
                      },
                    ),
                  )
                ),
                Positioned(
                    top: 50,
                    left: 10,
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100.0),),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.menu,size: 20.0,color: blackColor,),
                        onPressed: (){
                          _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                    )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: isShowDefault == false ?
                  Container(
                    height: 330,
                    child: TinderSwapCard(
                        orientation: AmassOrientation.TOP,
                        totalNum: listRequest.length,
                        stackNum: 3,
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.width * 0.9,
                        minHeight: MediaQuery.of(context).size.width * 0.85,
                        cardBuilder: (context, index) => ItemRequest(
                          avatar: listRequest[index]['avatar'],
                          userName: listRequest[index]['userName'],
                          date: listRequest[index]['date'],
                          price: listRequest[index]['price'].toString(),
                          distance: listRequest[index]['distance'],
                          addFrom: listRequest[index]['addFrom'],
                          addTo: listRequest[index]['addTo'],
                          locationForm: listRequest[index]['locationForm'],
                          locationTo: listRequest[index]['locationTo'],
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail()));
                          },
                        ),
                        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                          /// Get swiping card's position
//                          print(details);
                        },
                        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                          /// Get orientation & index of swiped card!
                          print('index $index');
                          print('aaa ${listRequest.length}');
                          setState(() {
                            if(index == listRequest.length-1){
                              setState(() {
                                isShowDefault = true;
                              });
                            }else{
                              addMarker(listRequest[index+1]['locationForm'], listRequest[index+1]['locationTo']);
                            }
                          });
                        }
                      ),
                  ): MyActivity(
                    userImage: 'https://source.unsplash.com/1600x900/?portrait',
                    userName: 'Nemi Chand',
                    level: 'Bassic level',
                    totalEarned: '\$250',
                    hoursOnline: 10.5,
                    totalDistance: '22Km',
                    totalJob: 8,
                  ),
                )
              ],
            ),
        ),
    );
  }

  Widget _buildMapLayer(){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: _gMapViewHelper.buildMapView(
          context: context,
          onMapCreated: _onMapCreated,
          currentLocation: LatLng(
              currentLocation != null ? currentLocation?.latitude : _lastKnownPosition?.latitude ?? 0.0,
              currentLocation != null ? currentLocation?.longitude : _lastKnownPosition?.longitude ?? 0.0),
          markers: _markers,
          polyLines: _polyLines,
          onTap: (_){
          }
      ),
    );
  }
}
