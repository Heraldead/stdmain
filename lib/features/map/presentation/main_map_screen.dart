import 'package:flutter/material.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/map/domain/entities/description_map_entity.dart';
import 'package:std/features/map/presentation/map_screen.dart';

class MainMapScreen extends StatelessWidget {
  const MainMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        CustomAppBarWidget(
          title: 'Места помощи',
          icon: '🏥',
        ),
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: MapSample(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: DescriptionMapEntities.mapEntity.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 90,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: AppColor.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                flex: 6,
                                child: Text(
                                  DescriptionMapEntities.mapEntity[index].name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.blue,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  DescriptionMapEntities
                                      .mapEntity[index].workingTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  DescriptionMapEntities
                                      .mapEntity[index].street,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    )));
  }
}
