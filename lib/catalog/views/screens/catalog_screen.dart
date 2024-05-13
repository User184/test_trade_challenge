import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/catalog/data/api_service_catalog.dart';
import 'package:teklub/catalog/views/widgets/item_catalog_widget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String searchType = 'catalog';
  String search;

  bool filter = false;

  bool skuChange = false;

  List<dynamic> listCatalog = [];

  int currentPage = 0;

  getPagCatalog() async {
    print('getPagCatalog()');
    listType = 'main';
    currentPage++;
    var result = await ApiServiceCatalog.getCatalog(
      20,
      currentPage,
    );

    listCatalog.addAll(result.data);
    print('curr$currentPage');
    setState(() {});
  }

  String listType;

  getSearch() async {
    listType = 'search';
    listCatalog.clear();
    var result = await ApiServiceCatalog.searchCatalog(search);
    if (result.data.isEmpty) {
      listCatalog.add(0);
      setState(() {});
    } else {
      listCatalog.addAll(result.data);
      setState(() {});
    }
  }

  getSearchSkuFilter(typeFilter) async {
    currentPage++;
    var result =
        await ApiServiceCatalog.searchCatalogScu(20, currentPage, typeFilter);

    setState(() {
      listCatalog.addAll(result.data);
    });
  }

  getSearchSkuFilterBack(typeFilter) async {
    currentPage++;

    var result = await ApiServiceCatalog.searchCatalogBackScu(
        20, currentPage, typeFilter);

    setState(() {
      listCatalog.addAll(result.data);
    });
  }

  getAll(typeFilter) {
    if (filter == true) {
      getSearchSkuFilterBack(typeFilter);
    } else {
      getSearchSkuFilter(typeFilter);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPagCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0x0fffffff),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 2.0,
                shadowColor: Colors.blue.withOpacity(0.3),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            setState(() {
                              searchType = 'search';
                              if (search != null) {
                                getSearch();
                              }
                            });
                          },
                          icon: const Icon(Icons.search)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xffffffff),
                          width: 0.5,
                        ),
                      ),
                      labelText: 'Поиск',
                      labelStyle: const TextStyle(color: Colors.grey)),
                  onChanged: (e) {
                    search = e;
                    if (e.isEmpty) {
                      setState(() {
                        listType = 'main';
                        listCatalog.clear();
                        getPagCatalog();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 15,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, top: 5),
              //   child: DropdownButton<String>(
              //     elevation: 10,
              //     hint: const Text('Сортировать'),
              //     items:
              //         <String>['По имени', 'По артикулу'].map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: CommonTextWidget(
              //             text: value,
              //             fontWeight: FontWeight.w500,
              //             size: 18,
              //             color: const Color(0xff49536D),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (val) {
              //       if (val == 'По имени') {
              //         setState(() {
              //           listType = 'byName';
              //           currentPage = 0;
              //           filter = !filter;
              //           listCatalog.clear();
              //           getAll('name');
              //         });
              //       } else {
              //         setState(() {
              //           listType = 'bySku';
              //           currentPage = 0;
              //           filter = !filter;
              //           listCatalog.clear();
              //           getAll('sku');
              //         });
              //       }
              //     },
              //   ),
              // ),
              Expanded(
                child: listCatalog.contains(0)
                    ? const Center(
                        child: CommonTextWidget(
                          text: 'Товар не найден',
                          size: 18,
                          color: Color(0xff49536D),
                        ),
                      )
                    : listCatalog == null || listCatalog.isEmpty
                        ? const Center(child: CircularProgressIndicator()

                            // CommonTextWidget(
                            //   text: 'Каталог товаров пуст',
                            //   size: 18,
                            //   color: Color(0xff49536D),
                            // ),
                            )
                        : LazyLoadScrollView(
                            scrollOffset: 60,
                            onEndOfPage: () {
                              switch (listType) {
                                case 'main':
                                  getPagCatalog();
                                  break;
                                case 'byName':
                                  getAll('name');
                                  break;
                                case 'bySku':
                                  getSearchSkuFilterBack('sku');
                                  break;
                              }
                            },
                            child: GridView.count(
                                shrinkWrap: true,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.5,
                                children: listCatalog
                                    .map(
                                      (e) => ItemCatalogWidget(
                                        type: e.promoType,
                                        title: e.name,
                                        imageUrl: e.productCover ?? [],
                                        price: e.price,
                                        sku: e.sku,
                                        text: e.description,
                                        video: e.productVideo,
                                      ),
                                    )
                                    .toList()),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
