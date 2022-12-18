import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/modules/home/controllers/home_controller.dart';

import '../../controllers/tab/titik_pantau_controller.dart';

class TitikPantauTab extends StatefulWidget {
  const TitikPantauTab({super.key});

  @override
  State<TitikPantauTab> createState() => _TitikPantauTabState();
}

class _TitikPantauTabState extends State<TitikPantauTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _TitikPantauTab();
  }

  @override
  bool get wantKeepAlive => true;
}

class _TitikPantauTab extends GetView<TitikPantauController> {
  _TitikPantauTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.obx(
          (state) => Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: FloatingActionButton(
                heroTag: const Key("map"),
                backgroundColor: const Color(0xFF03486F),
                onPressed: () =>
                    controller.isMap.value = !controller.isMap.value,
                mini: true,
                child: Obx(() => !controller.isMap.value
                    ? const Icon(Icons.map)
                    : const Icon(Icons.list)),
              )),
          onLoading: const SizedBox.shrink(),
          onError: (err) => const SizedBox.shrink()),
      body: controller.obx((state) {
        return Obx(() =>
            controller.isMap.value ? flutterMap(state) : flutterList(state));
      },
          onLoading: flutterListLoading(),
          onError: (err) => Center(
                child: Text(err ?? ''),
              )),
    );
  }

  Widget flutterList(List<TitikPantau>? state) => RefreshIndicator(
        onRefresh: () async {
          await controller.getTitikPantau();
        },
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            ...state!.map((e) => itemTitikPantau(e)).toList(),
            const SizedBox(
              height: 150,
            )
          ],
        )),
      );
  Widget flutterListLoading() => RefreshIndicator(
        onRefresh: () async {
          await controller.getTitikPantau();
        },
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            itemTitikPantau(null),
            const SizedBox(
              height: 150,
            )
          ],
        )),
      );

  Widget itemTitikPantau(TitikPantau? data) {
    return InkWell(
      onTap: () {
        Get.find<HomeController>().selectedTitikPantau.value = data;
        Get.find<HomeController>().scaffoldKey.currentState!.openDrawer();
      },
      child: Container(
          width: Get.width - 32,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(.25)
                        : Colors.black.withOpacity(.25),
                    blurRadius: 7),
              ],
              color: Get.theme.scaffoldBackgroundColor),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 0.75,
                  child: data == null
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.white,
                          ),
                        )
                      : Image.network(
                          data.foto ??
                              'https://images.pexels.com/photos/2290438/pexels-photo-2290438.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 18,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "${data.nama}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(
                          height: 4,
                        ),
                        data == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "${data.latitude}, ${data.longitude}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                        const Divider(
                          thickness: 3,
                        ),
                        data == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 18,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("IKA"),
                                  Text(data.kualitas != null
                                      ? data.kualitas!.isNotEmpty
                                          ? data.kualitas!.last.ika.toString()
                                          : "data kosong"
                                      : "data kosong")
                                ],
                              ),
                        const SizedBox(
                          height: 4,
                        ),
                        data == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 18,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Kedalaman"),
                                  Text(data.kuantitas != null
                                      ? data.kuantitas!.isNotEmpty
                                          ? data.kuantitas!.last['ketinggian']
                                              .toString()
                                          : "data kosong"
                                      : "data kosong")
                                ],
                              ),
                        const SizedBox(
                          height: 4,
                        ),
                        data == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 18,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Status"),
                                  Text(data.kualitas != null
                                      ? data.kualitas!.isNotEmpty
                                          ? data.kualitas!.last.status
                                              .toString()
                                          : "data kosong"
                                      : "data kosong")
                                ],
                              )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }

  FlutterMap flutterMap(List<TitikPantau>? state) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-7.75907, 112.5255058),
        zoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'go.id.batukota.dlh.simas',
        ),
        MarkerLayer(
          markers: [
            ...state!
                .map(
                  (e) => Marker(
                    point: LatLng(e.longitude!, e.latitude!),
                    width: 200,
                    height: 80,
                    builder: (context) => InkWell(
                      onTap: () {
                        Get.find<HomeController>().openDrawer(e);
                      },
                      child: Column(
                        children: [
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.nama!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ],
    );
  }
}
