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
  int _youtubeNums = 1;
  int _documentNums = 1;

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
                Text(
                  'You can choose between several material types, links, documents, videos or AR. You can either upload a document or provide a link from article or cloud.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 7),
                for (int i = 0; i < _youtubeNums; i++)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // icon: Icon(Icons.perm_identity),
                        labelText: 'Youtube url#${i + 1}',
                      ),
                      onSubmitted: (value) {
                        /// [todo] validate youtube link first.
                        setState(() {
                          int toAdd = (value.isEmpty ? -1 : 1);
                          if (toAdd == 1 || (toAdd == -1 && _youtubeNums > 1))
                            _youtubeNums = _youtubeNums + toAdd;
                        });
                      },
                    ),
                  ),
                SizedBox(height: 15),
                for (int i = 0; i < _documentNums; i++)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // icon: Icon(Icons.perm_identity),
                        labelText: 'Document url#${i + 1}',
                      ),
                      onSubmitted: (value) {
                        /// [todo] validate document link first.
                        setState(() {
                          int toAdd = (value.isEmpty ? -1 : 1);
                          if (toAdd == 1 || (toAdd == -1 && _documentNums > 1))
                            _documentNums = _documentNums + toAdd;
                        });
                      },
                    ),
                  ),
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffFBDF5B),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Upload environment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
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
