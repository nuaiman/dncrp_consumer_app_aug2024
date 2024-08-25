import 'dart:io';

import 'package:dncrp_consumer_app/core/widgets/rounded_elevated_button.dart';
import 'package:dncrp_consumer_app/features/auth/notifiers/complain_type_notifier.dart';
import 'package:dncrp_consumer_app/features/dashboard/notifiers/complain_notifier.dart';
import 'package:dncrp_consumer_app/features/dashboard/notifiers/user_notifier.dart';
import 'package:dncrp_consumer_app/models/complain_type.dart';
import 'package:dncrp_consumer_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/utils/picker_utils.dart';
import '../../../models/area.dart';
import '../../auth/notifiers/area_notifier.dart';

class CreateComplainScreen extends ConsumerStatefulWidget {
  final Person person;

  const CreateComplainScreen({super.key, required this.person});

  @override
  ConsumerState<CreateComplainScreen> createState() =>
      _AddComplainScreenState();
}

class _AddComplainScreenState extends ConsumerState<CreateComplainScreen> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController fatherNameController;
  late final TextEditingController motherNameController;
  late final TextEditingController nidNumberController;
  Division? selectedDivision;
  District? selectedDistrict;
  late final TextEditingController addressController;
  late final TextEditingController postalCodeController;
  late final TextEditingController professionController;
  //
  ComplainType? selectedComplainType;
  final organisationNameController = TextEditingController();
  final organisationAddressController = TextEditingController();
  Division? selectedOrganisationDivision;
  District? selectedOrganisationDistrict;
  final organisationPostalCodeController = TextEditingController();
  final organisationComplainController = TextEditingController();
  //
  File? evidenceFile1;
  File? evidenceFile2;
  File? evidenceFile3;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.person.complainer.name);
    phoneController =
        TextEditingController(text: widget.person.complainer.username);
    fatherNameController =
        TextEditingController(text: widget.person.complainer.fatherName);
    motherNameController =
        TextEditingController(text: widget.person.complainer.motherName);
    nidNumberController =
        TextEditingController(text: widget.person.complainer.identificationNo);
    addressController =
        TextEditingController(text: widget.person.complainer.address);
    postalCodeController = TextEditingController(
        text: widget.person.complainer.postalCode.toString());
    professionController =
        TextEditingController(text: widget.person.complainer.profession);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    nidNumberController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    professionController.dispose();
    organisationNameController.dispose();
    organisationAddressController.dispose();
    organisationPostalCodeController.dispose();
    organisationComplainController.dispose();
    super.dispose();
  }

  Future<void> pickEvidence(int number) async {
    final pickedFile = await pickGalleryImage();

    setState(() {
      switch (number) {
        case 1:
          evidenceFile1 = pickedFile;
          break;
        case 2:
          evidenceFile2 = pickedFile;
          break;
        case 3:
          evidenceFile3 = pickedFile;
          break;
      }
    });
  }

  void removeEvidence(int number) {
    setState(() {
      switch (number) {
        case 1:
          evidenceFile1 = null;
          break;
        case 2:
          evidenceFile2 = null;
          break;
        case 3:
          evidenceFile3 = null;
          break;
      }
    });
  }

  void _showDivisionBottomSheet(BuildContext context,
      List<DivisionWithDistricts> area, AppLanguage languageProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: area.map((divisionWithDistricts) {
                return Card(
                  child: ListTile(
                    title: Text(
                      languageProvider == AppLanguage.english
                          ? divisionWithDistricts.division.name
                          : divisionWithDistricts.division.bnName,
                    ),
                    onTap: () {
                      setState(() {
                        selectedDivision = divisionWithDistricts.division;
                        selectedDistrict = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showDistrictBottomSheet(BuildContext context, List<District> districts,
      AppLanguage languageProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: districts.map((district) {
                return Card(
                  child: ListTile(
                    title: Text(
                      languageProvider == AppLanguage.english
                          ? district.name
                          : district.bnName,
                    ),
                    onTap: () {
                      setState(() {
                        selectedDistrict = district;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------

  void _showOrganisationDivisionBottomSheet(BuildContext context,
      List<DivisionWithDistricts> area, AppLanguage languageProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: area.map((divisionWithDistricts) {
                return Card(
                  child: ListTile(
                    title: Text(
                      languageProvider == AppLanguage.english
                          ? divisionWithDistricts.division.name
                          : divisionWithDistricts.division.bnName,
                    ),
                    onTap: () {
                      setState(() {
                        selectedOrganisationDivision =
                            divisionWithDistricts.division;
                        selectedOrganisationDistrict = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showOrganisationDistrictBottomSheet(BuildContext context,
      List<District> districts, AppLanguage languageProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: districts.map((district) {
                return Card(
                  child: ListTile(
                    title: Text(
                      languageProvider == AppLanguage.english
                          ? district.name
                          : district.bnName,
                    ),
                    onTap: () {
                      setState(() {
                        selectedOrganisationDistrict = district;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

// -----------------------------------------------------------------------------

  void _showComplainTypeBottomSheet(BuildContext context,
      List<ComplainType> complainTypes, AppLanguage languageProvider) {
    print('1111111111111111111111111111111111111111111');
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: complainTypes.map((complainType) {
                return Card(
                  child: ListTile(
                    title: Text(
                      languageProvider == AppLanguage.english
                          ? complainType.name
                          : complainType.bnName,
                    ),
                    onTap: () {
                      // Handle the selection
                      setState(() {
                        selectedComplainType = complainType;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void createComplain(
    BuildContext context,
    AppLanguage language, {
    required String name,
    required String phone,
    required String nid,
    required String address,
    required Division division,
    required District district,
    required ComplainType complainType,
    required String orgName,
    required String orgAddress,
    required Division orgDivision,
    required District orgDistrict,
    required String complainDescription,
    required List<File> evidences,
  }) {
    final String userId = ref.read(userProvider)!.userId.toString();
    final String complainerId = ref.read(userProvider)!.complainer.id;

    ref.read(complainProvider.notifier).createComplain(
          context,
          language,
          userId: userId,
          complainerId: complainerId,
          name: name,
          phone: phone,
          nid: nid,
          address: address,
          division: division,
          district: district,
          complainType: complainType,
          orgName: orgName,
          orgAddress: orgAddress,
          orgDivision: orgDivision,
          orgDistrict: orgDistrict,
          complainDescription: complainDescription,
          evidences: evidences,
        );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);

    String getLocalizedText(String english, String bangla) {
      return languageProvider == AppLanguage.english ? english : bangla;
    }

    final area = ref.watch(areaProvider);
    List<District> districts = selectedDivision == null
        ? []
        : area
            .firstWhere((d) => d.division.name == selectedDivision!.name)
            .districts;

    final complainTypes = ref.watch(complainTypeProvider);

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

    Widget buildEvidenceContainer(File? file, int number) {
      return Expanded(
        child: file != null
            ? GestureDetector(
                onTap: () => removeEvidence(number),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppPalette.greenLite,
                    border: Border.all(color: AppPalette.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(file, fit: BoxFit.cover),
                      Center(
                        child: CircleAvatar(
                          child: Positioned(
                            right: 8,
                            top: 8,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => removeEvidence(number),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => pickEvidence(number),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppPalette.greenLite,
                    border: Border.all(color: AppPalette.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: AppPalette.green, size: 40),
                  ),
                ),
              ),
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
                      buildTextField(
                          phoneController, getLocalizedText('Phone', 'ফোন')),
                      const SizedBox(height: 10),
                      buildTextField(nidNumberController,
                          getLocalizedText('N.I.D', 'এন.আই.ডি')),
                      const SizedBox(height: 10),
                      buildTextField(addressController,
                          getLocalizedText('Address', 'ঠিকানা')),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             getLocalizedText('Division', 'বিভাগ'),
                      //             style: const TextStyle(
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           ExpansionTile(
                      //             dense: true,
                      //             tilePadding:
                      //                 const EdgeInsets.symmetric(horizontal: 8),
                      //             collapsedShape: const OutlineInputBorder(),
                      //             shape: const OutlineInputBorder(),
                      //             title: Text(
                      //               selectedDivision != null
                      //                   ? languageProvider ==
                      //                           AppLanguage.english
                      //                       ? selectedDivision!.name
                      //                       : selectedDivision!.bnName
                      //                   : languageProvider ==
                      //                           AppLanguage.english
                      //                       ? 'Division'
                      //                       : 'বিভাগ',
                      //               style: const TextStyle(fontSize: 16),
                      //             ),
                      //             children: area.map((divisionWithDistricts) {
                      //               return ListTile(
                      //                 title: Text(
                      //                   languageProvider == AppLanguage.english
                      //                       ? divisionWithDistricts
                      //                           .division.name
                      //                       : divisionWithDistricts
                      //                           .division.bnName,
                      //                 ),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     selectedDivision =
                      //                         divisionWithDistricts.division;
                      //                     selectedDistrict = null;
                      //                   });
                      //                 },
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             getLocalizedText('District', 'জেলা'),
                      //             style: const TextStyle(
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           ExpansionTile(
                      //             dense: true,
                      //             tilePadding:
                      //                 const EdgeInsets.symmetric(horizontal: 8),
                      //             collapsedShape: const OutlineInputBorder(),
                      //             shape: const OutlineInputBorder(),
                      //             title: Text(
                      //               selectedDistrict != null
                      //                   ? languageProvider ==
                      //                           AppLanguage.english
                      //                       ? selectedDistrict!.name
                      //                       : selectedDistrict!.bnName
                      //                   : languageProvider ==
                      //                           AppLanguage.english
                      //                       ? 'District'
                      //                       : 'জেলা',
                      //               style: const TextStyle(fontSize: 16),
                      //             ),
                      //             enabled: selectedDivision != null,
                      //             children: districts.map((district) {
                      //               return ListTile(
                      //                 title: Text(languageProvider ==
                      //                         AppLanguage.english
                      //                     ? district.name
                      //                     : district.bnName),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     selectedDistrict = district;
                      //                   });
                      //                 },
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getLocalizedText('Division', 'বিভাগ'),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showDivisionBottomSheet(
                                        context, area, languageProvider);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppPalette.green),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      selectedDivision != null
                                          ? languageProvider ==
                                                  AppLanguage.english
                                              ? selectedDivision!.name
                                              : selectedDivision!.bnName
                                          : languageProvider ==
                                                  AppLanguage.english
                                              ? 'Division'
                                              : 'বিভাগ',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getLocalizedText('District', 'জেলা'),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: selectedDivision != null
                                      ? () {
                                          _showDistrictBottomSheet(context,
                                              districts, languageProvider);
                                        }
                                      : null,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppPalette.green),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      selectedDistrict != null
                                          ? languageProvider ==
                                                  AppLanguage.english
                                              ? selectedDistrict!.name
                                              : selectedDistrict!.bnName
                                          : languageProvider ==
                                                  AppLanguage.english
                                              ? 'District'
                                              : 'জেলা',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      // buildRowTextFields(
                      //   leftController: postalCodeController,
                      //   rightController: professionController,
                      //   leftLabel:
                      //       getLocalizedText('Postal Code', 'পোস্টাল কোড'),
                      //   rightLabel: getLocalizedText('Profession', 'পেশা'),
                      // ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getLocalizedText('Complain Type', 'অভিযোগের ধরন'),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showComplainTypeBottomSheet(
                                  context, complainTypes, languageProvider);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppPalette.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                selectedComplainType != null
                                    ? languageProvider == AppLanguage.english
                                        ? selectedComplainType!.name
                                        : selectedComplainType!.bnName
                                    : languageProvider == AppLanguage.english
                                        ? 'Complain Type'
                                        : 'অভিযোগের ধরন',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      buildTextField(
                        organisationNameController,
                        getLocalizedText('Name of Accused Organisation',
                            'অভিযুক্ত প্রতিষ্ঠানের নাম'),
                      ),
                      const SizedBox(height: 10),
                      buildTextField(
                        organisationAddressController,
                        getLocalizedText('Address of Accused Organisation',
                            'অভিযুক্ত প্রতিষ্ঠানের ঠিকানা'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getLocalizedText('Division', 'বিভাগ'),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showOrganisationDivisionBottomSheet(
                                        context, area, languageProvider);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppPalette.green),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      selectedOrganisationDivision != null
                                          ? languageProvider ==
                                                  AppLanguage.english
                                              ? selectedOrganisationDivision!
                                                  .name
                                              : selectedOrganisationDivision!
                                                  .bnName
                                          : languageProvider ==
                                                  AppLanguage.english
                                              ? 'Division'
                                              : 'বিভাগ',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getLocalizedText('District', 'জেলা'),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: selectedDivision != null
                                      ? () {
                                          _showOrganisationDistrictBottomSheet(
                                              context,
                                              districts,
                                              languageProvider);
                                        }
                                      : null,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppPalette.green),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      selectedOrganisationDistrict != null
                                          ? languageProvider ==
                                                  AppLanguage.english
                                              ? selectedOrganisationDistrict!
                                                  .name
                                              : selectedOrganisationDistrict!
                                                  .bnName
                                          : languageProvider ==
                                                  AppLanguage.english
                                              ? 'District'
                                              : 'জেলা',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      // buildTextField(
                      //   organisationPostalCodeController,
                      //   getLocalizedText('Postal Code', 'পোস্টাল কোড'),
                      // ),
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
                              const SizedBox(height: 8),
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
                                          buildEvidenceContainer(
                                              evidenceFile1, 1),
                                          const SizedBox(width: 4),
                                          buildEvidenceContainer(
                                              evidenceFile2, 2),
                                          const SizedBox(width: 4),
                                          buildEvidenceContainer(
                                              evidenceFile3, 3),
                                          const SizedBox(width: 8),
                                        ],
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
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RoundedElevatedButton(
                padding: 0,
                label: getLocalizedText('Submit', 'সাবমিট করুন'),
                onTap: () {
                  createComplain(
                    context,
                    languageProvider,
                    name: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                    nid: nidNumberController.text.trim(),
                    address: addressController.text.trim(),
                    division: selectedDivision!,
                    district: selectedDistrict!,
                    complainType: selectedComplainType!,
                    orgName: organisationNameController.text.trim(),
                    orgAddress: organisationAddressController.text.trim(),
                    orgDivision: selectedOrganisationDivision!,
                    orgDistrict: selectedOrganisationDistrict!,
                    complainDescription:
                        organisationComplainController.text.trim(),
                    evidences: [],
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
