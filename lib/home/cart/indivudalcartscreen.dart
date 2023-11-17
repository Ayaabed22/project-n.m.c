import 'dart:io';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/home/cart/paymentMethod/view.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/widgets/btn.dart';
import '../../core/widgets/text.dart';
import '../../core/widgets/text_filed.dart';
import 'familycartscreen.dart';
import 'personcartdetails/cubit.dart';

class IndividualCartScreen extends StatefulWidget {
  String? cardType;
  IndividualCartScreen({Key? key, required String cardType}) : super(key: key);

  @override
  State<IndividualCartScreen> createState() => _IndividualCartScreenState();
}

class _IndividualCartScreenState extends State<IndividualCartScreen> {
  late final String invoicesKey;
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final nationalIdController = TextEditingController();
  final jobController = TextEditingController();
  final homePhoneController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final workLocationController = TextEditingController();

  int currentPage = 0;
  late AddDataModel addDataModel;

  @override
  Widget build(BuildContext context) {
    addDataModel = AddDataModel(
        phoneNumber: CashHelper.getPhone(),
        fullName: fullNameController,
        addressController: addressController,
        dateOfBirthController: dateOfBirthController,
        nationalIdController: nationalIdController,
        jobController: jobController,
        homePhoneController: homePhoneController,
        companyNameController: companyNameController,
        emailController: emailController,
        workLocationController: workLocationController,
        image: File(''),
        cardType: widget.cardType);
    List<Widget> forms = [
      AddPersonData(
        addDataModel: addDataModel,
        onPres: () {
          currentPage = currentPage + 1;
          setState(() {});
        },
      ),
      AddConnectCartData(
        addDataModel: addDataModel,
        onPressed: () {
          setState(() {

            navigateTo( PaymentScreen(userData: addDataModel, type: "للفرد",));
          });
        },

      ),
      FamilyNumberCart(
        onPressed: () {
          currentPage = 0;
          setState(() {});
        },
      ),
      DataConnectFamily(
        onPressed: () {
          currentPage = 0;
          setState(() {});
        },
      )
    ];
    return SingleChildScrollView(
      child: Column(
        children: [forms[currentPage]],
      ),
    );
  }
}

class AddDataModel {
  final int? invouseKey;
  String? phoneNumber;
  late final String? cardType;
  TextEditingController? fullName = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? homePhoneController = TextEditingController();
  TextEditingController? dateOfBirthController = TextEditingController();
  TextEditingController? nationalIdController = TextEditingController();
  TextEditingController? jobController = TextEditingController();
  TextEditingController? companyNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? workLocationController = TextEditingController();
  late File? image = File('');

  AddDataModel(
      {this.phoneNumber,
        this.cardType,
      this.invouseKey,
      this.fullName,
      this.addressController,
      this.dateOfBirthController,
      this.nationalIdController,
      this.jobController,
      this.companyNameController,
      this.emailController,
      this.workLocationController,
      this.image,
      this.homePhoneController});
}

class AddPersonData extends StatefulWidget {
  AddDataModel addDataModel;
  final Function() onPres;

  AddPersonData(
      {super.key, required this.addDataModel, required this.onPres});

  @override
  State<AddPersonData> createState() => _AddPersonDataState();
}

