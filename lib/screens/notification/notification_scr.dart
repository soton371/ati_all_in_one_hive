
import 'package:ati_all_in_one_hive/blocs/notification/notification_bloc.dart';
import 'package:ati_all_in_one_hive/screens/notification/components/notification_error_scr.dart';
import 'package:ati_all_in_one_hive/screens/notification/components/notification_list_scr.dart';
import 'package:ati_all_in_one_hive/widgets/my_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(CallNotification());
    return Scaffold(
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state){
          if (state is NotificationFailedState) {
            return NotificationErrorScreen(message: state.errorMsg,);
          } else if (state is NotificationFetchedState){
            return NotificationListScreen(notifications: state.notificationList,);
          }else{
            return myWidgetLoader(context);
          }
        }
        ),
    );
  }
}