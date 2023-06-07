import 'package:assignment_flutter/services/api_provider/api_provider.dart';
import 'package:assignment_flutter/services/models/Movie_detail_model.dart';
import 'package:assignment_flutter/services/models/movie_model.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  late AuthApiProvider _apiProvider;
  RxList<MovieModel> movieList = RxList();
  RxList<MovieModel> searchList = RxList();
  RxList<String> historyList = RxList();
  Rxn<MovieDetailModel> model = Rxn();
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  RxInt page = 1.obs;
  RxString userId = "".obs;
  RxBool isSearch = false.obs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  void onInit() {
    _apiProvider = AuthApiProvider();
    reset();
    _sharedPref();
    allMovies(1);
    getSearchData();
    scrollController.addListener(loadMore);
    super.onInit();
  }
 Future<void> _sharedPref()async{
    final SharedPreferences prefs = await _prefs;
    userId.value = prefs.getString("user_id")??"";
  }
  reset() {
    isSearch.value=false;
    page.value = 1;
    movieList.clear();
    searchList.clear();
    searchController.clear();
    model.value = null;
    userId.value ="";
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
      searchMovie(data.trim(), 1);
    }
  }

  Future<List<MovieModel>?> searchMovie(String text,num page) async {
    if (await Utils.hasNetwork()) {
      isSearch.value= true;
      Utils.showLoader();
      storeSearchData(text.trim());
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


  Future<void>  storeSearchData(String searchData) async {
    await _firebaseFirestore.collection('users').doc(userId.value).set({
      'searchData': FieldValue.arrayUnion([searchData.trim()]),
      'timestamp':FieldValue.serverTimestamp(),
    },SetOptions(merge: true));
  }


  Future<void> getSearchData() async {
   await _sharedPref();
    var snapshot = await _firebaseFirestore.collection('users').doc(userId.value).get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data.containsKey('searchData')) {
        historyList.clear();
        historyList.value = List<String>.from(data['searchData']);
        historyList.refresh();
      }
    }
  }

  Future<List<String>> getSuggestions(String query) async{
    await getSearchData();
    List<String> matches = <String>[];
    matches.addAll(historyList.value);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


}
