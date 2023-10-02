import 'dart:async';
import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/configs/my_sizes.dart';
import 'package:ati_all_in_one_hive/models/app_store_mod.dart';
import 'package:ati_all_in_one_hive/utilities/open_apps.dart';
import 'package:ati_all_in_one_hive/utilities/responsive.dart';
import 'package:ati_all_in_one_hive/widgets/my_alert_dialog.dart';
import 'package:ati_all_in_one_hive/widgets/my_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_flutter_downloader/native_flutter_downloader.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NotInstallItems extends StatefulWidget {
  const NotInstallItems(this.getNotInstallAppList, {super.key});

  final List<AppStoreModel> getNotInstallAppList;

  @override
  State<NotInstallItems> createState() => _NotInstallItemsState();
}

class _NotInstallItemsState extends State<NotInstallItems> with WidgetsBindingObserver {
  bool isDownloading = false;
  late StreamSubscription progressStream;

  //for check realtime internet
  bool connectivityStatus = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        connectivityStatus = true;
      } else if (event == ConnectivityResult.wifi) {
        connectivityStatus = true;
      } else {
        connectivityStatus = false;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !isDownloading) {
      context.read<FetchAppListBloc>().add(RefreshAppListEvent());
    }
  }

  @override
  void initState() {
    NativeFlutterDownloader.initialize();
    checkRealtimeConnection();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // progressStream.cancel(); //comment for lateinitializatioerror-field-has-not-been-initialized-error
    _streamSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: MySizes.bodyPadding),
              height: 20,
              width: 10,
              decoration: const BoxDecoration(color: MyColors.black, borderRadius: BorderRadius.horizontal(left: Radius.circular(5))),
            ),
            const Text(
              ' The apps below are not installed on your device',
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(MySizes.bodyPadding),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: Responsive.isMobile(context)
              ? 2
              : Responsive.isTablet(context)
                  ? 3
                  : 4,
          children: widget.getNotInstallAppList
              .map(
                (e) => Card(
                  key: ValueKey(e.appId),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            // Flexible(child: Image.asset(e.img ?? '')),
                            Flexible(
                              child: CachedNetworkImage(
                                imageUrl: "${e.img}",
                                placeholder: (context, url) => SvgPicture.asset("assets/images/android_logo.svg"),
                                errorWidget: (context, url, error) => SvgPicture.asset("assets/images/android_logo.svg"),
                              ),
                            ),
                            Text(
                              '\n${e.name}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                      //add for download
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white60),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            debugPrint("app image: ${e.img}");
                            if (isDownloading && e.url != null && e.url != '') {
                              mySnackbar(context: context, message: "You cannot download it without finishing the current download");
                              return;
                            }

                            openApps(e.appId ?? '', e.url ?? '').then((value) {
                              if (!value) {
                                if (!connectivityStatus) {
                                  myAlertDialog(context, 'No internet connection', 'Please check your internet connection and try again.', actions: [
                                    CupertinoButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ]);
                                  return;
                                }

                                progressStream = NativeFlutterDownloader.progressStream.listen((event) {
                                  debugPrint("event.status: ${event.status}");
                                  if (event.status == DownloadStatus.successful) {
                                    setState(() {
                                      e.progress = event.progress;
                                      isDownloading = false;
                                    });
                                    openApps(e.appId ?? '', e.url ?? '');
                                  } else if (event.status == DownloadStatus.running) {
                                    debugPrint('event.progress: ${event.progress}');
                                    setState(() {
                                      e.progress = event.progress;
                                      isDownloading = true;
                                    });
                                  } else if (event.status == DownloadStatus.failed) {
                                    debugPrint('event: ${event.statusReason?.message}');
                                    debugPrint('Download failed');
                                    setState(() {
                                      e.progress = null;
                                      isDownloading = false;
                                    });
                                  } else if (event.status == DownloadStatus.paused) {
                                    debugPrint('Download paused');
                                    NativeFlutterDownloader.cancel([event.downloadId]);
                                    setState(() {
                                      e.progress = null;
                                      isDownloading = false;
                                    });
                                  } else if (event.status == DownloadStatus.pending) {
                                    debugPrint('Download pending');
                                    setState(() {
                                      e.progress = 0;
                                      isDownloading = true;
                                    });
                                  } else if (event.status == DownloadStatus.canceling) {
                                    debugPrint('Download canceling');
                                    setState(() {
                                      e.progress = null;
                                      isDownloading = false;
                                    });
                                  }
                                });
                              }
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  e.progress != null ? const CupertinoActivityIndicator() : const Icon(Icons.download, color: Colors.white),
                                  Text(
                                    " ${e.progress != null ? '${e.progress} %' : 'Download'}",
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
