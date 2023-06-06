import 'package:assignment_flutter/controllers/home_controller.dart';
import 'package:assignment_flutter/services/api_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/app_colors.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen() {
    var movieId = Get.arguments;
    _controller.movieDetail(movieId);
  }

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.cyan,
                width: Get.width,
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(
                  () => CachedNetworkImage(
                    imageUrl:
                        "${ApiConstants.imageUrl}${_controller.model.value?.belongsToCollection?.posterPath}",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return const SizedBox(
                        width: 120,
                        height: 140,
                        child: Center(
                          child: SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.themeColor),
                              strokeWidth: 3.5,
                            ),
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        width: 120,
                        height: 140,
                        color: AppColor.themeColor,
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
              ),
              Obx(() => Text(
                    _controller.model.value?.title ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  )),
              const SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                    _controller.model.value?.tagline ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12),
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text("${_controller.model.value?.voteAverage?.toStringAsFixed(1)}/10",
                style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(_controller.model.value?.status ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),
              )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(_controller.model.value?.releaseDate ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
         /*     Obx(() =>
                  Text(_controller.model.value?.popularity.toString() ?? "")),
              const SizedBox(
                height: 10,
              ),*/
              Obx(() => Text(_controller.model.value?.genres != null
                  ? _controller.model.value!.genres!.map((e) => e.name).join(",")
                  : "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(_controller.model.value?.overview ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15),)),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
