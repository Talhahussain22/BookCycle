import 'dart:io';

import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:bookcycle/Authentication/components/custom_textfield.dart';
import 'package:bookcycle/PostAuth/SellPage/bloc/sell_page_bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/component/valueSelectioncontainer.dart';
import 'package:bookcycle/PostAuth/SellPage/locationbloc/location_bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/repository/sellpageRepo.dart';
import 'package:bookcycle/PostAuth/SellPage/repository/userlocation.dart';
import 'package:bookcycle/consts/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SellPageScreen extends StatefulWidget {
  SellPageScreen({super.key});

  @override
  State<SellPageScreen> createState() => _SellPageScreenState();
}

class _SellPageScreenState extends State<SellPageScreen> {
  int? conditionselectedindex;

  int? languageselectedindex;

  String? selectedLanguage;
  String? selectedCondition;

  late TextEditingController TitleController;
  late TextEditingController DescriptionController;
  late TextEditingController PriceController;
  late TextEditingController LocationController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? imageFile;
  List<String> type=['Fiction','Comic','Education','Religious','History','Other'];
  String? selectedItem;
  dynamic lat;
  dynamic lon;

  @override
  void initState() {
    TitleController = TextEditingController();
    DescriptionController = TextEditingController();
    PriceController = TextEditingController();
    LocationController = TextEditingController();
    super.initState();
  }

  void pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void removeImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellPageBloc,SellPageState>(
      listener: (context,Sellstate){
        if(Sellstate is SellPageErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
                content: Text(Sellstate.error),
              ),
            );
          }
        if(Sellstate is SellPageLoadedState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
                content: Text('Successfully Posted'),
              ),
            );
          }
      },
      builder: (context,Sellstate) {
        return BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.error),
                ),
              );
            }
            if (state is LocationLoadedState) {

              if (state.location != null) {
                LocationController.text = state.location!;
                lat=state.lat;
                lon=state.lon;
              }
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LocationLoadingState || Sellstate is SellPageLoadingState ,
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SingleChildScrollView(

                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Image',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:
                              imageFile == null
                                  ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black38),
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                20,
                                              ),
                                              child: SizedBox(
                                                height: 40,
                                                width: 35,
                                                child: Image.asset(
                                                  'assets/images/image.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'Upload a clear photo of only the cover page in good lighting.',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        CustomButton(
                                          buttoncolor: Colors.indigo.shade100,
                                          height: 40,
                                          onTap: () => pickImage(),
                                          borderRadius: 5,
                                          child: Center(
                                            child: Text(
                                              'Upload Image',
                                              style: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          imageFile!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        top: -12,
                                        right: -13,
                                        child: IconButton(
                                          onPressed: () => removeImage(),
                                          icon: Icon(Icons.cancel),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Condition',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              ValueselectionContainer(
                                onTap: () {
                                  setState(() {
                                    conditionselectedindex = 0;
                                    selectedCondition='New';
                                  });
                                },
                                text: 'New',
                                IsSelected: conditionselectedindex == 0,
                              ),
                              const SizedBox(width: 10),
                              ValueselectionContainer(
                                onTap: () {
                                  setState(() {
                                    selectedCondition='Used';
                                    conditionselectedindex = 1;
                                  });
                                },
                                text: 'Used',
                                IsSelected: conditionselectedindex == 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(hint: Text('Choose',style: TextStyle(color: Colors.black54),),decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black54)

                          )
                        ),value:selectedItem ,items: type.map((item)=>DropdownMenuItem(value: item,child: Text(item),)).toList(), onChanged: (String? item){
                          setState(() {
                            selectedItem=item;
                          },
                          );
                        }),
                        const SizedBox(height: 20),
                        Text(
                          'Language',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            height: 28,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ValueselectionContainer(
                                  onTap: () {
                                    setState(() {
                                      languageselectedindex = 0;
                                      selectedLanguage='English';
                                    });
                                  },
                                  text: 'English',
                                  IsSelected: languageselectedindex == 0,
                                ),
                                const SizedBox(width: 10),
                                ValueselectionContainer(
                                  onTap: () {
                                    setState(() {
                                      languageselectedindex = 1;
                                      selectedLanguage='Urdu';
                                    });
                                  },
                                  text: 'Urdu',
                                  IsSelected: languageselectedindex == 1,
                                ),
                                const SizedBox(width: 10),
                                ValueselectionContainer(
                                  onTap: () {
                                    setState(() {
                                      languageselectedindex = 2;
                                      selectedLanguage='Sindhi';
                                    });
                                  },
                                  text: 'Sindhi',
                                  IsSelected: languageselectedindex == 2,
                                ),
                                const SizedBox(width: 10),
                                ValueselectionContainer(
                                  onTap: () {
                                    setState(() {
                                      languageselectedindex = 3;
                                      selectedLanguage='Others';
                                    });
                                  },
                                  text: 'Others',
                                  IsSelected: languageselectedindex == 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            hintext: 'Enter Title',
                            controller: TitleController,
                            validator: fieldValidator,
                            color: Color(0xFFEEEEEE),
                            borderColor: Colors.blue.shade800,
                            hintextcolor: Colors.black54,
                            textColor: Colors.black,
                            borderRadius: 8,
                            verticalpadding: 5,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            hintext: 'Tell us more about your item',
                            controller: DescriptionController,
                            maxlinex: 4,
                            validator: fieldValidator,
                            color: Color(0xFFEEEEEE),
                            borderColor: Colors.blue.shade800,
                            hintextcolor: Colors.black54,
                            textColor: Colors.black,
                            borderRadius: 8,
                            verticalpadding: 5,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          'Price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            hintext: 'Enter Price (e.g 100RS)',
                            controller: PriceController,
                            validator: fieldValidator,
                            color: Color(0xFFEEEEEE),
                            borderColor: Colors.blue.shade800,
                            hintextcolor: Colors.black54,
                            textColor: Colors.black,
                            borderRadius: 8,
                            verticalpadding: 5,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          'Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            onTap: () async {
                              context.read<LocationBloc>().add(
                                LocationGetButtonPressed(),
                              );
                            },
                            hintext: 'Select Location',
                            isreadOnly: true,
                            controller: LocationController,
                            validator: fieldValidator,
                            color: Color(0xFFEEEEEE),
                            borderColor: Colors.blue.shade800,
                            hintextcolor: Colors.black54,
                            textColor: Colors.black,
                            borderRadius: 8,
                            verticalpadding: 5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton(
                            buttoncolor: Color(0xFFD65A31),
                            onTap: () async{
                              if (_formkey.currentState!.validate()) {
                                if (imageFile == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      showCloseIcon: true,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Select Book Image'),
                                    ),
                                  );
                                  return;
                                }
                                if (conditionselectedindex == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      content: Text('Select Book Condition'),
                                    ),
                                  );
                                  return;
                                }
                                if (selectedItem == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      content: Text('Select Type of Book'),
                                    ),
                                  );
                                  return;
                                }

                                if (languageselectedindex == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      closeIconColor: Colors.white,
                                      content: Text('Select Book Language'),
                                    ),
                                  );
                                  return;
                                }
                                context.read<SellPageBloc>().add(SellPagePostButtonPressed(imagefile: imageFile!, condition: selectedCondition!, category: selectedItem!, title: TitleController.text.toString(), description: DescriptionController.text.toString(), language: selectedLanguage!, location: LocationController.text.toString(), lon: lon, lat: lat, price: PriceController.text.toString()));
                              }
                            },
                            height: 45,
                            borderRadius: 5,
                            child: Center(
                              child: Text(
                                'Post Now',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}
