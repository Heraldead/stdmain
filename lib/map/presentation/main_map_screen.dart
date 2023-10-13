import 'package:flutter/material.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/map/presentation/map_screen.dart';

class MainMapScreen extends StatelessWidget {
  const MainMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.chevron_left_rounded,
                color: AppColor.blue,
                size: 40,
              ),
              Text(
                'Места помощи',
                style: TextStyle(color: AppColor.blue, fontSize: 24),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MapSample(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 300,
                child: ListView.builder(itemBuilder: (context, int) {
                  return SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColor.blue,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '10:10',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.black,
                                ),
                              ),
                            )
                          ],
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
