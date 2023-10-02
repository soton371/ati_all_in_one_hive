import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_sizes.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/components/not_install_items.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/components/reorderable_items.dart';
import 'package:ati_all_in_one_hive/widgets/my_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardElements extends StatelessWidget {
  const DashboardElements({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAppListBloc, FetchAppListState>(builder: (context, state) {
      if (state is FetchAppListLoadingState) {
        return Center(child: SizedBox(height: 2, width: MySizes.width(context) / 2, child: LinearProgressIndicator(borderRadius: BorderRadius.circular(MySizes.radius),)));
      } else if (state is FetchAppListFailedState) {
        return Center(
          child: SvgPicture.asset('assets/images/something-went-wrong.svg',height: 80,width: 80,),
        );
      } else if (state is FetchAppListFetchedState) {

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            state.installedAppList.isNotEmpty ? ReorderableItems(state.installedAppList) : const SizedBox(),
            state.notInstalledAppList.isNotEmpty ? NotInstallItems(state.notInstalledAppList) : const SizedBox(),
          ],
        );
      }
      return myWidgetLoader(context);
    });
  }
}
