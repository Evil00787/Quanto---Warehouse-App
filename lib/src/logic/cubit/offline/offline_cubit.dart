import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/services/db/products_rep.dart';

part 'offline_state.dart';

class OfflineCubit extends Cubit<OfflineState> {
  OfflineCubit() : super(OfflineStateAll(true));
  static final ProductsRepository _productsRepository = GetIt.I<ProductsRepository>();
  bool isOn = true;

  void setConnectionState(bool isOnline) {
    _productsRepository.isOnilne = isOnline;
    isOn = isOnline;
    emit(OfflineStateAll(isOnline));
  }
}

enum OPERATIONS {
  ADD, UPDATE, DELETE, QUANTITY,
}