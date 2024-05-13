import 'package:get/get.dart';
import 'package:teklub/catalog/data/api_service_catalog.dart';
import 'package:teklub/catalog/models/catalog_model.dart';

class CatalogController extends GetxController {
  String searchName;
  String searchSku;

  setSearchName(name) {
    searchName = name;
    update();
  }

  Future<CatalogModel> userPromoCheck(String name) async {
    CatalogModel result = await ApiServiceCatalog.searchCatalog(name);
    print(result.data);
    print(name);
    return result;
  }
}
