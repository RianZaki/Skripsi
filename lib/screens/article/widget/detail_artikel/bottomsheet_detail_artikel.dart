import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

import '../../../../constants/pallete.dart';

class BottomsheetDetailArtikel extends StatelessWidget {
  final String image;
  final String title;
  final String updateDate;
  final String category;

  const BottomsheetDetailArtikel({
    super.key,
    required this.image,
    required this.title,
    required this.category,
    required this.updateDate,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> socialMedia = [
      {
        "color": Pallete.primaryBlue,
        "image": "assets/icons/icon_copyLink.png",
        "share": "link"
      },
      {
        "color": Pallete.purpleIG,
        "image": "assets/icons/icon_instagram.png",
        "share": "instagram"
      },
      {
        "color": Pallete.greenWA,
        "image": "assets/icons/icon_whatsapp.png",
        "share": "wa"
      },
      {
        "color": Pallete.blueFB,
        "image": "assets/icons/icon_facebook.png",
        "share": "fb"
      },
      {
        "color": Pallete.blueTelegram,
        "image": "assets/icons/icon_telegram.png",
        "share": "telegram"
      }
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 46),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 31,
                  child: Text(
                    "Bagikan ke teman kamu",
                    style: ThemeFont.bodyMediumMedium,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 140,
                          child: Text(
                            title,
                            style: ThemeFont.heading6Medium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              updateDate,
                              style: ThemeFont.bodySmallRegular,
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                                'assets/icons/icon_vertical_divider.png'),
                            SizedBox(width: 10),
                            Text(
                              category,
                              style: ThemeFont.bodySmallRegular,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mau bagikan lewat mana?",
                  style: ThemeFont.heading6Medium,
                ),
                SizedBox(height: 10),
                SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: socialMedia.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: socialMedia[index]["color"],
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        socialMedia[index]["image"]),
                                  ),
                                ),
                                onTap: () async {
                                  if (socialMedia[index]["share"] == "link") {
                                    SocialShare.copyToClipboard(
                                        text: "ini link");
                                  } else if (socialMedia[index]["share"] ==
                                      "instagram") {
                                    SocialShare.shareSms("ini link")
                                        .then((value) {
                                      print(value);
                                    });
                                  } else if (socialMedia[index]["share"] ==
                                      "wa") {
                                    SocialShare.shareWhatsapp("ini link")
                                        .then((value) {
                                      print(value);
                                    });
                                  } else if (socialMedia[index]["share"] ==
                                      "fb") {
                                    SocialShare.shareTwitter("ini link")
                                        .then((value) {
                                      print(value);
                                    });
                                  } else if (socialMedia[index]["share"] ==
                                      "telegram") {
                                    SocialShare.shareTelegram("ini link")
                                        .then((value) {
                                      print(value);
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 15)
                          ],
                        );
                      },
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
