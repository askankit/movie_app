import 'package:assignment_flutter/services/api_provider/api_provider.dart';
import 'package:assignment_flutter/services/models/Movie_detail_model.dart';
import 'package:assignment_flutter/services/models/movie_model.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
late AuthApiProvider _apiProvider;
 RxList<MovieModel> movieList = RxList();
 Rxn<MovieDetailModel> model = Rxn();



  @override
  void onInit() {
    _apiProvider = AuthApiProvider();
    allMovies();
    super.onInit();
  }

  Future<List<MovieModel>?> allMovies()async{
    if(await Utils.hasNetwork()){
      Utils.showLoader();
      List<MovieModel>? response = await _apiProvider.getAllMovies();
      Utils.hideLoader();
      if(response!= null){
        movieList.clear();
        for(var item in response){
          movieList.add(item);
        }
        movieList.refresh();
      }
    }
  }


  Future<MovieModel?> movieDetail(num id)async{
    if(await Utils.hasNetwork()){
      Utils.showLoader();
     var response = await _apiProvider.getMovieDetail(id: id);
      Utils.hideLoader();
      if(response!= null){
        model.value = response;
      }
    }
  }



}