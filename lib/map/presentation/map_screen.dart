import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:std/core/app_color.dargt.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng? latlng = LatLng(51.509364, -0.128928);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMapCustomWidget(
          height: 400, listCustomMarkers: _listCustomMarkers),
    );
  }
}

List<MarkerCustom> _listCustomMarkers = [
  MarkerCustom(
    point: const LatLng(59.962281, 30.3071388),
    title: 'Ianis Chamalidy',
    description: 'Большой проспект П.С., 55/6, Санкт-Петербург',
  ),
  MarkerCustom(
    point: const LatLng(59.9346636, 30.3341599),
    title: 'Ianis Chamalidy',
    description: 'Невский пр., 48, Санкт-Петербург, 191011',
  ),
  MarkerCustom(
    point: const LatLng(59.9317105, 30.359451),
    title: 'Ianis Chamalidy',
    description: 'Невский пр., 114-116, Санкт-Петербург',
  ),
];

class FlutterMapCustomWidget extends StatefulWidget {
  const FlutterMapCustomWidget(
      {super.key,
      required this.height,
      this.width = double.infinity,
      required this.listCustomMarkers});

  final double height;
  final double width;

  final List<MarkerCustom> listCustomMarkers;

  @override
  State<FlutterMapCustomWidget> createState() => _FlutterMapCustomWidgetState();
}

class _FlutterMapCustomWidgetState extends State<FlutterMapCustomWidget> {
  LatLng centerOfCoordinates(List listCoordinates) {
    double x = 0;
    double y = 0;
    for (var coordinate in listCoordinates) {
      x += coordinate.latitude;
      y += coordinate.longitude;
    }
    return LatLng(x / listCoordinates.length, y / listCoordinates.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: FlutterMap(
        options: MapOptions(
          center: centerOfCoordinates(
            widget.listCustomMarkers.map((e) => e.point).toList(),
          ),
          onTap: (_, __) {
            setState(() {
              for (var element in widget.listCustomMarkers) {
                element.isOpen = false;
              }
            });
          },
          zoom: 11,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            rotate: true,
            markers: widget.listCustomMarkers.map(
              (coordinate) {
                const double height = 50;
                const double width = 100;
                return Marker(
                  point: coordinate.point,
                  height: height,
                  width: width,
                  builder: (context) => MarkerCustomWidget(
                    onTap: () {
                      setState(() {
                        for (var element in widget.listCustomMarkers) {
                          element.isOpen = false;
                        }
                        coordinate.isOpen = !coordinate.isOpen;
                      });
                    },
                    height: height,
                    width: width,
                    key: UniqueKey(),
                    point: coordinate,
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

class MarkerCustom {
  LatLng point;
  String title;
  String? description;
  bool isOpen;

  MarkerCustom({
    required this.point,
    required this.title,
    this.description,
    this.isOpen = false,
  });
}

class MarkerCustomWidget extends StatefulWidget {
  const MarkerCustomWidget({
    super.key,
    required this.point,
    this.onTap,
    required this.height,
    required this.width,
  });

  final MarkerCustom point;
  final double height;
  final double width;
  final VoidCallback? onTap;

  @override
  State<MarkerCustomWidget> createState() => _MarkerCustomWidgetState();
}

class _MarkerCustomWidgetState extends State<MarkerCustomWidget> {
  bool isOpen = false;

  @override
  void initState() {
    isOpen = widget.point.isOpen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap?.call();
          isOpen = !isOpen;
        });
      },
      child: isOpen
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.point.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (widget.point.description != null) ...[
                    const SizedBox(height: 2),
                    Expanded(
                      child: Text(
                        widget.point.description!,
                        softWrap: true,
                        maxLines: 3,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  // const SizedBox(height: 2),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     height: 16,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     padding: const EdgeInsets.all(2),
                  //     child: const Text(
                  //       'Подробнее',
                  //       style: TextStyle(color: Colors.black, fontSize: 8),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          : const Icon(
              Icons.location_on,
              color: AppColor.blue,
              size: 30,
            ),
    );
  }
}
