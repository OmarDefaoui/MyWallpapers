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
  final List<String> _categoriesImages = [//replace
    'https://drive.google.com/uc?id=1wgQfuncWagmcXOBuwXW95OjoEd6CJoEB',
    'https://drive.google.com/uc?id=1NRh1J3I7aRvfnpRxIYHV42oygGEGyqot',
    'https://drive.google.com/uc?id=1SKu9Z7gRec8vnuY4h27dphlFFFpCa3pw',
    'https://drive.google.com/uc?id=1yBe5ln_Oy8Ez6RTGFuogULJf9qS81UAv',
    'https://drive.google.com/uc?id=1vTogCJzhKmiZq1oDOOPKDkVIOg5gf7Nw',
    'https://drive.google.com/uc?id=1yEAaSwJiMcWH1Y1u-AzKanDckl0F-BjP',
    'https://drive.google.com/uc?id=1rPyR5BW16_A5QuniBxWNugZE_7kxqzUl',
    'https://drive.google.com/uc?id=19b1rMf2Ke2aJ5FvYUMaRs-aFW4lp1fbs',
    'https://drive.google.com/uc?id=12e5qnKAYe7CzTYZZ0HGz3mZOdBDp7scd',
    'https://drive.google.com/uc?id=1nZlwZXCO63YfqYiDQviGJcb9AsFHzFtk',
    'https://drive.google.com/uc?id=1lEo0Xk2pTOxwrzJ7-xREaPHD4C7JyTTu',
    'https://drive.google.com/uc?id=1Lv6fExTrEXNfDw9K_7PgdGtBODz9J2J2',
    'https://drive.google.com/uc?id=1BX_DRqu1YYXHCwj36xDMnK6qTZqrjygh',
    'https://drive.google.com/uc?id=1Hfug0K-HlkTJyxD2xgNK1CfB_XTU9IE-',
    'https://drive.google.com/uc?id=1YL_6iMCTqgsr1eeefan18cM69R6krOKe',
    'https://drive.google.com/uc?id=1cNZLGlM0QV4VPpA9nkLhvGoL6I4VW9kN',
    'https://drive.google.com/uc?id=1GUkpWufv5pxeyCEa6X6lHKEiw0C5nkGC',
    'https://drive.google.com/uc?id=1-9zdcpEf99PLFm1GzK6F__-eyvv2bUkX',
    'https://drive.google.com/uc?id=1tLCYWZhbPpFM60iJHjs8oLAELBOkqVFZ',
    'https://drive.google.com/uc?id=1UKP0Ym_W3jj0v-lPPcK5lEOpKUnIET23',
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
                              fontSize: 20,
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
