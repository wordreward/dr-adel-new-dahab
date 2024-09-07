import 'dart:convert';
import 'dart:io';
import 'package:adelnewversion/data/models/get_about_us_model.dart';
import 'package:adelnewversion/data/models/get_availabe_dates_model.dart';
import 'package:adelnewversion/data/models/get_branches_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../constant/endpoints.dart';
import '../../constant/global_var.dart';
import '../../data/models/get_transactions_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/notifications_model.dart';
import '../../helpers/dio_helper.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    getBranches();
  }
  LoginModel? loginModel;
  Future<void> login(String phone, String hash) async {
    prefs.setString('phone', phone);
    prefs.setString('hash', hash);
    emit(LoginLoading());
    print("eeeeeeeeee");
    print(await FirebaseMessaging.instance.getToken());

    DioHelper.postData(url: loginURL, data: {
      'mobile': phone,
      'hashedMobile': hash,
      'device_token': await FirebaseMessaging.instance.getToken()
    }).then((value) {
      final result = value.data;
      if (result["success"] == "success") {
        emit(LoginSuccess());
        loginModel = LoginModel.fromJson(result);
        print("eeee");
        print(loginModel!.token);
        prefs.setString('token', loginModel!.token!);
        prefs.setBool("ISLOGGED", true);
      } else if (result["status"] == "error") {
        emit(UserNotExist());
      } else {
        emit(LoginError(result["message"]));
      }
    }).catchError((e) {
      emit(LoginError('error'.tr()));
    });
  }

  List<bool> gender = [false, false];
  void selectedGender(int index) {
    for (int indexBtn = 0; indexBtn < gender.length; indexBtn++) {
      if (indexBtn == index) {
        gender[indexBtn] = true;
        emit(GenderSwitch());
      } else {
        gender[indexBtn] = false;
        emit(GenderSwitch());
      }
    }
  }

  File? image;
  var picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImageLoaded());
    } else {
      emit(ImageError());
    }
  }

  Future<void> signup(String name, String birthdate, String photo, String email,
      String gender, String code) async {
    emit(SignupLoading());
    DioHelper.postDataImage(url: registerURL, data: {
      'phone': prefs.getString('phone'),
      'hashedMobile': prefs.getString('hash'),
      'name': name,
      'birthdate': birthdate,
      'referer_code': code,
      'photo': image != null
          ? await MultipartFile.fromFile(
              image!.path,
              filename: image!.path,
              //contentType:  MediaType("image", "jpeg"), //important
            )
          : '',
      'email': email,
      'gender': gender,
      'device_token': await FirebaseMessaging.instance.getToken()
    }).then((value) {
      final result = value.data;
      if (result["status"] == "Success") {
        loginModel = LoginModel.fromJson(result);
        prefs.setString('token', loginModel!.token!);
        prefs.setBool("ISLOGGED", true);
        emit(SignupSuccess());
      } else {
        emit(SignupError(result['message']));
      }
    }).catchError((e) {
      emit(SignupError('error'.tr()));
    });
  }

  User? userModel;
  Future<void> updateProfile(String name, String photo, String gender,
      String email, String birthdate) async {
    emit(UpdateLoading());
    DioHelper.postDataImage(url: updateURL, data: {
      'name': name,
      'birthdate': birthdate,
      'email': email,
      'gender': gender,
      'photo': image != null
          ? await MultipartFile.fromFile(
              image!.path,
              filename: image!.path,
              contentType: MediaType("image", "jpg"), //important
            )
          : ''
    }).then((value) {
      final result = value.data;
      if (result["success"] == "success") {
        loginModel!.user!.photo = result["user"]["photo"];
        loginModel!.user!.name = result["user"]["name"];
        loginModel!.user!.email = result["user"]["email"];
        loginModel!.user!.gender = result["user"]["gender"];
        loginModel!.user!.birthdate = result["user"]["birthdate"];
        emit(UpdateSuccess());
      } else {
        emit(UpdateError(result['message']));
      }
    }).catchError((e) {
      emit(UpdateError('error'.tr()));
    });
  }

  void getUserData() {
    emit(UserDataLoading());
    DioHelper.postData(url: userDataURL, data: {}).then((value) {
      final result = value.data;
      if (result['success'] == "Success") {
        loginModel = LoginModel.fromJson(result);
        emit(UserDataSuccess());
      } else {
        emit(UserDataError(result['message']));
      }
    }).catchError((e) {
      emit(UserDataError('error'.tr()));
    });
  }

  void transfer(String phone, String points) {
    emit(TransferLoading());
    DioHelper.postData(
        url: transferURL,
        data: {'receiver_number': phone, 'points': points}).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        loginModel!.user = User.fromJson(result['user']);
        emit(TransferSuccess());
      } else {
        emit(TransferError(result['message']));
      }
    }).catchError((e) {
      emit(TransferError('error'.tr()));
    });
  }

  void deleteUser() {
    emit(DeleteUserLoading());
    DioHelper.postData(url: deleteURL, data: {}).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        emit(DeleteUserSuccess());
      } else {
        emit(DeleteUserError(result['message']));
      }
    }).catchError((e) {
      emit(DeleteUserError('error'.tr()));
    });
  }

  GetTransactionsModel? getTransactionsModel;
  void sendReview({String? rate}) {
    emit(TransferLoading());
    DioHelper.postData(url: sendReviewsURL, data: {
      // 'photo':photo,
      // 'details': details,
      'rate': rate
    }).then((value) {
      final result = jsonDecode(value.data);
      print(result);
      if (result["status"] == "Success") {
        emit(TransferSuccess());
      } else {
        //error(prefs.getString('phone')!, result["message"], result["message"]);
        emit(TransferError(result['message']));
      }
    }).catchError((e) {
      //error(prefs.getString('phone')!, e.toString(), e.toString());
      emit(TransferError('error'.tr()));
    });
  }

  void sendRate(BuildContext context, {double? rate}) {
    emit(TransferLoading());
    DioHelper.postData(
            url: sendRateURL,
            // data: {'user_id': loginModel!.user!.id, 'rate': rate}) //rate
            data: {'user_id': loginModel!.user!.id, 'rate': rate!.toInt()})
        .then((value) {
      Navigator.pop(context);
      print(value.statusCode);
      print(value.data);
      if (value.statusCode == 201) {
        emit(TransferSuccess());
        if (value.data["success"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value.data["message"]),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
      //final result = jsonDecode(value.data);
      //  if (value.data["success"] == true) {
      //  print(result["success"]);
      //   emit(TransferSuccess());
      // } else {
      //   //error(prefs.getString('phone')!, result["message"], result["message"]);
      //   emit(TransferError(result['message']));
      // }
    }).catchError((e) {
      print("ddddddddd");
      Navigator.pop(context);
      //error(prefs.getString('phone')!, e.toString(), e.toString());
      emit(TransferError('error'.tr()));
    });
  }

  void sendBooking({String? details, String? date, String? from,int? timeId}) {
    emit(TransferLoading());
    DioHelper.postData(url: addEvent, data: {
      'user_id': loginModel!.user!.id,
      'time_id': timeId, 
      'note': details, // "details",
      'date': date, // "2024-9-5",
      'time': DateFormat("h:mm a")
          .format(DateFormat("HH:mm").parse(from!)), //  "9:00 am",
    }).then((value) {
      // print(value.data);
      // final result = jsonDecode(value.data);
      // print(result);
      if (value.data["status"] == "Success") {


        emit(BookingSuccess());
      } else {
        //error(prefs.getString('phone')!, result["message"], result["message"]);
        emit(BookingError(value.data['message']));
      }
    }).catchError((e) {
      //error(prefs.getString('phone')!, e.toString(), e.toString());
      emit(BookingError('error'.tr()));
    });
  }

  void getAllTrans() {
    emit(GetTransLoading());
    DioHelper.postData(url: getTarnsURL, data: {}).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        getTransactionsModel = GetTransactionsModel.fromJson(result);
        loginModel!.user = User.fromJson(result['user']);
        emit(GetTransSuccess());
      } else {
        emit(GetTransError(result['message']));
      }
    }).catchError((e) {
      emit(GetTransError('error'.tr()));
    });
  }

  GetAboutModel? getAboutModel;
  void getAboutUs() {
    emit(GetTransLoading());
    DioHelper.getData(
      url: aboutUs,
    ).then((value) {
      final result = value.data;
      // if (result["success"] == "Success") {
      getAboutModel = GetAboutModel.fromJson(result.first);
      print(getAboutModel!.descriptionAr!);
      //loginModel!.user = User.fromJson(result['user']) ;
      emit(GetAboutSuccess());
      //} else {
      //  emit(GetAboutError(result['message']));
      //}
    }).catchError((e) {
      print(e.toString());
      emit(GetAboutError(e.toString()));
    });
  }

  GetBranchesModel? getBranchesModel;

  void getBranches() {
    emit(NotificationsLoading());
    DioHelper.getData(url: branches).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        getBranchesModel = GetBranchesModel.fromJson(result);
        //loginModel!.user!.notificationsCount = result['user']['notifications_count'] ;
        print(getBranchesModel!.branches![0].name);
        emit(NotificationsSuccess());
      } else {
        emit(NotificationsError(result['message']));
      }
    }).catchError((e) {
      emit(NotificationsError('error'.tr()));
    });
  }

  List<String> uniqueDates = [];
  List<Map<String, dynamic>> timesbyDate = [];
  List<GetAvailableDatesModel>? getAvailableDatesModel;
  bool isEmbty = false;

  void getAvailableDates() {
    isEmbty = false;
    uniqueDates = [];
    emit(NotificationsLoading());
    DioHelper.getData(url: availableDates).then((value) {
      final result = value.data;
      // if (result["success"] == "Success") {
      if (result.isNotEmpty) {
        getAvailableDatesModel = (result as List)
            .map((data) => GetAvailableDatesModel.fromJson(data))
            .toList();
        emit(NotificationsSuccess());
        print(getAvailableDatesModel![0].date);
        uniqueDates = extractUniqueDates(getAvailableDatesModel!);
        timesbyDate = extractTimesByDateList(getAvailableDatesModel!);
        print(uniqueDates);
        print(timesbyDate);
      } else {
        // getAvailableDatesModel = ([
        //   {"id": 119, "date": "2024-09-03", "time": "09:00:00", "available": 1},
        //   {
        //     "id": 157,
        //     "date": "2024-09-05",
        //     "time": "18:00:00",
        //     "available": 1,
        //     "created_at": "2024-09-02T20:22:19.000000Z",
        //     "updated_at": "2024-09-02T20:22:19.000000Z"
        //   }
        // ] as List)
        //     .map((data) => GetAvailableDatesModel.fromJson(data))
        //     .toList();
        // uniqueDates = extractUniqueDates(getAvailableDatesModel!);
        // timesbyDate = extractTimesByDateList(getAvailableDatesModel!);
         isEmbty = true;
        emit(NotificationsError("errrr"));
      }
    }).catchError((e) {
      emit(NotificationsError('error'.tr()));
    });
  }

  List<String> extractUniqueDates(List<GetAvailableDatesModel> bookingData) {
    // Use a Set to store unique dates because a Set does not allow duplicate values.
    Set<String> uniqueDates = {};

    // Iterate over each booking entry in the list.
    for (var entry in bookingData) {
      // Extract the 'date' from the entry and add it to the Set.
      uniqueDates.add(entry.date!);
    }

    // Convert the Set back to a List to return the unique dates.
    return uniqueDates.toList();
  }

