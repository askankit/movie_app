import 'package:assignment_flutter/services/api_provider/api_provider.dart';
import 'package:assignment_flutter/services/models/Movie_detail_model.dart';
import 'package:assignment_flutter/services/models/movie_model.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late SharedPreferences _sharedPreferences;
  late AuthApiProvider _apiProvider;
  RxList<MovieModel> movieList = RxList();
  RxList<MovieModel> searchList = RxList();
  Rxn<MovieDetailModel> model = Rxn();
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  RxInt page = 1.obs;
  RxBool isSearch = false.obs;
  final debounce =   Debouncer(delay: const Duration(milliseconds: 1000),);
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  @override
  void onInit() {
    _apiProvider = AuthApiProvider();
    _sharedPref();
    reset();
    allMovies(1);
    scrollController.addListener(loadMore);
    super.onInit();
  }
_sharedPref()async{
  _sharedPreferences = await SharedPreferences.getInstance();
  }
  reset() {
    isSearch.value=false;
    page.value = 1;
    movieList.clear();
    searchList.clear();
    searchController.clear();
    model.value = null;
  }

  void loadMore() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      page.value++;
      if(isSearch.value){
        searchMovie(searchController.text.trim(),page.value);
      }else{
        allMovies(page.value++);
      }
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

  search(String data) async{
    if(data.trim().isEmpty){
      isSearch.value= false;
    }else{
      isSearch.value= true;
      debounce.call(()=> searchMovie(data, 1));
    }
  }

  Future<List<MovieModel>?> searchMovie(String text,num page) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
    var response = await _apiProvider.searchMovie(text, page);
      Utils.hideLoader();
      if (response != null) {
        if(response.data["page"]==1){
          var list = (response.data["results"] as List)
              .map((e) => MovieModel.fromJson(e))
              .toList();
          searchList.clear();
          searchList.addAll(list);
          searchList.refresh();
        }else{
          var list = (response.data["results"] as List)
              .map((e) => MovieModel.fromJson(e))
              .toList();
          var previousFavProducts = searchList;
          previousFavProducts.addAll(list);
          list.addAll(previousFavProducts);
          searchList.clear();
          searchList.addAll(list);
          searchList.refresh();
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

  Future<void> login() async {
    if(await Utils.hasNetwork()){
      //  await _firebaseFirestore.collection('users').doc("user.uid").collection('messages').doc("msg_id").set(data)
      await _firebaseFirestore.collection('users').doc(_sharedPreferences.getString("user_id")).set({
        'keyword': searchController.text.trim(),
      });
    }

  }
/*  await FirebaseFirestore.instance
      .collection(collection)
      .doc("doc_id")
      .collection('messages')
      .doc("msg_id")
      .set(data)*/



}
