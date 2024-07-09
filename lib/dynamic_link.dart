import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:recything_mobile/bloc/dynamic_link/dynamic_link_cubit.dart';
import 'package:recything_mobile/screens/article/page/detail_artikel.dart';

class DynamicLink {
  String? id_artikel = "";

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks(BuildContext context) async {
    dynamicLinks.onLink.listen(
      (dynamicLinkData) {
        final String deeplink = dynamicLinkData.link.toString();
        final String path = dynamicLinkData.link.path;
        print("halo 1 $deeplink");
        print("halo 2 $path");
        if (deeplink.isEmpty) return;
        handleDeepLink(path, context);
      },
    ).onError((error) {});
    initUniLinks(context);
  }

  Future<void> initUniLinks(BuildContext context) async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      print("halo3");
      print("tes 1 ${initialLink?.link.pathSegments.last}");
      id_artikel = initialLink?.link.pathSegments.last.toString();
      DynamicLinkCubit().saveIdArticle(id_artikel ?? "");
      print("tes 2 ${initialLink?.link}");
      print("tes 3 ${initialLink?.link.authority}");
      print("tes4 ${initialLink?.link.query}}");
      if (initialLink == null) return;
      handleDeepLink(initialLink.link.path, context);
    } catch (e) {}
  }

  void handleDeepLink(String path, BuildContext context) {
    // navigasi / nembah api
    print("halo4 ${path}");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DetailArtikelScreen()));
  }
}
