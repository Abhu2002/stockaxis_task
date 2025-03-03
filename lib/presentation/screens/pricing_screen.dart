import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pricing_controller.dart';
import '../widgets/pricing_dropdown.dart';

class PricingScreen extends StatelessWidget {
  final PricingController controller = Get.put(PricingController());

  PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        title: const Text('Pricing', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: Colors.white,
                title: "Help",
                middleText:
                    "Select a pricing plan to proceed with payment.\nIf you select two or more plans, you get a 20% discount.",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                onConfirm: () => Get.back(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => Visibility(
                visible: controller.alertMsg.isNotEmpty,
                child: Container(
                  color: Colors.green,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Text(controller.alertMsg.value,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center),
                ),
              )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                DropdownWidget(
                  title: "Little Masters",
                  subtitle: "Small Cap",
                  description:
                      "Invest in up - trending Smallcap stocks screened through MILARS strategy to generate wealth",
                  plans: controller.littleMastersPlans,
                  selectedValue: controller.selectedLM,
                ),
                DropdownWidget(
                  title: "Emerging Market Leaders",
                  subtitle: "Mid Cap",
                  description:
                      "Generate Wealth by riding momentum in Midcap stock screened through MILARS strategy",
                  plans: controller.emergingMarketLeadersPlans,
                  selectedValue: controller.selectedEML,
                ),
                DropdownWidget(
                  title: "Large Cap Focus",
                  subtitle: "Large Cap",
                  description:
                      "Achieve stable growth in your portfolio by  investing in Bluechip stocks passed through MILARS strategy",
                  plans: controller.largeCapFocusPlans,
                  selectedValue: controller.selectedLCF,
                ),
              ],
            ),
          ),
          Obx(() => Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rs. ${controller.totalAmount.value}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Set your desired radius here
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Proceed For Payment",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
