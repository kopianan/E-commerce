import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/bloc/category/category_bloc.dart';
import 'package:ecommerce_test/bloc/category/category_event.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/pages/category_page.dart';
import 'package:ecommerce_test/layouts/widgets/item_list.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SubCategoryCopy extends StatefulWidget {
  final List<CategoryModel> categoryList;
  final CategoryModel prevCategory;

  SubCategoryCopy({this.categoryList, this.prevCategory});

  @override
  _SubCategoryCopyState createState() => _SubCategoryCopyState();
}

class _SubCategoryCopyState extends State<SubCategoryCopy> {
  List<CategoryModel> list = List<CategoryModel>();
  CategoryBloc _btnBloc = CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Consumer<CartListData>(
      builder: (context, listData, _) =>  WillPopScope(
      onWillPop: () async {
        if(listData.historyCategoryModel.length>0){
          if(listData.historyCategoryModel.length ==1){
            return true;
          }else{
          listData.clearCategoryListLastIndex();
          listData.clearHistoryCategoryModelLastIndex();
//          _btnBloc.dispatch(GetCategoryByParentId(
//              parentId: listData.getHistoryCategoryModel()[listData.getHistoryCategoryModel().length-1].kategoriId,
//              prevCategory:listData.getHistoryCategoryModel()[listData.getHistoryCategoryModel().length-1]));
//            listData.historyCategoryModel.removeAt(listData.getHistoryCategoryModel().length);
          return false;
          }
        }else return true ;

      },
      child: Scaffold(
          appBar: AppBar(
            title:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listData.historyCategoryModel.length,
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    children: <Widget>[
                      InkWell(
                          onTap: (){
                            if(index == listData.historyCategoryModel.length-1){

                            }else {
                              listData.clearHistoryCategoryModelRange(index+1, listData.historyCategoryModel.length);
                              listData.clearCategoryListRange(index+1, listData.listOfLIstCategory.length);
                            }
                          },
                          child: Text(listData.historyCategoryModel[index].description,style: TextStyle(fontSize: 17),)),
                      Text(" >")
                    ],
                  );
                }),
            backgroundColor: Colors.black,
          ),
          body: BlocListener<CategoryBloc, CategoryState>(
            listener: (BuildContext context, CategoryState state) async {
              if (state is GetAllCategoryByParentIdSuccess) {
                listData.addCategoryList(state.categories);
                listData.addHistoryCategoryModel(state.prevCategoryModel);
              }
              if (state is GetAllCategoryByParentIdEnd) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ItemList(state.categoryId, state.categoryDesc),
                  ),
                );
              }
            },
            bloc: _btnBloc,
            child: BlocBuilder(
                bloc: _btnBloc,
                builder: (BuildContext context, CategoryState state) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                            itemCount: listData.getCategoryList().last.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 7 / 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {
                                    _btnBloc.dispatch(GetCategoryByParentId(
                                        parentId: listData
                                            .getCategoryList()
                                            .last[index]
                                            .kategoriId,
                                        prevCategory: listData
                                            .getCategoryList()
                                            .last[index]));
                                  },
                                  child: Card(
                                    elevation: 4,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              listData
                                                  .getCategoryList()
                                                  .last[index]
                                                  .description,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
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
                  );
                }),
          ),
        ),
      ),
    );
  }
}
