import 'package:dncrp_consumer_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';

class AddComplainScreen extends ConsumerStatefulWidget {
  final Person person;

  const AddComplainScreen({super.key, required this.person});

  @override
  ConsumerState<AddComplainScreen> createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends ConsumerState<AddComplainScreen> {
  late final TextEditingController nameController;
  late final TextEditingController fatherNameController;
  late final TextEditingController motherNameController;
  late final TextEditingController nidNumberController;
  late final TextEditingController divisionController;
  late final TextEditingController districtController;
  late final TextEditingController postalCodeController;
  late final TextEditingController professionController;
  // ----
  final organisationNameController = TextEditingController();
  final organisationAddressController = TextEditingController();
  final organisationDivisionController = TextEditingController();
  final organisationDistrictController = TextEditingController();
  final organisationPostalCodeController = TextEditingController();
  final organisationComplainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.person.complainer.name);
    fatherNameController =
        TextEditingController(text: widget.person.complainer.fatherName);
    motherNameController =
        TextEditingController(text: widget.person.complainer.motherName);
    nidNumberController =
        TextEditingController(text: widget.person.complainer.identificationNo);
    divisionController =
        TextEditingController(text: widget.person.complainer.division);
    districtController =
        TextEditingController(text: widget.person.complainer.district);
    postalCodeController = TextEditingController(
        text: widget.person.complainer.postalCode.toString());
    professionController =
        TextEditingController(text: widget.person.complainer.profession);
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    nidNumberController.dispose();
    divisionController.dispose();
    districtController.dispose();
    postalCodeController.dispose();
    professionController.dispose();
    // ---
    organisationNameController.dispose();
    organisationAddressController.dispose();
    organisationDivisionController.dispose();
    organisationDistrictController.dispose();
    organisationPostalCodeController.dispose();
    organisationComplainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);

    String getLocalizedText(String english, String bangla) {
      return languageProvider == AppLanguage.english ? english : bangla;
    }

    // Widget buildTextField(TextEditingController controller, String label) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         label,
    //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //       ),
    //       const SizedBox(height: 6),
    //       TextField(
    //         controller: controller,
    //         onTapOutside: (event) =>
    //             FocusManager.instance.primaryFocus?.unfocus(),
    //         decoration: InputDecoration(
    //           border: const OutlineInputBorder(borderSide: BorderSide.none),
    //           enabledBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(color: AppPalette.green),
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(color: AppPalette.green),
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }

    // Widget buildTextField(TextEditingController controller, String? label,
    //     {int? minLines, int? maxLines}) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       if (label != null)
    //         Text(
    //           label,
    //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //         ),
    //       const SizedBox(height: 6),
    //       TextField(
    //         controller: controller,
    //         onTapOutside: (event) =>
    //             FocusManager.instance.primaryFocus?.unfocus(),
    //         minLines: minLines,
    //         maxLines: maxLines,
    //         decoration: InputDecoration(
    //           border: const OutlineInputBorder(borderSide: BorderSide.none),
    //           enabledBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(color: AppPalette.green),
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(color: AppPalette.green),
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }

    Widget buildTextField(TextEditingController controller, String? label,
        {int? minLines, int? maxLines}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppPalette.green),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppPalette.green),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildRowTextFields(
        {required TextEditingController leftController,
        required TextEditingController rightController,
        required String leftLabel,
        required String rightLabel}) {
      return Row(
        children: [
          Expanded(child: buildTextField(leftController, leftLabel)),
          const SizedBox(width: 6),
          Expanded(child: buildTextField(rightController, rightLabel)),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: kToolbarHeight - 10,
          width: double.infinity,
          color: AppPalette.green.withOpacity(0.2),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(backgroundImage: AssetImage(Pngs.logo)),
                Text(
                  'DNCRP - CCMS',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Opacity(
                    opacity: 0,
                    child:
                        CircleAvatar(backgroundImage: AssetImage(Pngs.logo))),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  getLocalizedText('Complaint Details', 'অভিযোগের বিবরণ'),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // ----------
              const Divider(color: AppPalette.greenLite),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppPalette.greenLite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      getLocalizedText(
                          'Complainant Information', 'অভিযোগকারীর তথ্য'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    children: [
                      buildTextField(
                          nameController, getLocalizedText('Name', 'নাম')),
                      const SizedBox(height: 10),
                      buildTextField(fatherNameController,
                          getLocalizedText('Father\'s name', 'পিতার নাম')),
                      const SizedBox(height: 10),
                      buildTextField(motherNameController,
                          getLocalizedText('Mother\'s name', 'মায়ের নাম')),
                      const SizedBox(height: 10),
                      buildTextField(nidNumberController,
                          getLocalizedText('N.I.D', 'এন.আই.ডি')),
                      const SizedBox(height: 10),
                      buildRowTextFields(
                        leftController: divisionController,
                        rightController: districtController,
                        leftLabel: getLocalizedText('Division', 'জেলা'),
                        rightLabel: getLocalizedText('District', 'জেলা'),
                      ),
                      const SizedBox(height: 10),
                      buildRowTextFields(
                        leftController: postalCodeController,
                        rightController: professionController,
                        leftLabel:
                            getLocalizedText('Postal Code', 'পোস্টাল কোড'),
                        rightLabel: getLocalizedText('Profession', 'পেশা'),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ----------
              const Divider(color: AppPalette.greenLite),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppPalette.greenLite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      getLocalizedText('Information of Accused Organization',
                          'অভিযুক্ত প্রতিষ্ঠানের তথ্য'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    children: [
                      buildTextField(
                          organisationNameController,
                          getLocalizedText('Name of Accused Organisation',
                              'অভিযুক্ত প্রতিষ্ঠানের নাম')),
                      const SizedBox(height: 10),
                      buildTextField(
                          organisationAddressController,
                          getLocalizedText('Address of Accused Organisation',
                              'অভিযুক্ত প্রতিষ্ঠানের ঠিকানা')),
                      const SizedBox(height: 10),
                      buildRowTextFields(
                        leftController: organisationDivisionController,
                        rightController: organisationDistrictController,
                        leftLabel: getLocalizedText('Division', 'জেলা'),
                        rightLabel: getLocalizedText('District', 'বিভাগ'),
                      ),
                      const SizedBox(height: 10),
                      buildTextField(organisationPostalCodeController,
                          getLocalizedText('Postal Code', 'পোস্টাল কোড')),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppPalette.greenLite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppPalette.greenLite,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      getLocalizedText('Complain Details',
                                          'অভিযোগের বিস্তারিত'),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              buildTextField(
                                organisationComplainController,
                                null,
                                minLines: 5,
                                maxLines: 100,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppPalette.greenLite,
                                  border: Border.all(color: AppPalette.green),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getLocalizedText(
                                            'Evidence of Allegations',
                                            'অভিযোগের প্রমাণাদি'),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: AppPalette.greenLite,
                                                border: Border.all(
                                                    color: AppPalette.green),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: AppPalette.greenLite,
                                                border: Border.all(
                                                    color: AppPalette.green),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: AppPalette.greenLite,
                                                border: Border.all(
                                                    color: AppPalette.green),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
