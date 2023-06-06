import 'package:assignment_flutter/controllers/home_controller.dart';
import 'package:assignment_flutter/services/api_constant.dart';
import 'package:assignment_flutter/views/auth/app_colors.dart';
import 'package:assignment_flutter/views/home/movie_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies"),automaticallyImplyLeading: false,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller.searchController ,
                  onChanged: _controller.search,
                  decoration:  InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Search Movie...",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),

                  )
              ),
              suggestionsCallback: (pattern) {
                return CitiesService.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.toString()),
                );
              },
              noItemsFoundBuilder: (context){
                return const SizedBox();
              },
              errorBuilder: (context,e){
                return const SizedBox();

              },

              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                _controller.searchController.text = suggestion.toString();
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please select a city';
                }
              },

            ),
          /*  TextFormField(
              controller: _controller.searchController,
              onChanged: _controller.search,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                //add prefix icon
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Search Movie...",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),

              ),
            ),*/
            Expanded(
              child: Obx(
                ()=>    (_controller.isSearch.value && _controller.searchList.isEmpty) ||
                    (_controller.isSearch.isFalse && _controller.movieList.isEmpty)?const Center(
                  child: Text("No data found",
                    style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                ):
                RefreshIndicator(
                  onRefresh: () async{
                    _controller.reset();
                    _controller.allMovies(1);
                    },
                  child: Scrollbar(
                    controller: _controller.scrollController,
                    child: ListView.builder(
                      controller: _controller.scrollController,
                      itemCount: _controller.isSearch.value ?_controller.searchList.length:_controller.movieList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data =   _controller.isSearch.value ?_controller.searchList[index]:_controller.movieList[index];
                        return  GestureDetector(
                          onTap: (){
                               Get.to(()=> MovieDetailScreen(),arguments:data.id);
                            },
                          child: Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                   Container(
                                  color: Colors.cyan,
                                  width: 120,
                                  height: 140,
                                     margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                     child: CachedNetworkImage(
                                    imageUrl: "${ApiConstants.imageUrl}${data.posterPath}",
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 120,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit:BoxFit.fill,
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
                                            width:  10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>(AppColor.themeColor),
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
                                        color: AppColor.themeColor ,
                                        child: const Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                                 const SizedBox(width: 10,),
                                  Expanded(
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data.title??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                        Text(data.originalLanguage??"",
                                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                        ),
                                        Text("${data.voteAverage}/10",
                                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                        ),
                                        Text(data.overview??"",
                                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,),


                                      ],
                                ),
                                   ),
                                 )
                              ],
                            ) ,
                          ),
                        );
                      },),
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}