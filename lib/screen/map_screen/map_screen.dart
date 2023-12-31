import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/screen/map_screen/widgets/top_bar_area.dart';
import 'package:project/utils/const_res.dart';
import '../../../common/widgets/buttons.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import 'map_screen_view_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init(context);
      },
      viewModelBuilder: () => MapScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: false,
                  onMapCreated: (controller) {
                    model.mapController = controller;
                    model.onMapCreated(controller);
                    model.manager.setMapId(controller.mapId);
                  },
                  mapToolbarEnabled: false,
                  onCameraMove: model.manager.onCameraMove,
                  onCameraIdle: model.manager.updateMap,
                  markers: model.marker,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  indoorViewEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: model.center,
                    zoom: 15.4746,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const SizedBox(height: 13),
                    TopBarArea(
                      distanceList: model.distanceList,
                      selectedDistance: model.selectedDistance,
                      onBackBtnTap: model.onBackBtnTap,
                      onDistanceChange: model.onDistanceChange,
                    ),
                    const Spacer(),
                    // model.hobbyList == null || model.hobbyList!.isEmpty
                    //     ? const SizedBox()
                    //     : HobbySelectionBar(
                    //         hobbyList: model.hobbyList,
                    //         selectedHobby: model.selectedHobby,
                    //         onHobbySelect: model.onHobbySelect,
                    //       )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
