import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class SymptomsTileModel {
  final String symptom;
  bool selected;

  @override
  String toString() {
    return 'SymptomsTileModel{symptom: $symptom, selected: $selected}';
  }

  SymptomsTileModel({
    required this.symptom,
    this.selected = false,
  });
}

class SymptomsSelectionWidget extends StatefulWidget {
  const SymptomsSelectionWidget({
    Key? key,
    required this.listSymptoms,
    required this.onChoiceOfTile,
    this.crossAxisCount = 3,
  }) : super(key: key);

  /// Кол-во элементов в строке
  final int crossAxisCount;

  /// Список моделек
  final List<SymptomsTileModel> listSymptoms;

  /// Функция, реагирующая на изменение состояния элементов
  final ValueChanged<List<SymptomsTileModel>> onChoiceOfTile;

  @override
  State<SymptomsSelectionWidget> createState() => _SymptomsSelectionWidgetState();
}

class _SymptomsSelectionWidgetState extends State<SymptomsSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    GroupButtonController tabController = GroupButtonController(
      selectedIndexes: List.generate(widget.listSymptoms.length, (i) => ((widget.listSymptoms[i].selected ? i : null)))
          .whereType<int>()
          .toList(),
    );
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.priority_high_outlined, color: Color(0xFFF03F54)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Выберите симптомы, которые вы испытываете',
                  style: TextStyle(color: Colors.black),
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: GroupButton(
              isRadio: false,
              enableDeselect: true,
              controller: tabController,
              onSelected: (dynamic, int index, bool selected) {
                widget.listSymptoms[index].selected = selected;
                widget.onChoiceOfTile.call(widget.listSymptoms);
                setState(() {});
              },
              options: GroupButtonOptions(
                textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                mainGroupAlignment: MainGroupAlignment.spaceAround,
                borderRadius: BorderRadius.circular(8),
                selectedShadow: [],
                unselectedShadow: [],
                spacing: 15,
                runSpacing: 5,
                direction: Axis.horizontal,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                buttonHeight: 40,
                groupingType: GroupingType.wrap,
                unselectedColor: const Color(0xFFE5E5E5),
                selectedColor: const Color(0xFFF03F54),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                unselectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              buttons: widget.listSymptoms.map((e) => e.symptom).toList(),
            ),
          ),
        ],
      ),

      // child: GridView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     childAspectRatio: 1,
      //     crossAxisSpacing: widget.spacing,
      //     mainAxisSpacing: widget.spacing,
      //     crossAxisCount: widget.crossAxisCount,
      //   ),
      //   itemCount: widget.listPollens.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return SquareTileWidget(
      //       text: widget.listPollens[index].allergen.name,
      //       image: widget.listPollens[index].pathImage != null
      //           ? Image.asset(widget.listPollens[index].pathImage!)
      //           : const Icon(
      //               Icons.local_florist,
      //               size: 40,
      //             ),
      //       selected: widget.listPollens[index].selected,
      //       onTap: (bool selected) {
      //         log(widget.listPollens[index].toString(),
      //             name:
      //                 'SquareTileWidget - ${widget.listPollens[index].allergen.name}');
      //         widget.listPollens[index].selected = selected;
      //         widget.onChoiceOfTile.call(widget.listPollens[index]);
      //         setState(() {});
      //       },
      //     );
      //   },
      // ),
    );
  }
}