// Function to extract unique dates with their available and unavailable times

// Function to extract unique dates with their available and unavailable times in a list format
  // Function to extract unique dates with their available and unavailable times in a list format
  List<Map<String, dynamic>> extractTimesByDateList(
      List<GetAvailableDatesModel> bookingData) {
    // Initialize a map to hold dates and their corresponding available/unavailable times
    Map<String, Map<String, List<String>>> result = {};

    for (var entry in bookingData) {
      // Initialize inner maps if not already initialized
      if (!result.containsKey(entry.date)) {
        result[entry.date!] = {'available': [], 'unavailable': []};
      }

      // Format time slot for display
      DateTime startTime = DateFormat("HH:mm:ss").parse(entry.time!);
      DateTime endTime =
          startTime.add(Duration(minutes: 45)); // Assuming 45-minute slots
      String timeRange = "from".tr() +
          " ${DateFormat('h:mm a').format(startTime)} " +
          "\n" +
          "to".tr() +
          " ${DateFormat('h:mm a').format(endTime)} ";

      // Append time range to either 'available' or 'unavailable' list
      if (entry.available == 1) {
        result[entry.date]!['available']!.add(timeRange);
      } else {
        result[entry.date]!['unavailable']!.add(timeRange);
      }
    }

    // Convert the result map to a list format
    List<Map<String, dynamic>> resultList = result.entries.map((entry) {
      return {
        "date": entry.key,
        "available": entry.value['available'],
        "unavailable": entry.value['unavailable']
      };
    }).toList();

    return resultList;
  }

  NotificationsModel? notificationsModel;

  void getNotifications() {
    emit(NotificationsLoading());
    DioHelper.postData(url: notifyURL, data: {}).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        notificationsModel = NotificationsModel.fromJson(result);
        //loginModel!.user!.notificationsCount = result['user']['notifications_count'] ;
        emit(NotificationsSuccess());
      } else {
        emit(NotificationsError(result['message']));
      }
    }).catchError((e) {
      emit(NotificationsError('error'.tr()));
    });
  }

  void reviewFB(String name) {
    emit(ReviewFBLoading());
    DioHelper.postData(
        url: reviewFacebookURL,
        data: {'facebook_displayName': name}).then((value) {
      final result = value.data;
      print(result);
      if (result["success"] == "Success") {
        emit(ReviewFBSuccess());
      } else {
        emit(ReviewFBError(result['message']));
      }
    }).catchError((e) {
      print(e.toString());
      emit(ReviewFBError('error'.tr()));
    });
  }

  void checkInFB(String name) {
    emit(CheckInFBLoading());
    DioHelper.postData(
        url: checkFacebookURL,
        data: {'facebook_displayName': name}).then((value) {
      final result = value.data;
      print(result);
      if (result["success"] == "Success") {
        emit(CheckInFBSuccess());
      } else {
        emit(CheckInFBError(result['msg']));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CheckInFBError('error'.tr()));
    });
  }

  void connectGoogle(String token, String photoURL, String name) {
    emit(ConnectGLoading());
    DioHelper.postData(
            url: sendGoogleDataURL,
            data: {'google_displayName': name, 'google_profilePhoto': photoURL})
        .then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        loginModel!.user = User.fromJson(result['user']);
        emit(ConnectGSuccess());
      } else {
        emit(ConnectGError(result['message']));
      }
    }).catchError((e) {
      emit(ConnectGError('error'.tr()));
    });
  }

  void reviewGoogle() {
    emit(ReviewGLoading());
    DioHelper.postData(url: reviewGoogleURL, data: {}).then((value) {
      final result = value.data;
      if (result["success"] == "Success") {
        emit(ReviewGSuccess());
      } else {
        emit(ReviewGError(result['message']));
      }
    }).catchError((e) {
      emit(ReviewGError('error'.tr()));
    });
  }
}
