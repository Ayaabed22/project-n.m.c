
import 'package:flutter/material.dart';
import 'package:n_m_c/login/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/cart/indivudalcartscreen.dart';
import '../../login/view.dart';
import 'helpermethods.dart';

class CashHelper {
  static late SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static String userModelKey = 'userModel';


  // static Future saveIntroCartData(CardDataInformation data) async {
  //   await preferences.setString("phoneNumber", user.client.phoneNumber);
  //   await preferences.setString("email",user.client.email);
  //   await preferences.setString("authToken",user.client.authToken);
  //   await preferences.setString("firstName",user.client.firstName) ;
  //   await preferences.setString("LastName",user.client.LastName) ;
  //
  // }


  static Future saveLoginData(UserData user) async {
    await preferences.setString("phoneNumber", user.client.phoneNumber);
    await preferences.setString("email",user.client.email);
    await preferences.setString("authToken",user.client.authToken);
    await preferences.setString("firstName",user.client.firstName) ;
    await preferences.setString("LastName",user.client.LastName) ;

  }
   static AddDataModel? model;
  static Future setImageProfile(String phone) async {
    await preferences.setString('image',model!.image!.path);
  }

  static String getImageProfile(){
    return preferences.getString('image') ?? "";
  }

  static String getPhone() {
    return preferences.getString("phoneNumber") ?? "";
  }

  static String getEmail() {
    return preferences.getString("email") ?? "";
  }

  static String getToken() {
    return preferences.getString("authToken") ?? " ";
  }

  static String getName() {
    return preferences.getString("firstName") ?? " ";
  }

 static Future<void> setLogin( value ) async {
    await preferences.setBool('login', value);
  }

  static Future<void> setisnotFirstTime( value ) async {
    await preferences.setBool('first', value);
  }
  static Future<bool> getisnotFirstTime() async {
    return preferences.getBool('first') ?? false;
  }
  static Future<bool> getLogin() async {
    return preferences.getBool('login') ?? false;
  }
  static Future<void> setApply() async {
    await preferences.setBool('apply', true);
  }


  static Future<bool> getApply() async {
    return preferences.getBool('apply') ?? false;
  }

  static String getLastName() {
    return preferences.getString("LastName") ?? "";
  }

  static Future<bool> saveValue(int count) async {
    return await preferences.setInt("count", count);
  }

  static int getValue() {
    return preferences.getInt("count") ?? 1;
  }

  static Future<bool> saveImageProfile(String url) async {
    return await preferences.setString("image", url);
  }

  static String getImage() {
    return preferences.getString("image") ?? "";
  }


  static int getId() {
    return preferences.getInt('id') ?? 1;
  }


  static Future<void> logout(context) async {
    preferences.remove('firstName');
    preferences.remove('LastName');
    preferences.remove('phoneNumber');
    preferences.remove('authToken');
    preferences.remove('email');
    setLogin(false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false, // Remove all previous routes from the stack
    );
  }

  //navigate pushreplacement
  //signup login logout delete removeuntil
  // replacement بتشيل اسكرينه واحده من ال stack screen مش ف ال navBar اي اسكرينه تانيه
  //removeUntil بيشل كل الاسكرينات اللي ف ال stack قالبتالي بيخرج بره الابليكشن



  static Future savePaymentId(int paymentId) async {
    await preferences.setInt('paymentId', paymentId);
  }

}
