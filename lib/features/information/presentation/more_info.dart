import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/core/widgets/custom_app_bar.dart';

class MoreInfo extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final String tag;
  final List<String> symptoms;

  const MoreInfo({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.tag,
    this.symptoms = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarWidget(
              title: name,
              icon: '🔍',
              isShowBackButton: true,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: tag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
                            height: 300,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        color: AppColor.black,
                      ),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Симптомы',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_, index) => Text('  -  ${symptoms[index]}'),
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemCount: symptoms.length,
                      ),
                    ],
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
