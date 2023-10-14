import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/information/domain/entities/descrription_entities.dart';
import 'package:std/features/information/presentation/more_info.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBarWidget(
              title: 'STD INFO',
              icon: '🔍',
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 16, bottom: 6),
              child: Text(
                'ПОИСК',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blue,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12, left: 10, right: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Вич',
                  helperText: 'ВВЕДИТЕ ВАШИ СИМПТОМЫ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text(
                'РАСПРОСТРАНЁННЫЕ ВИДЫ ЗАБОЛЕВАНИЙ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _gotoDetailsPage(
                          context,
                          DescriptionEntity.illlnessEntities[index].name,
                          DescriptionEntity.illlnessEntities[index].allDescription,
                          DescriptionEntity.illlnessEntities[index].image,
                          '',
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: AppColor.blue,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                DescriptionEntity.illlnessEntities[index].name,
                                style: const TextStyle(fontSize: 16, color: AppColor.white),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                DescriptionEntity.illlnessEntities[index].description,
                                style: const TextStyle(fontSize: 12, color: AppColor.white),
                                softWrap: true,
                                textDirection: TextDirection.ltr, // направление текста слева направо
                                overflow: TextOverflow.ellipsis, // обрезка текста, если он превышает доступную длину
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: 4,
                ),
              ),
            ),
            ////
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Text(
                'ВСЕ ВИДЫ ЗАБОЛЕВАНИЙ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blue,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: DescriptionEntity.illlnessEntities.length, //itemCount
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _gotoDetailsPage(
                        context,
                        DescriptionEntity.illlnessEntities[index].name,
                        DescriptionEntity.illlnessEntities[index].allDescription,
                        DescriptionEntity.illlnessEntities[index].image,
                        DescriptionEntity.illlnessEntities[index].name + index.toString(),
                      );
                    },
                    child: Container(
                      width: 200,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: DescriptionEntity.illlnessEntities[index].name + index.toString(),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: DescriptionEntity.illlnessEntities[index].image,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 200,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DescriptionEntity.illlnessEntities[index].name,
                                        style: const TextStyle(fontSize: 16, color: AppColor.blue),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        DescriptionEntity.illlnessEntities[index].allDescription,
                                        style: const TextStyle(fontSize: 12, color: AppColor.black),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_outlined,
                                  size: 24,
                                  color: AppColor.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context, String name, String description, String image, String tag) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => MoreInfo(
        name: name,
        description: description,
        image: image,
        tag: tag,
      ),
    ));
  }
}
