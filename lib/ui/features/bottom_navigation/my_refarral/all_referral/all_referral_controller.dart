import 'package:cPocket/data/models/my_refferal.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:get/get.dart';

class AllReferralController extends GetxController {
  RxList<dynamic> allReferralList = <dynamic>[].obs;
  bool isLoading = true;

  void getAllReferralList(String key) {
    (key == FromKey.references ? APIRepository().getReferenceList() : APIRepository().getEarning(true)).then((resp) {
      isLoading = false;
      allReferralList.clear();
      if (resp.success) {
        if (key == FromKey.references) {
          try {
            // Map refMap =  resp.data as Map;
            // List refList = refMap.values.toList();
            // List<Reference> list = List<Reference>.from(refList.map((x) => Reference.fromJson(x)));
            //
            List<Reference> list = List<Reference>.from(resp.data.map((x) => Reference.fromJson(x)));
            allReferralList.addAll(list);
          } catch(e){
            printError();
          }
        } else {
          List<Earning> list = List<Earning>.from(resp.data.map((x) => Earning.fromJson(x)));
          allReferralList.addAll(list);
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
    });
  }
}
