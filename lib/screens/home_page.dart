import 'package:Edudito/Provider/enrolment_prov.dart';
import 'package:Edudito/Provider/home_prov.dart';
import 'package:Edudito/helpers/strings.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/helpers/utils.dart';
import 'package:Edudito/screens/environment_details.dart';
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                SafeArea(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 21,
                      color: StyleGuide.mainColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                searchWidget(),
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

  Widget searchWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(horizontal: 30),
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
            child: TextField(
              cursorColor: StyleGuide.mainColor,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
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
                    for (int i = 0; i < snapshot.data.size && i <= 5; i++)
                      return Container(
                        padding: EdgeInsets.only(right: 10),
                        child: materialItem(
                          context,
                          snapshot.data.docs[i],
                        ),
                      );
                    return Center(child: Text('No courses yet'));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget materialItem(BuildContext context, QueryDocumentSnapshot snapshot) {
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 100 / 72,
              physics: NeverScrollableScrollPhysics(),
              children:
                  Strings.categories.map((e) => categoryImage(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryImage(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Image.asset(
            'assets/$name.jpg',
            height: 60,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 2),
        Text(name[0].toUpperCase() + name.substring(1)),
      ],
    );
  }
}
