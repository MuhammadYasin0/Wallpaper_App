

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  WallpaperRepository wallpaperRepository;
  HomeCubit({required this.wallpaperRepository}): super(HomeInitialState());

 void getTrendingWallpapers() async{
      emit(HomeLoadingState());

      try{

        var data = await wallpaperRepository.getTrendingWallpapers();
        var wallpaperModel = WallpaperDataModel.fromJson(data);
        emit(HomeLoadedState(listPhotos: wallpaperModel.photos!));

      }catch(e){
        emit(HomeErrorState(errorMsg: e.toString()));
      }
  }
}