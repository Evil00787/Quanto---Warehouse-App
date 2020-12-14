part of 'offline_cubit.dart';

abstract class OfflineState extends Equatable {
  const OfflineState();
}

class OfflineStateAll extends OfflineState {
  final bool isOnline;

  OfflineStateAll(this.isOnline);

  @override
  List<Object> get props => [isOnline];
}