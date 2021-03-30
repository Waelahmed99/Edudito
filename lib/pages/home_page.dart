import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/pages/environment_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    categoriesWidget(),
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
              for (int i = 0; i < 3; i++)
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: materialItem(context, i + 1, time: '25 min'),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget materialItem(
    BuildContext context,
    int i, {
    String image,
    String time,
    int rating = 2,
    String name = 'The principles of design',
    String authorName = 'Hana',
    String authorImage = 'image',
  }) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EnvironmentDetails(id: '1'),
      )),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              'assets/cover$i.jpg',
              fit: BoxFit.fill,
              width: 250,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
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
                  color: rating > i ? Color(0xffFBDF5B) : Colors.grey[300],
                ),
            ],
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              color: StyleGuide.mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            authorName,
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget categoriesWidget() {
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
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Physics'),
              Text('Chemistry'),
              Text('Biology'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Mathematics'),
              Text('Design'),
              Text('Programming'),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryImage(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('$name.jpg'),
        SizedBox(height: 5),
        Text(name),
      ],
    );
  }
}
