import 'package:ecommerce_test/bloc/category/category_event.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
   final String subCategoryName ;
   final List<CategoryModel> categories;

  SubCategory({
    Key key,
    @required this.subCategoryName,
    @required this.categories
  }) : super(key : key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List<CategoryModel> categories = List<CategoryModel>();

  @override
  Widget build(BuildContext context) {
    categories.addAll(widget.categories);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 7 / 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: InkWell(
                        onTap: () {
                          // categoryBloc.dispatch(GetAllCategoryByParentID(
                          //     categories[index].kategoriId,
                          //     categories[index].description));

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ItemList(
                          //         categories[index].kategoriId,
                          //         categories[index].description),
                          //   ),
                          // );
                        },
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[

                                  Flexible(
                                    child: Text(
                                      categories[index].description,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
