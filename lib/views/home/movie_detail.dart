import 'package:assignment_flutter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen(){
     var movieId = Get.arguments;
     _controller.movieDetail(movieId);

  }
 final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Movie Name"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: 200,
              width: Get.width,

            ),
            Text("title"),
            Text("tagline"),
            Text("vote_average"),
            Text("status"),
            Text("release_date"),
            Text("popularity"),
            Text("genres"),
            Text("overview"),

          ],

        ),
      ),

    );
  }
}
