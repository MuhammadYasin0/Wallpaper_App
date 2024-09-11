import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constants/app_constants.dart';
import '../utils/utils_helper.dart';

class DetailWallpaperPage extends StatelessWidget {
  const DetailWallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
            
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 280, 0),
                  child: Text('Nature',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  )
                  ),
                ),
               
               Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 200, 0),
                  child: Text('36 wallpapers avaliable',
                  style: TextStyle(
                    fontSize: 19,
                    
                    color: Colors.black38
                    
                  )
                  ),
                ),
            
            
                SizedBox(
                  height: 15,
                ),
            
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: SizedBox(
                            height: 3120,
                            width: 420,
                            child: StaggeredGrid.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 10,
                              children: List.generate(AppConstant.mDetail.length, (index) {
                                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: index.isEven ? 2 : 3,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20) ,
                        child: Image.network(
                          AppConstant.mDetail[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                                );
                              }),
                    ),
                    ),
                  ),
            
              ],
            ),
          ],
        ),
      ),
    );
  }
}