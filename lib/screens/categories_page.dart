import 'package:Edudito/Provider/categories_prov.dart';
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Consumer<CategoriesProvider>(
                        builder: (_, provider, d) => StreamBuilder<QuerySnapshot>(
                          stream: provider.getCategories('${name.toLowerCase()}'),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                            final data = snap.data;
                            print(data.docs);
                            return ListTile( 
                            );
                          },
                        ),
                      ),
                  childCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
