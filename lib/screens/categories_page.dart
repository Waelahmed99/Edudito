import 'package:Edudito/Provider/categories_prov.dart';
import 'package:Edudito/Provider/enrolment_prov.dart';
import 'package:Edudito/screens/environment_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  final String name;
  CategoriesPage(this.name);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoriesProvider(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 2.3,
              title: Hero(
                child: Image.asset('assets/$name.png'),
                tag: name,
              ),
            ),
            Consumer<CategoriesProvider>(
              builder: (_, provider, d) => StreamBuilder<QuerySnapshot>(
                stream: provider.getCategories('${name.toLowerCase()}'),
                builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    //todo handle state
                    return SliverToBoxAdapter(
                        child:
                            CircularProgressIndicator()); //todo set progress bar
                  }
                  if (snap.hasData == null) {
                    return SliverToBoxAdapter(child: Container());
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => EnrollmentProvider(),
                              child: EnvironmentDetails(
                                  snapshot: snap.data.docs[index]),
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text('${snap.data.docs[index].get('title')}'),
                          subtitle:
                              Text('${snap.data.docs[index].get('author')}'),
                          leading:
                              Image.network(snap.data.docs[index].get('image')),
                        ),
                      ),
                      childCount: snap.data.size,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
