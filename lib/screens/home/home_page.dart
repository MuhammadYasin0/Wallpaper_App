import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app_widgets/wallpaper_bg_widget.dart';
import 'package:wallpaper_app/constants/app_constants.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/screens/home/cubit/home_state.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/searched_wallpaper_page.dart';
import 'package:wallpaper_app/utils/utils_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              style: mTextStyle12() ,
              decoration: InputDecoration(
                hintText: 'Find Wallpaper...',
                hintStyle: mTextStyle16(
                  mColor: Colors.grey.shade400,
                ),
                suffixIcon: InkWell(
                  onTap: (){
                    if(searchController.text.isNotEmpty){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context)=> BlocProvider(
                            create: (context)=> SearchCubit(
                              wallpaperRepository: WallpaperRepository(
                        
                        apiHelper:ApiHelper())),

                        child: SearchedWallpaperPage(query: searchController.text,),
                        )),);
                    }
                  },
                  child: Icon(
                    Icons.search_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                filled: true,
                fillColor: AppColors.secondaryLightColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Text(
              'Best of Month',
              style: mTextStyle16(
                mFontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 200,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (_, state) {
                if (state is HomeLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeErrorState) {
                  return Center(
                    child: Text('${state.errorMsg}'),
                  );
                } else if (state is HomeLoadedState) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.listPhotos.length,
                    itemBuilder: (_, index) {
                      var eachPhoto = state.listPhotos[index];

                      return Padding(
                        padding: EdgeInsets.only(
                            left: 11.0,
                            right: index == AppConstant.mCategories.length - 1
                                ? 11
                                : 0),
                        child: eachPhoto.src?.original != null
                            ? WallpaperBgWidget(imgUrl: eachPhoto.src!.original!)
                            : Center(child: Text('Image not available')),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Color Tone',
              style: mTextStyle16(
                mFontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstant.mColors.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 11.0,
                      right: index == AppConstant.mColors.length - 1 ? 11 : 0),
                  child: getColorToneWidget(AppConstant.mColors[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Text(
              'Categories',
              style: mTextStyle16(
                mFontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 11,
                crossAxisSpacing: 11,
                childAspectRatio: 8 / 4,
              ),
              itemCount: AppConstant.mCategories.length,
              itemBuilder: (_, index) {
                return getCategoryWidget(
                  AppConstant.mCategories[index]['image'],
                  AppConstant.mCategories[index]['title'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getColorToneWidget(Color mColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: mColor,
        borderRadius: BorderRadius.circular(11),
      ),
    );
  }

  Widget getCategoryWidget(String? imgUrl, String title) {
    return Container(
      child: Center(
        child: Text(
          title,
          style: mTextStyle14(mColor: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        image: imgUrl != null && imgUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {
                  // Handle image load error
                  print('Error loading image: $error');
                },
              )
            : null,
        color: imgUrl == null || imgUrl.isEmpty ? Colors.grey : null,
      ),
    );
  }
}
