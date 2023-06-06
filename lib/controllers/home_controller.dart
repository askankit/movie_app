import 'package:assignment_flutter/services/api_provider/api_provider.dart';
import 'package:assignment_flutter/services/models/Movie_detail_model.dart';
import 'package:assignment_flutter/services/models/movie_model.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late AuthApiProvider _apiProvider;
  RxList<MovieModel> movieList = RxList();
  Rxn<MovieDetailModel> model = Rxn();
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;

  @override
  void onInit() {
    _apiProvider = AuthApiProvider();
    allMovies(1);
    scrollController.addListener(loadMore);
    super.onInit();
  }

  reset() {
    page.value = 1;
    movieList.clear();
    model.value = null;
  }

  void loadMore() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      page.value++;
      allMovies(page.value++);
    }
  }

  Future<List<MovieModel>?> allMovies(num page) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
    var response = await _apiProvider.getAllMovies(page);
      Utils.hideLoader();
      if (response != null) {

        if(response.data["page"]==1){
          var list = (response.data["results"] as List)
              .map((e) => MovieModel.fromJson(e))
              .toList();
          movieList.clear();
          movieList.addAll(list);
          movieList.refresh();
        }else{
          var list = (response.data["results"] as List)
              .map((e) => MovieModel.fromJson(e))
              .toList();
          var previousFavProducts = movieList;
          previousFavProducts.addAll(list);
          list.addAll(previousFavProducts);
          movieList.clear();
          movieList.addAll(list);
          movieList.refresh();
        }
      }
    }
  }

  Future<MovieModel?> movieDetail(num id) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
      var response = await _apiProvider.getMovieDetail(id: id);
      Utils.hideLoader();
      if (response != null) {
        model.value = response;
      }
    }
  }
}
