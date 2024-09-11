import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app_widgets/wallpaper_bg_widget.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/cubit/search_state.dart';
import 'package:wallpaper_app/utils/utils_helper.dart';

class SearchedWallpaperPage extends StatefulWidget {
  String query;
   SearchedWallpaperPage({required this.query});

  @override
  State<SearchedWallpaperPage> createState() => _SearchedWallpaperPageState();
}

class _SearchedWallpaperPageState extends State<SearchedWallpaperPage> {


@override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).getSearchWallpapers(query: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (_,state){
          
          if(state is SearchLoadedState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is SearchErrorState){
            return Center(
              child: Text(state.errorMsg),
            );
          }else if(state is SearchLoadedState){


            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
              
                
                      children: [
                        Text(widget.query, style: mTextStyle25(),),
                        Text("${state.totalWallpapers} Wallpaper Avaliable", style: mTextStyle14(),),
                        Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: state.listPhotos.length,
                itemBuilder: (_, index) {
                  var eachPhoto = state.listPhotos[index];
                  return WallpaperBgWidget(
                    imgUrl:eachPhoto.src!.original!);
                },
              ),
                        ),)
                      ],
                    ),
            );
          };

          return Container();
        },
      )
    );
  }
}