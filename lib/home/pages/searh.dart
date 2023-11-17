import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';
import 'package:n_m_c/search/medicalscreen.dart';
import '../../core/logic/helpermethods.dart';
import '../../core/widgets/bottom_navigationbar.dart';
import '../../core/widgets/btn.dart';
import '../../search/citymodel.dart';
import '../medicalnetworkreqest/cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> category = [
    "معامل تحاليل",
    "صيدليات",
    "عيادات",
    "مراكز أشعه",
    "مستشفيات",
    "مراكز تخصصية",
    "بصريات",
    "مراكز طبيه",
    "حضانات تعليمية",
    "بيوتي سنتر",
    'جيم- صالات رياضية',
    "عيادات بيطرية",
    "عيادة"
  ];
  String? selectedItem = 'معامل تحاليل';

  CityModel? selectedCity = CityModel(id: '14', name: 'السويس');
  List<CityModel> cities = [
    CityModel(id: "1", name: "القاهرة"),
    CityModel(id: "2", name: "الجيزة"),
    CityModel(id: "3", name: "الأسكندرية"),
    CityModel(id: "4", name: "الدقهلية"),
    CityModel(id: "5", name: "البحر الأحمر"),
    CityModel(id: '6', name: 'البحيرة'),
    CityModel(id: '7', name: 'الفيوم'),
    CityModel(id: '8', name: 'لغربية'),
    CityModel(id: '9', name: 'الإسماعلية'),
    CityModel(id: '10', name: 'المنوفية'),
    CityModel(id: '11', name: 'المنيا'),
    CityModel(id: '12', name: 'القليوبية'),
    CityModel(id: '13', name: 'الوادي الجديد'),
    CityModel(id: '14', name: 'السويس'),
    CityModel(id: '15', name: 'اسوان'),
    CityModel(id: '16', name: 'اسيوط'),
    CityModel(id: '17', name: 'بني سويف'),
    CityModel(id: '18', name: 'بورسعيد'),
    CityModel(id: '19', name: 'دمياط'),
    CityModel(id: '20', name: 'الشرقية'),
    CityModel(id: '21', name: 'جنوب سيناء'),
    CityModel(id: '22', name: 'كفر الشيخ'),
    CityModel(id: '23', name: 'مطروح'),
    CityModel(id: '24', name: 'الأقصر'),
    CityModel(id: '25', name: 'قنا'),
    CityModel(id: '26', name: 'شمال سيناء'),
    CityModel(id: '27', name: 'سوهاج'),
  ];

  List<Map<String, dynamic>> filterData = [
    {
      "id": "249",
      "governorate_id": "14",
      "city_name_ar": "السويس",
      "city_name_en": "Suez"
    }
  ];
  final List<Map<String, dynamic>> _items = [];

  Map<String, dynamic>? _selectedItem = {
    "id": "249",
    "governorate_id": "14",
    "city_name_ar": "السويس",
    "city_name_en": "Suez"
  };
  List dataStore = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/json/data.json');
    final jsonData = json.decode(jsonString);
    setState(() {
      for (var element in jsonData["data"]) {
        _items.add(element);
        filterData = _items;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
            create: (context) =>
            MedicalNetworkCubit()
              ..getAllMedicalNetwork(),
            child: Builder(builder: (context) {
              MedicalNetworkCubit cubit = BlocProvider.of(context);
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery
                              .of(context)
                              .size
                              .width * .05,
                          vertical: MediaQuery
                              .of(context)
                              .size
                              .width * .04),
                      child: Row(
                        children: [
                          Text(
                            'search'.tr(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff20384B)),
                          ),
                          const SizedBox(
                            width: 240,
                          ),
                          GestureDetector(
                              onTap: () {
                                navigateTo(
                                  const CustomNavBar(),
                                );
                              },
                              child: SvgPicture.asset(
                                  'assets/images/colseicon.svg')),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .9,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .66),
                            child: Text(
                              'governrate'.tr(),
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color:
                                  Theme
                                      .of(context)
                                      .unselectedWidgetColor)),
                            ),
                          ),

                          SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .001),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .09,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .9,
                              child: DropdownButtonFormField<CityModel?>(
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .canvasColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                    isDense: true,
                                    border: const OutlineInputBorder()),
                                isDense: true,
                                dropdownColor: Colors.white,
                                value: cities[14],
                                onChanged: (CityModel? newValue) {
                                  setState(() {
                                    selectedCity = newValue;
                                    filterData = _items.where((element) {
                                      return element['governorate_id'] ==
                                          selectedCity!.id;
                                    }).toList();
                                  });
                                },
                                style: const TextStyle(
                                  // Customize label text style here
                                  color: Colors.black,
                                  // Example: set text color to blue
                                  fontSize: 19.0,
                                  // Example: set font size to 16
                                  fontWeight: FontWeight
                                      .w500, // Example: set font weight to bold
                                ),
                                items: cities.map<DropdownMenuItem<CityModel>>(
                                        (CityModel city) {
                                      return DropdownMenuItem<CityModel>(
                                        value: city,
                                        child: Text(city.name ?? ""),
                                      );
                                    }).toList(),
                              )),
                          SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .001),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .66),
                            child: Text(
                              'category'.tr(),
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color:
                                  Theme
                                      .of(context)
                                      .unselectedWidgetColor)),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .09,
                              width: MediaQuery.of(context).size.width * .9,
                              child: DropdownButtonFormField<String>(
                                menuMaxHeight: MediaQuery.of(context).size.height*.6,
                                decoration: const InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder()),
                                isDense: true,
                                dropdownColor: Colors.white,
                                value: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                style: const TextStyle(
                                  // Customize label text style here
                                  color: Colors.black,
                                  // Example: set text color to blue
                                  fontSize: 19.0,
                                  // Example: set font size to 16
                                  fontWeight: FontWeight
                                      .w500, // Example: set font weight to bold
                                ),
                                items: category.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              )),
                          SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .001),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .70),
                            child: Text(
                              'region'.tr(),
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color:
                                  Theme
                                      .of(context)
                                      .unselectedWidgetColor)),
                            ),
                          ),
                          SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .001),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .11,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .9,
                            child:
                            DropdownButtonFormField<Map<String, dynamic>>(
                              isDense: true,
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                  isDense: true, border: OutlineInputBorder()),
                              // hint: Text('Select an option'),
                              value: filterData.last,
                              items: filterData.map((item) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: item,
                                  child: Text(item['city_name_ar']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem = value;
                                });
                              },
                              style: const TextStyle(
                                // Customize label text style here
                                color: Colors.black,
                                // Example: set text color to blue
                                fontSize: 19.0,
                                // Example: set font size to 16
                                fontWeight: FontWeight
                                    .w500, // Example: set font weight to bold
                              ),
                            ),
                          ),
                          // Text('Selected option: ${_selectedItem != null ? _selectedItem!['city_name_ar'] : "None"}'),

                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .02,
                          ),
                          BlocConsumer<MedicalNetworkCubit,
                              MedicalNetworkStates>(listener: (context, state) {
                            if (state is SuccessMedicalNetworkStates) {}
                          }, builder: (context, state) {
                            if (state is LoadingMedicalNetworkStates) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Btn(
                                btnText: 'search'.tr(),
                                onPress: () {
                                  // for (var element in cubit.medicalNetworkModel!.data) {
                                  //   if (selectedItem != null) {
                                  //     selectedItem == element.category;
                                  //   } else if (_selectedItem != null) {
                                  //     _selectedItem!['city_name_ar'] == element.region;
                                  //   } else if (selectedCity!.name != null) {
                                  //     selectedCity!.name == element.governorate;
                                  //   }
                                  // }
                                  // dataStore.add(selectedItem);
                                  // dataStore.add(selectedCity!.name);
                                  // dataStore.add(_selectedItem!['city_name_ar']);
                                  // if(selectedCity?.name==null){
                                  //   selectedCity?.name='القاهرة';
                                  //   dataStore.add('القاهرة');
                                  // }else{
                                  //   dataStore.add( selectedCity?.name );
                                  // }
                                  // if(_selectedItem?['city_name_ar']==null){
                                  //   _selectedItem?['city_name_ar']='15 مايو';
                                  //   dataStore.add('15 مايو');
                                  // }else{
                                  //   dataStore.add( _selectedItem?['city_name_ar']);
                                  // }

                                  dataStore = [
                                    selectedItem,
                                    selectedCity!.name,
                                    _selectedItem!['city_name_ar']
                                  ];
                                  cubit.storage.clear();
                                  cubit.medicalNetworkModel!.data
                                      !.where((element) {
                                    if (element.governorate == dataStore[1] &&
                                        element.region == dataStore[2] &&
                                        element.category == dataStore[0]) {
                                      cubit.storage.add({
                                        "image": element.image,
                                        'category': element.category,
                                        'region': element.region,
                                        'governorate': element.governorate,
                                        'hotLine': element.hotLine,
                                        'appointments': element.appointments,
                                        'discountPercentage':
                                        element.discountPercentage,
                                        'address': element.address,
                                        'id': element.id
                                      });
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }).toList();

                                  navigateTo(
                                    MedicalScreen(
                                      store: cubit.storage,
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                        ]))
                  ]),
                ),
              );
            })));
  }
}
