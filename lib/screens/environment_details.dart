import 'package:Edudito/helpers/style_guide.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EnvironmentDetails extends StatelessWidget {
  final QueryDocumentSnapshot snapshot;

  EnvironmentDetails({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            LineAwesomeIcons.angle_left,
            color: StyleGuide.mainColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          snapshot.get('title'),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: StyleGuide.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        snapshot.get('image'),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            snapshot.get('duration'),
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
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.get('title'),
                        style: TextStyle(
                          fontSize: 17,
                          color: StyleGuide.mainColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.get('author'),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'About this course',
                      style: TextStyle(
                        fontSize: 20,
                        color: StyleGuide.mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      snapshot.get('des'),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Rate this course',
                      style: TextStyle(
                        fontSize: 20,
                        color: StyleGuide.mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Tell others what you think',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: RatingBar.builder(
                        initialRating: 3,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1),
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                            default:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xffFBDF5B),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'Enroll now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