class _AddPersonDataState extends State<AddPersonData> {
  DateTime? _selectedDate;
  File? pickedImage;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2001, 1, 1),
      firstDate: DateTime(2001, 1, 1),
      lastDate: DateTime(2025, 12, 30),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.addDataModel!.dateOfBirthController!.text=
            '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'.toString();


      });
    }
  }
  GlobalKey<FormState> introCardKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: introCardKey,
        child: Column(
          children: [
            Container(
            //  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: Color(0xffF9F9F9),),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width * 0.43,
                        top: MediaQuery.of(context).size.height*.01),
                    child: Text(
                      'personal data'.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(Theme.of(context).primaryColor.value)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextWiddget(
                    isPadding: false,
                    lableText: "full name".tr(),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  CustomTextFiled(
                    validator: (value){
                      if(value!.length<2||value.isEmpty||value.contains(" ")==false){
                        return 'من فضلك قم بادخال الاسم بالكامل';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: widget.addDataModel.fullName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.09),
                    child: TextWiddget(
                      isPadding: false,
                      lableText: "address".tr(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  CustomTextFiled(
                    validator: (value){
                      if(value!.length<3||value.isEmpty){
                        return 'من فضلك قم بادخال البيانات';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: widget.addDataModel.addressController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.0),
                    child: TextWiddget(
                      isPadding: false,
                      lableText: "date of birth".tr(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  CustomTextFiled(
                    ontap: () {
                      _selectDate(context);
                    },
                    // text:  _selectedDate != null
                    //     ? "${_selectedDate!.toLocal()}".split(' ')[0]
                    //     : 'Select a date',
                    controller: widget.addDataModel!.dateOfBirthController,
                    textType: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextWiddget(
                    isPadding: false,
                    lableText: "national id".tr(),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  CustomTextFiled(
                    validator: (value){
                      if(value!.length<14||value.isEmpty){
                        return 'من فضلك قم بادخال البيانات';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: widget.addDataModel.nationalIdController,
                    textType: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextWiddget(
                    isPadding: false,
                    lableText: "add photo".tr(),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*.70),
                    child: IconButton(
                        onPressed: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height *.2,
                                width: double.infinity,
                                //alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text('Select your Photo',
                                        style: TextStyle(fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).primaryColor)),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      margin: EdgeInsets.symmetric(horizontal: 30),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                              String imagePath = image!.path;
                                              int len = await image.length();
                                              pickedImage = File(imagePath);
                                              if (image != null && len != null) {
                                                setState(() {
                                                  FamilyCartScreen.imagePersonCard = pickedImage!;


                                                });
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select photo')));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/galleryicon.svg',
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                                              String imagePath = image!.path;
                                              await image.length();
                                              pickedImage = File(imagePath);
                                              if (image != null ) {
                                                setState(() {
                                                  FamilyCartScreen.imagePersonCard = pickedImage!;
                                                  print(FamilyCartScreen.imagePersonCard);
                                                  ScaffoldMessenger.of(context).showSnackBar
                                                    (SnackBar(content: Text('تم اختيار الصورة بنجاح')));

                                                });

                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar
                                                  (SnackBar(content: Text('من فضلك قم باختيار الصورة')));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/cameraicon.svg',
                                              fit: BoxFit.scaleDown,),),],),
                                    ),],),));},
                        icon: SvgPicture.asset(
                            'assets/images/addphoto.svg',
                            fit: BoxFit.scaleDown

                        ),
                        alignment: Alignment.topRight),

                  ),

                  pickedImage ==null?SizedBox():
                  Padding(child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage
                          (image:FileImage(pickedImage!),fit: BoxFit.fill ),),
                      height: MediaQuery.of(context).size.height*.1,
                      width:MediaQuery.of(context).size.width*.22 ,
                      //padding:EdgeInsetsDirectional.only(start:MediaQuery.of(context).size.width*.01 )
                      //  MediaQuery.of(context).size.,
                    ),
                  ),
                      padding: EdgeInsetsDirectional.only(top:MediaQuery.of(context).size.width*.02,
                          start:MediaQuery.of(context).size.width*.09,
                          bottom:MediaQuery.of(context).size.width*.02 )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Btn(btnText: 'next'.tr(),   onPress: (){
              if(introCardKey.currentState!.validate()) {
                widget.onPres();
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('من فضلك قم بادخال البيانات')));
              }
            }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class AddConnectCartData extends StatefulWidget {
  final Function() onPressed;
  AddDataModel? addDataModel;

  AddConnectCartData({
    super.key,
    required this.addDataModel,
    required this.onPressed,
  });

  @override
  State<AddConnectCartData> createState() => _AddConnectCartDataState();
}

class _AddConnectCartDataState extends State<AddConnectCartData> {
  GlobalKey<FormState> cardKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CartCubit>(context);
    return SingleChildScrollView(
      child: Form(
        key: cardKey,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xffF9F9F9),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width * 0.43,
                          top: MediaQuery.of(context).size.height*.01),
                      child: Text(
                        'contact data'.tr(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(Theme.of(context).primaryColor.value)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(
                      isPadding:false,
                        lableText: "job".tr()),
                    SizedBox(
                      height: 7,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.length<3||value.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.addDataModel!.jobController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(
                      isPadding: false,
                      lableText: "home phone".tr(),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.length<7||value.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.addDataModel!.homePhoneController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(
                      isPadding: false,
                      lableText: "companyname".tr(),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.length<3||value.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.addDataModel!.companyNameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(
                      isPadding: false,
                      lableText: "email".tr(),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.length<3||value.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.addDataModel!.emailController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(
                      isPadding: false,
                      lableText: "company location".tr(),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.length<3||value.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.addDataModel!.workLocationController,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Btn(btnText: 'apply'.tr(),onPress: (){
    if(cardKey.currentState!.validate()) {

      widget.onPressed();
    }
    else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Data')));
    }
    }
            )],
        ),
      ),
    );
  }
}

class FamilyNumberCart extends StatefulWidget {
  final Function() onPressed;

  FamilyNumberCart({
    super.key,
    required this.onPressed,
  });

  @override
  State<FamilyNumberCart> createState() => _FamilyNumberCartState();
}

class _FamilyNumberCartState extends State<FamilyNumberCart> {
  bool steate = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xffF9F9F9),
              ),
              width: 342,
              height: 156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 160, right: 4),
                    child: Text(
                      'بيانات الافراد',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(Theme.of(context).primaryColor.value)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextWiddget(
                    lableText: "عدد الافراد:",
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  CustomTextFiled(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Btn(btnText: 'التالي', onPress: widget.onPressed),
        ],
      ),
    );
  }
}

class DataConnectFamily extends StatefulWidget {
  final Function() onPressed;

  DataConnectFamily({
    super.key,
    required this.onPressed,
  });

  @override
  State<DataConnectFamily> createState() => _DataConnectFamilyState();
}

class _DataConnectFamilyState extends State<DataConnectFamily> {
  bool steate = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(right: 24),
                width: double.infinity,
                color: Color(0xffF9F9F9),
                child: Text(
                  'بيانات الافراد',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.start,
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                color: Color(0xffF9F9F9),
                child: Column(
                  children: List.generate(
                    8,
                    (index) => ListTile(
                      minLeadingWidth: 0,
                      title: Text(
                        "الشخص الاول",
                        style: TextStyle(
                            color: Theme.of(context).unselectedWidgetColor),
                      ),
                      trailing: Image.asset('assets/images/plus.png'),
                      leading: Image.asset('assets/images/divider.png'),
                    ),
                  ),
                )),
            SizedBox(
              height: 24,
            ),
            Btn(btnText: 'التالي', onPress: widget.onPressed),
          ],
        ),
      ),
    );
  }
}
