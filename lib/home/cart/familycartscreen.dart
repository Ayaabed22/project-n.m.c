import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/home/cart/paymentMethod/view.dart';
import 'package:n_m_c/home/cart/personcartdetails/steats.dart';
import '../../core/widgets/btn.dart';
import '../../core/widgets/text.dart';
import '../../core/widgets/text_filed.dart';
import 'indivudalcartscreen.dart';
import 'personcartdetails/cubit.dart';

class FamilyCartScreen extends StatefulWidget {
  String? cardType;
  static File imagePersonCard = File('');

  FamilyCartScreen({Key? key, required String cardType}) : super(key: key);

  @override
  State<FamilyCartScreen> createState() => _FamilyCartScreenState();
}

class _FamilyCartScreenState extends State<FamilyCartScreen> {
  String? invoicesKey;
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final nationalIdController = TextEditingController();
  final jobController = TextEditingController();
  final homePhoneController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final workLocationController = TextEditingController();

  List<PersonModelData> personModelData = [];
  int currentPage = 0;
  TextEditingController number = TextEditingController();

  late AddDataModel addDataModel;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CartCubit>(context);
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
      AddPersonlCartData(
        onPressed: () {
          currentPage++;
          setState(() {

          });
        },
        addDataModel: addDataModel,

      ),
      AddConnectCartData(
        addDataModel: addDataModel,
        onPressed: () {
          currentPage++;
          setState(() {});
        },
      ),
      FamilyNumberCart(
        numberOfIndivudalsController: number,
        onPressed: () {
          for (var i = 0; i < int.parse(number.text); i++) {
            personModelData.add(PersonModelData());
          }
          currentPage++;
          setState(() {

          });
        },
      ),
      PersonsEnterScreen(
        userData: addDataModel,
        data: personModelData,
      )
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          forms[currentPage],
        ],
      ),
    );
  }
}

class AddPersonlCartData extends StatefulWidget {

  final Function() onPressed;
  AddDataModel addDataModel;

  AddPersonlCartData(
      {super.key, required this.onPressed, required this.addDataModel});

  @override
  State<AddPersonlCartData> createState() => _AddPersonlCartDataState();
}

class _AddPersonlCartDataState extends State<AddPersonlCartData> {
  File? pikedImage;

