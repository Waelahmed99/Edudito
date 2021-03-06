import 'package:Edudito/Provider/enrolment_prov.dart';
import 'package:Edudito/Provider/home_prov.dart';
import 'package:Edudito/helpers/strings.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/screens/categories_page.dart';
import 'package:Edudito/screens/environment_details.dart';
import 'package:Edudito/screens/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Home',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: StyleGuide.mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                searchWidget(context),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      popularForYou(context, title: 'Popular for you'),
                      SizedBox(height: 25),
                      categoriesWidget(context),
                      SizedBox(height: 25),
                      popularForYou(context, title: 'Highly recommend'),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchWidget(context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(SearchRoutePage(
        builder: (context) => SearchPage(),
      )),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 18,
              color: Colors.grey[600],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popularForYou(context, {String title}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              color: StyleGuide.mainColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 8),
        Consumer<HomeProvider>(
          builder: (_, prov, widg) => StreamBuilder(
            stream: title == 'Highly recommend'
                ? prov.getRecommendations()
                : prov.getPopularCourses(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );

              if (snapshot.data.docs.isNotEmpty)
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data.docs
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MaterialItem(
                              snapshot: e,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              else
                return Center(child: Text('No courses yet'));
            },
          ),
        ),
      ],
    );
  }

  Widget categoriesWidget(context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'What are you looking for',
              style: TextStyle(
                color: StyleGuide.mainColor,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 100 / 72,
              physics: NeverScrollableScrollPhysics(),
              children: Strings.categories
                  .map((e) => categoryImage(e, context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryImage(String name, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CategoriesPage(name))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Hero(
              tag: '$name',
              child: Image.asset(
                'assets/$name.png',
                height: 60,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(name[0].toUpperCase() + name.substring(1)),
      ],
    );
  }
}

class MaterialItem extends StatelessWidget {
  const MaterialItem({
    Key key,
    @required this.snapshot,
  }) : super(key: key);

  final QueryDocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => EnrollmentProvider(),
            child: EnvironmentDetails(
              snapshot: snapshot,
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/placeholder.jpg'),
              fit: BoxFit.fill,
              width: 250,
              image: NetworkImage(
                snapshot.get('image'),
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                snapshot.get('duration') + ' minutes',
                style: TextStyle(fontSize: 11),
              ),
              SizedBox(width: 10),
              Text(
                'Rating: ',
                style: TextStyle(fontSize: 11),
              ),
              for (int i = 0; i < 4; i++)
                Icon(
                  Icons.star,
                  size: 17,
                  color: snapshot.get('rating') > i
                      ? Color(0xffFBDF5B)
                      : Colors.grey[300],
                ),
            ],
          ),
          Text(
            snapshot.get('title'),
            style: TextStyle(
              fontSize: 11,
              color: StyleGuide.mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            snapshot.get('author'),
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
