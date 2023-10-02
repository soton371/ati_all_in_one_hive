part of 'route_bloc.dart';

abstract class RouteState extends Equatable {
  const RouteState();
  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {
}
class RouteLoginState extends RouteState {}
class RouteDashboardState extends RouteState {}
class NoticeAlertState extends RouteState {
  final String title, content;
  final bool updateIs;
  const NoticeAlertState(this.title, this.content, this.updateIs);
}
