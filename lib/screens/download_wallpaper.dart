import 'package:flutter/material.dart';

class DownloadWallpaper extends StatelessWidget {
  const DownloadWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://e0.pxfuel.com/wallpapers/904/40/desktop-wallpaper-ocean-sunset-phone-zen-pink.jpg',
                ),
                fit: BoxFit.fill
                )
            ),
           
            ),

             Padding(
               padding: const EdgeInsets.fromLTRB(30, 800, 0, 0),
               child: Row(
                children: [
                  SizedBox(width: 60,),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('assets/icons/ic_info.png',
                    color: Colors.white,
                    scale: 15,
                    ),
                  ),


                  SizedBox(width: 30,),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('assets/icons/ic_download.png',
                    color: Colors.white,
                    scale: 5,
                    ),
                  ),


                  SizedBox(width: 30,),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('assets/icons/ic_apply.png',
                    color: Colors.white,
                    scale: 8,
                    
                    ),
                  ),
                ],
                           ),
             ),
        ],
      ),
      );
  
  }
}