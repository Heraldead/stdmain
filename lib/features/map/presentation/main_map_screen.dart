import 'package:cached_network_image/cached_network_image.dart';
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
            const CustomAppBarWidget(
              title: 'Места помощи',
              icon: '🏥',
            ),
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MapSample(listDescriptionMapEntity: DescriptionMapEntities.mapEntity),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: DescriptionMapEntities.mapEntity.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: DescriptionMapEntities.mapEntity[index].image,
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                  flex: 6,
                                  child: Text(
                                    DescriptionMapEntities.mapEntity[index].name,
                                    style: const TextStyle(
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
                                    DescriptionMapEntities.mapEntity[index].workingTime,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    DescriptionMapEntities.mapEntity[index].street,
                                    style: const TextStyle(
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