  DateTime? _selectedDate;

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
  GlobalKey<FormState> loginKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CartCubit>(context);
    return SingleChildScrollView(
      child: Form(
        key: loginKey,
        child: Column(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  // margin: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.06
                  // ,end: MediaQuery.of(context).size.width*.06),
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
                          if(value!.length<2||value.isEmpty||value!.contains(" ")==false){
                            return 'من فضلك قم بادخال الاسم بالكامل';
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
                        },
                        controller: widget.addDataModel.addressController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextWiddget(
                        isPadding: false,
                        lableText: "date of birth".tr(),
                      ),
                      SizedBox(
                        height: 6,
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
                                                      pikedImage = File(imagePath);
                                                      if (image != null && len != null) {
                                                        setState(() {
                                                          FamilyCartScreen.imagePersonCard = pikedImage!;
                                                          print(FamilyCartScreen.imagePersonCard);

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
                                                      pikedImage= File(imagePath);
                                                      if (image != null ) {
                                                        setState(() {
                                                          FamilyCartScreen.imagePersonCard=pikedImage!;

                                                        });


                                                      } else {
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select photo')));
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

                      pikedImage ==null?SizedBox():
                      Padding(child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage
                            (image:FileImage(pikedImage!),fit: BoxFit.fill ),),
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
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Btn(btnText:'next'.tr(),

                onPress: (){
              if(loginKey.currentState!.validate()) {
                widget.onPressed();
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

  AddConnectCartData(
      {super.key, required this.onPressed, required this.addDataModel});

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
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                 // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
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
                              fontWeight: FontWeight.w900,
                              color: Color(Theme.of(context).primaryColor.value)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextWiddget(lableText: "job".tr(),isPadding: false),
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
                        lableText: "home phone".tr(),
                        isPadding: false,
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
                        controller: widget.addDataModel!.homePhoneController,
                        textType: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextWiddget(
                        lableText: "companyname".tr(),
                        isPadding: false,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextFiled(
                        validator: (value){
                          if(value!.length<3||value.isEmpty){
                            return 'Enter Data';
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
                        height: 6,
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
            ),
            SizedBox(
              height: 24,
            ),
            Btn(btnText: 'apply'.tr(), onPress: (){
              if(cardKey.currentState!.validate()){
                widget.onPressed();
              }
            }
           ),
          ],
        ),
      ),
    );
  }
}

class FamilyNumberCart extends StatefulWidget {
  final Function() onPressed;
  TextEditingController numberOfIndivudalsController = TextEditingController();

  FamilyNumberCart(
      {super.key,
      required this.onPressed,
      required this.numberOfIndivudalsController});

  @override
  State<FamilyNumberCart> createState() => _FamilyNumberCartState();
}

class _FamilyNumberCartState extends State<FamilyNumberCart> {
  GlobalKey <FormState> cardKey=GlobalKey();
  bool steate = false;

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
                //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xffF9F9F9),
                ),
                // width: MediaQuery.of(context).size.width * .9,
                // height: MediaQuery.of(context).size.height * .22,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width * 0.50,
                          top: MediaQuery.of(context).size.height*.01,),
                      child: Text(
                        'Individuals data'.tr(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(Theme.of(context).primaryColor.value)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.02,),
                      child: TextWiddget(
                        isPadding: false,
                        lableText: "number of persons".tr(),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CustomTextFiled(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.numberOfIndivudalsController,
                      textType: true,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Btn(btnText: 'next'.tr(), onPress: (){
              if(cardKey.currentState!.validate()){
                widget.onPressed();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class PersonsEnterScreen extends StatefulWidget {
  List<PersonModelData> data;
  AddDataModel userData;

  PersonsEnterScreen({super.key, required this.data, required this.userData});

  @override
  State<PersonsEnterScreen> createState() => _PersonsEnterScreenState();
}

class _PersonsEnterScreenState extends State<PersonsEnterScreen> {
  GlobalKey<FormState>cardKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CartCubit>(context);
    return Form(
      key: cardKey,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
          //margin: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.11,start:MediaQuery.of(context).size.width*.11 ),
            color: Color(0xffF9F9F9),
            padding: EdgeInsetsDirectional.only(
                start:MediaQuery.of(context).size.width * 0.09,
                top: MediaQuery.of(context).size.height*.01),
            child: Text(
              'Individuals data'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(Theme.of(context).primaryColor.value),
              ),
            ),
          ),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
            color: Color(0xffF9F9F9),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return PersonScereen(
                  item: widget.data[index],
                  index: index,
                  count: widget.data.length,
                );
              },
              itemCount: widget.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Btn(
              btnText: 'apply'.tr(),
              onPress: () {
                if(cardKey.currentState!.validate()){
                  navigateTo( PaymentScreen(
                      image: FamilyCartScreen.imagePersonCard,
                      userData: widget.userData,
                      data: widget.data,
                      type: "للاسره"));
                }

              })
        ],
      ),
    );
  }
}

class PersonModelData {
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  late final String age;
  final TextEditingController? nationalIdController = TextEditingController();
  String? gender="ذكر";
  //final TextEditingController? genderController = TextEditingController();
  late File imageProfil = File('');
}

class PersonScereen extends StatefulWidget {
  late int? count;
  late int index;

  PersonScereen(
      {super.key,
      required this.item,
      required this.count,
      required this.index});

  PersonModelData item;

  @override
  State<PersonScereen> createState() => _PersonScereenState();
}

class _PersonScereenState extends State<PersonScereen> {
  File? pickedImage;
  String selectedItem = 'ذكر';
  List<bool> isContentVisible = [];

  @override
  void initState() {
    super.initState();
    isContentVisible = List.generate(widget.count!, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
          children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: MediaQuery.of(context).size.width*.09),
            child: Image.asset('assets/images/divider.png'),
          ),

          Padding(
            padding:  EdgeInsetsDirectional.only(
                start: MediaQuery.of(context).size.width*.02),
            child: Text(
              'person'.tr(),
              style: TextStyle(color: Theme.of(context).unselectedWidgetColor),
            ),
          ),

          Padding(
            padding: EdgeInsetsDirectional.only(
             start: MediaQuery.of(context).size.width*.55),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isContentVisible[widget.index] =
                    !isContentVisible[widget.index];

                  });
                },
                icon: isContentVisible[widget.index]
                    ? Icon(Icons.remove)
                    : Image.asset('assets/images/plus.png')),
          ),



        ],
      ),

      Visibility(
        child: Container(
          child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {
              if (state is SuccessCartStates) {}
            },
            builder: (BuildContext context, state) {
              if (state is LoadingCartStates) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWiddget(
                      lableText: "name".tr(),
                      isPadding: true,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    CustomTextFiled(
                      validator:(value){
                        if(value!.isEmpty||value!.length<2){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.item.nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(lableText: "age".tr(), isPadding: true),
                    SizedBox(
                      height: 6,
                    ),

                    CustomTextFiled(
                      validator:(value){
                        if(value!.isEmpty||value!.length<1){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller:widget.item.ageController ,textType: true,),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(lableText:"national id".tr(), isPadding: false),
                    SizedBox(
                      height: 6,
                    ),
                    CustomTextFiled(
                      validator:(value){
                        if(value!.isEmpty||value!.length<14){
                          return 'من فضلك قم بادخال البيانات';
                        }
                      },
                      controller: widget.item.nationalIdController,
                      textType: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWiddget(lableText: 'gender'.tr(), isPadding: true),
              Padding(
                padding:EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.09,
                    end: MediaQuery.of(context).size.width*.09,
                top:MediaQuery.of(context).size.width*.03 ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .11,
                  width: MediaQuery.of(context).size.width * .9,
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                  isExpanded: true,
                  menuMaxHeight: MediaQuery.of(context).size.height*.20,
                    dropdownColor: Colors.white,
                    decoration: const InputDecoration(
                        isDense: true, border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    )),
                  value:widget.item.gender ,
                  onChanged: (String? newValue) {
                  setState(() {
                    widget.item.gender= newValue!;

                  });
                  },
                  items: <String>['ذكر', 'انثى'].map((String value) {
                  return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  );
                  }).toList(),
                  ),
                ),
              ),

                    // CustomTextFiled(
                    //     validator:(value){
                    //       if(value!.isEmpty||value!.length<3){
                    //         return 'من فضلك قم بادخال البيانات';
                    //       }
                    //     },
                    //   controller:widget.item.genderController
                    // ),
                    SizedBox(
                      height: 3,
                    ),
                    TextWiddget(lableText: "add photo".tr(), isPadding: false),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start:MediaQuery.of(context).size.width*.10),
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
                                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.04,
                                            vertical:MediaQuery.of(context).size.height*.03 ),
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05 ),
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
                                                    widget.item.imageProfil = pickedImage!;
                                                    print(widget.item.imageProfil);
                                                    ScaffoldMessenger.of(context).showSnackBar
                                                      (SnackBar(content: Text('تم اختيار الصورة بنجاح')));

                                                  });
                                                  FamilyCartScreen.imagePersonCard = pickedImage!;
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                                  Text('من فضلك قم باختيار الصورة')));
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
                                                await image!.length();
                                                pickedImage = File(imagePath);
                                                if (image != null ) {
                                                  setState(() {
                                                    widget.item.imageProfil = pickedImage!;
                                                  ScaffoldMessenger.of(context).showSnackBar
                                                    (SnackBar(content: Text('تم اختيار الصورة بنجاح')));
                                                  });
                                                  FamilyCartScreen.imagePersonCard=pickedImage!;
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                                  Text('من فضلك قم باختيار الصورة')));
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
                      ),
                    ),
                        padding: EdgeInsetsDirectional.only(top:MediaQuery.of(context).size.width*.02,
                            start:MediaQuery.of(context).size.width*.09,
                            bottom:MediaQuery.of(context).size.width*.02 )
                    ),
                  ],
                );
              }
            },
          ),
        ),
        visible: isContentVisible[widget.index],
      ),
    ]);
  }
}
