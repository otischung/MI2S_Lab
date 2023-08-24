import 'package:flutter/material.dart';

class DrugCardWidget extends StatefulWidget {
  const DrugCardWidget({
    super.key,
    required this.favoriteDrugNames,
    required this.favoriteDLIs,
    required this.item,
    required this.imgSrc,
  });

  final List<String> favoriteDrugNames;
  final List<Map<String, dynamic>> favoriteDLIs;
  final Map<String, dynamic> item;
  final String imgSrc;

  @override
  State<DrugCardWidget> createState() => _DrugCardWidgetState();
}

class _DrugCardWidgetState extends State<DrugCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          // 喜好愛心按鈕
          IconButton(
            onPressed: () {
              // 狀態重設，重新繪製 UI
              setState(() {
                if (widget.favoriteDrugNames.contains(widget.item['中文品名'])) {
                  widget.favoriteDrugNames.remove(widget.item['中文品名']);
                  widget.favoriteDLIs.removeWhere((element) => element['中文品名'] == widget.item['中文品名']);
                } else {
                  widget.favoriteDrugNames.add(widget.item['中文品名']);
                  widget.favoriteDLIs.add(widget.item);
                }
                debugPrint(
                    widget.favoriteDrugNames.toString());
              });
            },
            icon: (widget.favoriteDrugNames.contains(
                widget.item['中文品名']) == true)
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)
          ),
          Expanded(
            child: ListTile(
              title: Text(widget.item['中文品名']),
              subtitle: Text(widget.item['適應症']),
            ),
          ),
          Image.network(
            widget.imgSrc,
            width: 100,
            height: 100,
          )
        ],
      ),
    );
  }
}