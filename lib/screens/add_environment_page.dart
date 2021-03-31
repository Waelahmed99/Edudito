import 'package:Edudito/helpers/strings.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddEnvironmentPage extends StatefulWidget {
  @override
  _AddEnvironmentPageState createState() => _AddEnvironmentPageState();
}

class _AddEnvironmentPageState extends State<AddEnvironmentPage> {
  int _selectedCategory = -1;

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
          'Add environment',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: StyleGuide.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Describe your environment',
                    style: TextStyle(
                      color: StyleGuide.mainColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: AssetImage('assets/placeholder.jpg'),
                    // ),
                  ),
                  child: Text(
                    'Pick environment\'s image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // icon: Icon(Icons.perm_identity),
                      labelText: 'Environment name',
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // icon: Icon(Icons.perm_identity),
                      labelText: 'Environment description',
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Category',
                  style: TextStyle(
                    color: StyleGuide.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Strings.categories
                        .asMap()
                        .map((key, value) =>
                            MapEntry(key, categoryItem(value, key)))
                        .values
                        .toList(),
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Next, add your materials',
                    style: TextStyle(
                      color: StyleGuide.mainColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryItem(String item, int idx) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = idx),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: idx == _selectedCategory ? Colors.blue : null,
          border: Border.all(
              width: 1,
              color: idx == _selectedCategory ? Colors.blue : Colors.blue),
        ),
        child: Text(
          item,
          style: TextStyle(
            color: idx == _selectedCategory ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
