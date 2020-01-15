import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/screens/CategoryContentScreen.dart';
import 'package:wallpapers/utils/ApiKey.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String url = "https://pixabay.com/api/?key=$apiKey" +
      "&image_type=photo&orientation=vertical&safesearch=true&category=";

  final List<String> _categories = [
    'fashion',
    'nature',
    'backgrounds',
    'science',
    'education',
    'people',
    'feelings',
    'religion',
    'health',
    'places',
    'animals',
    'industry',
    'food',
    'computer',
    'sports',
    'transportation',
    'travel',
    'buildings',
    'business',
    'music',
  ];
  final List<String> _categoriesImages = [
    'https://pixabay.com/get/52e6dc454f51a514f6da8c7dda79367f163fd6e656596c48702872d5954fc051b0_1280.jpg',
    'https://pixabay.com/get/52e7d6404e54ab14f6da8c7dda79367f163fd6e656596c48702872d49449c55ebf_1280.jpg',
    'https://pixabay.com/get/52e7d5474a55ae14f6da8c7dda79367f163fd6e656596c48702872d49449c459ba_1280.jpg',
    'https://pixabay.com/get/52e7d1454f53af14f6da8c7dda79367f163fd6e656596c48702872d49449c759bd_1280.jpg',
    'https://pixabay.com/get/55e9d3474a57ac14f6da8c7dda79367f163fd6e656596c48702872d49449c65cbc_1280.jpg',
    'https://pixabay.com/get/52e7d640435ba514f6da8c7dda79367f163fd6e656596c48702872d49449c650bb_1280.jpg',
    'https://pixabay.com/get/52e7d0474a52ab14f6da8c7dda79367f163fd6e656596c48702872d49449c15bbb_1280.jpg',
    'https://pixabay.com/get/52e7d3414251a514f6da8c7dda79367f163fd6e656596c48702872d49449c15eb9_1280.jpg',
    'https://pixabay.com/get/52e6d7464e55aa14f6da8c7dda79367f163fd6e656596c48702872d49449c05ab8_1280.jpg',
    'https://pixabay.com/get/52e7d04b4955a414f6da8c7dda79367f163fd6e656596c48702872d49449c051bb_1280.jpg',
    'https://pixabay.com/get/52e7d0444a55a414f6da8c7dda79367f163fd6e656596c48702872d49449c35ab9_1280.jpg',
    'https://pixabay.com/get/52e7d0404e5baf14f6da8c7dda79367f163fd6e656596c48702872d49449c35eb9_1280.jpg',
    'https://pixabay.com/get/52e6d644495ba414f6da8c7dda79367f163fd6e656596c48702872d49449c258bf_1280.jpg',
    'https://pixabay.com/get/52e7d74b4d52a814f6da8c7dda79367f163fd6e656596c48702872d49449c25cbb_1280.jpg',
    'https://pixabay.com/get/52e7d0444355af14f6da8c7dda79367f163fd6e656596c48702872d49448c351bd_1280.jpg',
    'https://pixabay.com/get/52e7d04a4f56a914f6da8c7dda79367f163fd6e656596c48702872d49448c25abc_1280.jpg',
    'https://pixabay.com/get/52e7d0414e51a814f6da8c7dda79367f163fd6e656596c48702872d49448cd58bc_1280.jpg',
    'https://pixabay.com/get/52e7d04b4f53af14f6da8c7dda79367f163fd6e656596c48702872d49448cd5bb8_1280.jpg',
    'https://pixabay.com/get/52e7d14a4c5aad14f6da8c7dda79367f163fd6e656596c48702872d49448cd5fb8_1280.jpg',
    'https://pixabay.com/get/52e7d3434854a914f6da8c7dda79367f163fd6e656596c48702872d49448cc58ba_1280.jpg',
  ];
 
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xff323639),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: _width / 2,
                      height: _width * 0.75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: _categoriesImages[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            child: Image.asset('images/loading.gif'),
                            color: Colors.black,
                            alignment: Alignment.center,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryContentScreen(
                                title: _categories[index],
                                url: url + _categories[index] + '&page=',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: _width * 0.03),
                          child: Text(
                            '${_categories[index][0].toUpperCase()}${_categories[index].substring(1)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
