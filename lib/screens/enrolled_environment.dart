import 'package:Edudito/Provider/enrolment_prov.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/helpers/utils.dart';
import 'package:Edudito/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EnrolledEnvironments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid =
        Utils.provider(context, listen: false).firebaseAuth.currentUser.uid;
    return ChangeNotifierProvider(
      create: (context) => EnrollmentProvider(),
      child: Scaffold(
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
            'Enrolled environments',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: StyleGuide.mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<EnrollmentProvider>(
            builder: (context, provider, child) => StreamBuilder(
              stream: provider.getEnrolled(uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(StyleGuide.mainColor),
                    ),
                  );
                var data = snapshot.data.docs.reversed.toList();
                if (data.isNotEmpty)
                  return ListView.separated(
                    padding: EdgeInsets.all(12),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(color: Colors.grey)),
                    itemBuilder: (context, index) =>
                        MaterialItem(snapshot: data[index]),
                  );
                return Center(
                  child: Text('No enrolled environmnets'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
