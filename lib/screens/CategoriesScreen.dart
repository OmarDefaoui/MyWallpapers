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
    'https://cdn.pixabay.com/photo/2019/12/15/08/14/body-painting-4696539_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/10/00/04/climber-4754210_150.jpg',
    'https://cdn.pixabay.com/photo/2019/12/18/13/59/christmas-4704072_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/15/14/29/europe-channel-4768094_150.jpg',
    'https://cdn.pixabay.com/photo/2019/01/30/08/30/book-3964050_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/09/15/03/hands-4752991_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/09/21/45/valentines-day-4754007_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/13/16/11/kyrgyzstan-4762839_150.jpg',
    'https://cdn.pixabay.com/photo/2019/12/30/03/28/banana-4728754_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/11/19/33/petra-4758513_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/12/09/27/cat-4759584_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/15/14/26/port-4768090_150.jpg',
    'https://cdn.pixabay.com/photo/2019/11/19/13/10/clementine-4637398_150.jpg',
    'https://cdn.pixabay.com/photo/2019/12/30/03/06/samsung-4728704_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/11/16/18/horse-4757973_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/12/08/52/helicopter-4759545_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/14/19/04/beach-4766019_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/11/18/38/goal-4758378_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/08/05/24/building-4749312_150.jpg',
    'https://cdn.pixabay.com/photo/2020/01/15/08/23/guitar-4767277_150.jpg',
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
