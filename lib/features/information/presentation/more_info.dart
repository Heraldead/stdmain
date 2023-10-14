import 'package:flutter/material.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/information/domain/entities/descrription_entities.dart';

class MoreInfo extends StatelessWidget {
  final String name;
  final String description;
  const MoreInfo({super.key, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarWidget(
              title: name,
              icon: '🔍',
              isShowBackButton: true,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text(
                'ПОПУЛЯРНЫЕ ВИДЫ ЗАБОЛЕВАНИЙ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
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
                  itemBuilder: (context, int) {
                    return Container(
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
                              '${DescriptionEntity.popularEntities[int].name}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${DescriptionEntity.popularEntities[int].description}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColor.white,
                              ),
                              softWrap: true,
                              textDirection: TextDirection
                                  .ltr, // направление текста слева направо
                              overflow: TextOverflow
                                  .ellipsis, // обрезка текста, если он превышает доступную длину
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: DescriptionEntity.popularEntities.length,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                name,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: AppColor.black,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
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
