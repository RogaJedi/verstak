import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(0, false));

  void setPage(int index, bool showBackButton) => emit(NavigationState(index, showBackButton));
}

class NavigationState {
  final int index;
  final bool showBackButton;

  NavigationState(this.index, this.showBackButton);
}