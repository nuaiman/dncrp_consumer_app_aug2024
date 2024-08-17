import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/utils/pick_pictures.dart';
import '../../../core/widgets/rounded_elevated_button.dart';
import '../../../core/widgets/rounded_outlined_button.dart';
import '../notifiers/area_notifier.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  File? pickedImage;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final professionController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  String? pickedGender;
  DateTime? birthDate;
  String? idType;
  final idController = TextEditingController();
  String? division;
  String? district;
  final addressController = TextEditingController();
  final postCodeController = TextEditingController();

  @override
  void initState() {
    ref.read(areaProvider.notifier).getDivisionWithDistricts();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    professionController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    idController.dispose();
    addressController.dispose();
    postCodeController.dispose();
    super.dispose();
  }

  Future<void> pickFromCamera(BuildContext context) async {
    final image = await pickCameraImage();
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = image;
    });
  }

  Future<void> pickFromGallery(BuildContext context) async {
    final image = await pickGalleryImage();
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = image;
    });
  }

  void _showPictureOptionBottomSheet(
      BuildContext context, String cameraButtonText, String galleryButtonText) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedOutlinedButton(
                label: cameraButtonText,
                onTap: () {
                  Navigator.of(context).pop();
                  pickFromCamera(context);
                },
              ),
              const SizedBox(height: 16),
              RoundedElevatedButton(
                label: galleryButtonText,
                onTap: () {
                  Navigator.of(context).pop();
                  pickFromGallery(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNationalDocumentTypeBottomSheet(BuildContext context,
      String nidText, String birthCertificateText, String passportText) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(width: 1)),
                title: Text(nidText),
                onTap: () {
                  setState(() {
                    idType = 'nid';
                  });
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(birthCertificateText),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(width: 1)),
                  onTap: () {
                    setState(() {
                      idType = 'bcn';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text(passportText),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(width: 1)),
                onTap: () {
                  setState(() {
                    idType = 'ppn';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);

    String getCreateProfileText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Create Profile';
        case AppLanguage.bangla:
          return 'প্রোফাইল তৈরি করুন';
        default:
          return 'Create Profile'; // Fallback
      }
    }

    String getFirstHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Please enter your personal details';
        case AppLanguage.bangla:
          return 'আপনার ব্যক্তিগত বিবরণ দিন';
        default:
          return 'Please enter your personal details'; // Fallback
      }
    }

    String getCameraButtonText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Camera';
        case AppLanguage.bangla:
          return 'ছবি তুলুন';
        default:
          return 'Camera'; // Fallback
      }
    }

    String getGalleryButtonText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Gallery';
        case AppLanguage.bangla:
          return 'আপলোড';
        default:
          return 'Gallery'; // Fallback
      }
    }

    String getYourNameText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Full name';
        case AppLanguage.bangla:
          return 'পুরো নাম';
        default:
          return 'Full name'; // Fallback
      }
    }

    String getEmailText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Email';
        case AppLanguage.bangla:
          return 'ইমেইল';
      }
    }

    String getProfessionText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Profession';
        case AppLanguage.bangla:
          return 'পেশা';
        default:
          return 'Profession';
      }
    }

    String getFatherNameText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Father\'s name';
        case AppLanguage.bangla:
          return 'পিতার নাম';
        default:
          return 'Father\'s name'; // Fallback
      }
    }

    String getMotherNameText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Mother\'s name';
        case AppLanguage.bangla:
          return 'মাতার নাম';
        default:
          return 'Mother\'s name'; // Fallback
      }
    }

    String getGenderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Gender';
        case AppLanguage.bangla:
          return 'লিঙ্গ';
      }
    }

    String getMaleText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Male';
        case AppLanguage.bangla:
          return 'পুরুষ';
      }
    }

    String getFemaleText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Female';
        case AppLanguage.bangla:
          return 'নারী';
      }
    }

    String getOthersText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Others';
        case AppLanguage.bangla:
          return 'অন্যান্য';
      }
    }

    String getBirthDateText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Birth date*';
        case AppLanguage.bangla:
          return 'জন্ম তারিখ*';
      }
    }

    String getSecondHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Please enter your national details';
        case AppLanguage.bangla:
          return 'আপনার জাতীয় বিবরণ দিন'; // Updated Bengali translation
        default:
          return 'Please enter your national details'; // Fallback
      }
    }

    String getAddIdentityInformationHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'National ID Type';
        case AppLanguage.bangla:
          return 'জাতীয় আইডির ধরন';
        default:
          return 'National ID Type';
      }
    }

    String getIdNumbereText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Id number';
        case AppLanguage.bangla:
          return 'আইডির নাম্বার';
      }
    }

    String getNidText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'N.I.D';
        case AppLanguage.bangla:
          return 'এন.আই.ডি';
      }
    }

    String getBirthCertificateText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Birth certificate';
        case AppLanguage.bangla:
          return 'জন্ম সনদ';
      }
    }

    String getPassportText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Passport';
        case AppLanguage.bangla:
          return 'পাসপোর্ট';
      }
    }

    String getThirdHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Please enter your address details';
        case AppLanguage.bangla:
          return 'আপনার ঠিকানার বিবরণ দিন'; // Updated Bengali translation
        default:
          return 'Please enter your address details'; // Fallback
      }
    }

    String getFullAddressText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Full address*';
        case AppLanguage.bangla:
          return 'সম্পুর্ণ ঠিকানা*';
      }
    }

    String getDhakaText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Dhaka';
        case AppLanguage.bangla:
          return 'ঢাকা';
      }
    }

    String getDivisionText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Division';
        case AppLanguage.bangla:
          return 'বিভাগ';
      }
    }

    String getDistrictText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'District';
        case AppLanguage.bangla:
          return 'জেলা';
      }
    }

    String getPostalCodeText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Postal code*';
        case AppLanguage.bangla:
          return 'পোস্টাল কোড*';
      }
    }

    String getConsentText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'I provide my personal information in compliance with all laws of the Consumer Protection Department.'; // English text for the button
        case AppLanguage.bangla:
          return 'আমি ভোক্তা অধিকার সংরক্ষণ অধিদপ্তরের সকল আইনের উপর সম্মতি প্রদান করে আমার ব্যক্তিগত তথ্য প্রদান করলাম।'; // Bengali text
        default:
          return 'I provide my personal information in compliance with all laws of the Consumer Protection Department.'; // Fallback
      }
    }

    String getNextText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Next';
        case AppLanguage.bangla:
          return 'পরবর্তী';
      }
    }

    final area = ref.watch(areaProvider);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Pngs.logo),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.95),
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: Container(
            height: kToolbarHeight - 10,
            width: double.infinity,
            color: AppPalette.green.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(Pngs.logo),
                  ),
                  Text(
                    getCreateProfileText(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: area.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              getFirstHeaderText(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: getYourNameText(),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _showPictureOptionBottomSheet(
                              context,
                              getCameraButtonText(),
                              getGalleryButtonText(),
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: pickedImage != null
                                  ? FileImage(pickedImage!)
                                  : null,
                              child: pickedImage == null
                                  ? const Icon(
                                      Icons.person_2_outlined,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: getEmailText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: professionController,
                        decoration: InputDecoration(
                          hintText: getProfessionText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: fatherNameController,
                        decoration: InputDecoration(
                          hintText: getFatherNameText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: motherNameController,
                        decoration: InputDecoration(
                          hintText: getMotherNameText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ExpansionTile(
                              dense: true,
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              collapsedShape: const OutlineInputBorder(),
                              shape: const OutlineInputBorder(),
                              title: Text(
                                pickedGender == null
                                    ? getGenderText()
                                    : pickedGender!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              children: [
                                ListTile(
                                  title: Text(getMaleText()),
                                  onTap: () {
                                    setState(() {
                                      pickedGender = 'male';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text(getFemaleText()),
                                  onTap: () {
                                    setState(() {
                                      pickedGender = 'female';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text(getOthersText()),
                                  onTap: () {
                                    setState(() {
                                      pickedGender = 'others';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: ExpansionTile(
                              dense: true,
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              collapsedShape: const OutlineInputBorder(),
                              shape: const OutlineInputBorder(),
                              title: Text(
                                birthDate == null
                                    ? getBirthDateText()
                                    : DateFormat('d MMM yyyy')
                                        .format(birthDate!),
                                style: const TextStyle(fontSize: 16),
                              ),
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ScrollDatePicker(
                                    selectedDate: birthDate ?? DateTime.now(),
                                    onDateTimeChanged: (DateTime value) {
                                      setState(() {
                                        birthDate = value;
                                      });
                                    },
                                  ),
                                  // ---------------------------------------
                                  // ScrollWheelDatePicker(
                                  //   theme: FlatDatePickerTheme(
                                  //     backgroundColor: Colors.white,
                                  //     overlay:
                                  //         ScrollWheelDatePickerOverlay.holo,
                                  //     itemTextStyle: defaultItemTextStyle
                                  //         .copyWith(color: Colors.black),
                                  //     overlayColor: Colors.black,
                                  //     overAndUnderCenterOpacity: 0.2,
                                  //   ),
                                  //   lastDate: DateTime.now(),
                                  //   onSelectedItemChanged: (value) {
                                  //     setState(() {
                                  //       birthDate = value;
                                  //     });
                                  //   },
                                  // ),
                                  // ---------------------------------------
                                  //     CupertinoDatePicker(
                                  //   mode: CupertinoDatePickerMode.date,
                                  //   initialDateTime: DateTime.now(),
                                  //   onDateTimeChanged: (DateTime newDate) {
                                  //     setState(() {
                                  //       birthDate = newDate;
                                  //     });
                                  //   },
                                  // ),
                                  // ---------------------------------------
                                  // DatePickerDialog(
                                  //     firstDate: DateTime(1990),
                                  //     lastDate: DateTime.now()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              getSecondHeaderText(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
//
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getAddIdentityInformationHeaderText()),
                                Text(idType == null ? '' : ' - '),
                                Text(
                                  idType == null
                                      ? ''
                                      : idType == 'nid'
                                          ? getNidText()
                                          : idType == 'bcn'
                                              ? getBirthCertificateText()
                                              : idType == 'ppn'
                                                  ? getPassportText()
                                                  : '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      _showNationalDocumentTypeBottomSheet(
                                    context,
                                    getNidText(),
                                    getBirthCertificateText(),
                                    getPassportText(),
                                  ),
                                  child: const Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              controller: idController,
                              decoration: InputDecoration(
                                hintText: getIdNumbereText(),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 12, horizontal: 8),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(getAddIdentityInformationHeaderText()),
                      //           ExpansionTile(
                      //             dense: true,
                      //             tilePadding:
                      //                 const EdgeInsets.symmetric(horizontal: 8),
                      //             collapsedShape: const OutlineInputBorder(),
                      //             shape: const OutlineInputBorder(),
                      //             title: Text(
                      //               pickedGender == null
                      //                   ? getGenderText()
                      //                   : pickedGender!,
                      //               style: const TextStyle(fontSize: 16),
                      //             ),
                      //             children: [
                      //               ListTile(
                      //                 title: Text(getMaleText()),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     pickedGender = 'male';
                      //                   });
                      //                 },
                      //               ),
                      //               ListTile(
                      //                 title: Text(getFemaleText()),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     pickedGender = 'female';
                      //                   });
                      //                 },
                      //               ),
                      //               ListTile(
                      //                 title: Text(getOthersText()),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     pickedGender = 'others';
                      //                   });
                      //                 },
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         border: Border.all(),
                      //         borderRadius: BorderRadius.circular(9),
                      //       ),
                      //       child: Column(
                      //         children: [
                      //           TextField(
                      //             onTapOutside: (event) {
                      //               FocusManager.instance.primaryFocus!.unfocus();
                      //             },
                      //             controller: idController,
                      //             decoration: InputDecoration(
                      //               hintText: getIdNumbereText(),
                      //               border: InputBorder.none,
                      //               contentPadding:
                      //                   const EdgeInsets.symmetric(horizontal: 8),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              getThirdHeaderText(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: getFullAddressText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ExpansionTile(
                              dense: true,
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              collapsedShape: const OutlineInputBorder(),
                              shape: const OutlineInputBorder(),
                              title: Text(
                                division == null
                                    ? getDivisionText()
                                    : division!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              children: [
                                ListTile(
                                  title: Text(getDhakaText()),
                                  onTap: () {
                                    setState(() {
                                      division = 'dhaka';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ExpansionTile(
                              dense: true,
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              collapsedShape: const OutlineInputBorder(),
                              shape: const OutlineInputBorder(),
                              title: Text(
                                district == null
                                    ? getDistrictText()
                                    : district!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              children: [
                                ListTile(
                                  title: Text(getDhakaText()),
                                  onTap: () {
                                    setState(() {
                                      district = 'dhaka';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: postCodeController,
                        decoration: InputDecoration(
                          hintText: getPostalCodeText(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              getConsentText(),
                              maxLines: 5,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RoundedElevatedButton(
                        label: getNextText(),
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
