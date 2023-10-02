import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/utilities/open_apps.dart';
import 'package:ati_all_in_one_hive/utilities/uninstall_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildItem extends StatelessWidget {
  const BuildItem(this.text, this.id, this.img, this.url, this.appInstalled, {super.key});

  final String text, id, img, url, appInstalled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () => openApps(id, ''),
            child: Column(
              children: [
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) => Center(child: SvgPicture.asset("assets/images/android_logo.svg")),
                    errorWidget: (context, url, error) => Center(child: SvgPicture.asset("assets/images/android_logo.svg")),
                  ),
                ),
                Text(
                  '\n$text',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )),

        //for uninstall button
        Positioned(
            right: 0,
            child: PopupMenuButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                            uninstallApp(id, url);
                          },
                          height: 30,
                          child: const Center(
                              child: Text(
                            'Uninstall',
                            style: TextStyle(color: MyColors.destructiveRed),
                          )))
                    ]))
      ],
    );
  }
}
