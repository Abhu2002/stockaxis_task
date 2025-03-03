import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/model/pricing_plan.dart';

class PricingController extends GetxController {
  var littleMastersPlans = <PricingPlan>[].obs;
  var emergingMarketLeadersPlans = <PricingPlan>[].obs;
  var largeCapFocusPlans = <PricingPlan>[].obs;

  var selectedLM = "".obs;
  var selectedEML = "".obs;
  var selectedLCF = "".obs;
  var totalAmount = 0.0.obs;
  var alertMsg = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPricing();
  }

  Future<void> fetchPricing() async {
    await fetchProduct('LM', littleMastersPlans);
    await fetchProduct('EML', emergingMarketLeadersPlans);
    await fetchProduct('LCF', largeCapFocusPlans);
  }

  Future<void> fetchProduct(
      String pkgName, RxList<PricingPlan> plansList) async {
    final url =
        'https://www.stockaxis.com/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=$pkgName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = response.body.trim();
      int jsonEnd = body.indexOf('<!DOCTYPE');
      if (jsonEnd != -1) {
        body = body.substring(0, jsonEnd).trim();
      }

      var data = jsonDecode(body);

      if (data != null && data['data'] is List) {
        List<PricingPlan> plans = (data['data'] as List)
            .map((item) => PricingPlan.fromJson(item))
            .toList();
        plansList.assignAll(plans);
      }
    }
  }

  void calculateTotal() {
    double sum = 0;
    var selections = [selectedLM.value, selectedEML.value, selectedLCF.value];

    for (var selection in selections) {
      if (selection.isNotEmpty &&
          selection != "Select a plan (inclusive of GST) - Rs. 0") {
        try {
          sum += double.parse(selection.split('- Rs. ')[1].trim());
        } catch (e) {
          print("Error parsing amount: $selection");
        }
      }
    }

    // Apply 20% discount if 2 or more plans are selected
    if (selections
            .where((e) =>
                e.isNotEmpty && e != "Select a plan (inclusive of GST) - Rs. 0")
            .length >=
        2) {
      sum *= 0.8;
    }

    totalAmount.value = sum;
  }
}
