
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/search/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState>{
  WallpaperRepository wallpaperRepository;
  SearchCubit({required this.wallpaperRepository}): super(SearchInitialState());

  void getSearchWallpapers({required String query})async{
  emit(SearchLoadingState());

  try{
      
     var mData = await wallpaperRepository.getSearchWallpapers(query);
     WallpaperDataModel wallpaperDataModel = WallpaperDataModel.fromJson(mData);
     emit(SearchLoadedState(listPhotos: wallpaperDataModel.photos!, totalWallpapers: wallpaperDataModel.total_results!));
  }catch(e){
    emit(SearchErrorState(errorMsg: e.toString()));
  }
  }
}