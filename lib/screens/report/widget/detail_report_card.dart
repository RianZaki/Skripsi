import 'package:flutter/material.dart';

class DetailReportCard extends StatelessWidget {
  final String title;
  final List<String>? subItems;
  final String? subTitle;
  final String? image;

  const DetailReportCard({
    Key? key,
    required this.title,
    this.subItems,
    this.subTitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subTitle != null) const SizedBox(height: 8),
          if (subTitle != null)
            Text(
              subTitle!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          if (subItems != null) const SizedBox(height: 8),
          if (subItems != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subItems!
                  .map(
                    (subItem) => RichText(
                      text: TextSpan(
                        text: '• ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: subItem,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (image != null) const SizedBox(height: 8),
          if (image != null)
            Image.network(
              image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
        ],
      ),
    );
  }
}
