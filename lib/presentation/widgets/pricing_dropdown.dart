import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/pricing_plan.dart';
import '../controllers/pricing_controller.dart';

class DropdownWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final RxString selectedValue;
  final List<PricingPlan> plans;

  const DropdownWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.plans,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                const SizedBox(height: 10),
                Text(description,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  value: selectedValue.value.isEmpty
                      ? "Select a plan (inclusive of GST) - Rs. 0"
                      : selectedValue.value,
                  items: [
                    const DropdownMenuItem<String>(
                      value: "Select a plan (inclusive of GST) - Rs. 0",
                      child: Text("Select a plan (inclusive of GST)",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ...plans.map((plan) {
                      return DropdownMenuItem<String>(
                        value: "${plan.pDescription} - Rs. ${plan.pAmount}",
                        child:
                            Text("${plan.pDescription} - Rs. ${plan.pAmount}"),
                      );
                    }).toList(),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      selectedValue.value = val;
                      Get.find<PricingController>().alertMsg.value = plans
                          .firstWhere(
                            (plan) =>
                                '${plan.pDescription} - Rs. ${plan.pAmount}' ==
                                val,
                            orElse: () => PricingPlan(
                              pCode: "",
                              pDescription: "",
                              pAmount: 0,
                              pDuration: "",
                              pkgName: "",
                              comboOffer: 0,
                              alertMsg: "",
                              couponCode: "",
                              srNo: 0,
                              pTotalAmount: "",
                            ),
                          )
                          .alertMsg;
                      Get.find<PricingController>().calculateTotal();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
