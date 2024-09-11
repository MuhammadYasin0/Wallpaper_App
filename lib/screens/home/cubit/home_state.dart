

import 'package:wallpaper_app/models/wallpaper_model.dart';
abstract class HomeState{}

class HomeInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}
class HomeLoadedState extends HomeState{
  List<PhotoModel> listPhotos;
  HomeLoadedState({required this.listPhotos});
}
class HomeErrorState extends HomeState{
  String errorMsg;
  HomeErrorState({required this.errorMsg});
}

