// import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
// import 'package:adelnewversion/constant/global_var.dart';
// import 'package:adelnewversion/core/theme/fonts.dart';
// import 'package:adelnewversion/screens/booking_available.dart';
// import 'package:adelnewversion/screens/widgets/app_bar.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:overlay_loading_progress/overlay_loading_progress.dart';
// import '../../core/core.dart';

// class Booking extends StatefulWidget {
//   const Booking({super.key});

//   @override
//   State<Booking> createState() => _BookingState();
// }

// class _BookingState extends State<Booking> {
//   TextEditingController complaint = TextEditingController();
//   String pickedDate = "Select".tr();
//   String timeFrom = "from".tr();
//   String timeTo = "to".tr();
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   _pickDate() async {
//     DateTime date = await showDatePicker(
//       context: context,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//       initialDate: DateTime.now(),
//     ) as DateTime;

//     setState(() {
//       pickedDate = "${date.year}-${date.month}-${date.day}";
//     });
//   }

//   _pickTime() async {
//     TimeOfDay t =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now())
//             as TimeOfDay;

//     String h = t.hour
//         .toString(); //>12?"${t.hour-12}":t.hour==0?"${12}":t.hour.toString();
//     h = h.length < 2 ? "0$h" : h;
//     String m =
//         t.minute.toString().length < 2 ? "0${t.minute}" : t.minute.toString();
//     setState(() {
//       timeFrom = "$h:$m";
//     });
//   }

//   _pickTimeTo() async {
//     TimeOfDay t =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now())
//             as TimeOfDay;

//     String h = t.hour
//         .toString(); //>12?"${t.hour-12}":t.hour==0?"${12}":t.hour.toString();
//     h = h.length < 2 ? "0$h" : h;
//     String m =
//         t.minute.toString().length < 2 ? "0${t.minute}" : t.minute.toString();
//     setState(() {
//       timeTo = "$h:$m";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
//       if (state is TransferLoading) {
//         OverlayLoadingProgress.start(
//           context,
//           widget: Container(
//             width: MediaQuery.of(context).size.width / 4,
//             padding: EdgeInsets.all(MediaQuery.of(context).size.width / 13),
//             child: const AspectRatio(
//               aspectRatio: 1,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         );
//       }
//       if (state is TransferSuccess) {
//         OverlayLoadingProgress.stop();
//         prefs.setString('IdPhone', '');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('complaint sent successfully'),
//             backgroundColor: primaryComponentColor,
//             duration: Duration(seconds: 5),
//           ),
//         );
//       }
//       if (state is TransferError) {
//         OverlayLoadingProgress.stop();
//         prefs.setString('IdPhone', '');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(state.message),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 5),
//           ),
//         );
//       }
//     }, builder: (context, state) {
//       var model = BlocProvider.of<AppCubit>(context).loginModel;

//       return Scaffold(
//         body: InkWell(
//             onTap: () {
//               FocusManager.instance.primaryFocus?.unfocus();
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 15, right: 15, top: kToolbarHeight),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Image.asset(
//                             'assets/images/logo.png',
//                             width: 130,
//                             height: 80,
//                           ),
//                         ],
//                       ),
//                       Appbar(
//                         title: 'Booking'.tr(),
//                         showBackButton: true,
//                         topPadding: false,
//                         fontSize: 25,
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text("Date".tr(),
//                                     style: Fonts()
//                                         .primaryFont(25, FontWeight.w500)),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   _pickDate();
//                                 },
//                                 child: SizedBox(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.055,
//                                   width: (MediaQuery.of(context).size.width *
//                                       0.35),
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15.0),
//                                     ),
//                                     elevation: 10,
//                                     color: pickedDate != 'Select'.tr()
//                                         ? primaryComponentColor
//                                         : secondComponentColor,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           const SizedBox(
//                                             width: 3,
//                                           ),
//                                           Text(pickedDate,
//                                               style: Fonts().whiteFont(
//                                                   20, FontWeight.w500)),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text("Time".tr(),
//                                     style: Fonts()
//                                         .primaryFont(25, FontWeight.w500)),
//                               ),
//                               Row(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           _pickTime();
//                                         },
//                                         child: SizedBox(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.05,
//                                           width: (MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.25),
//                                           child: Card(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(15.0),
//                                             ),
//                                             elevation: 10,
//                                             color: timeFrom != 'from'.tr()
//                                                 ? primaryComponentColor
//                                                 : secondComponentColor,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   const SizedBox(
//                                                     width: 3,
//                                                   ),
//                                                   Text(timeFrom,
//                                                       style: Fonts().whiteFont(
//                                                           20, FontWeight.w500)),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           _pickTimeTo();
//                                         },
//                                         child: SizedBox(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.05,
//                                           width: (MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.25),
//                                           child: Card(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(15.0),
//                                             ),
//                                             elevation: 10,
//                                             color: timeTo != 'to'.tr()
//                                                 ? primaryComponentColor
//                                                 : secondComponentColor,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   const SizedBox(
//                                                     width: 3,
//                                                   ),
//                                                   Text(timeTo,
//                                                       style: Fonts().whiteFont(
//                                                           20, FontWeight.w500)),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Stack(
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.16,
//                             width: (MediaQuery.of(context).size.width),
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               elevation: 0,
//                               color: secondComponentColor,
//                             ),
//                           ),
//                           Positioned(
//                             right: 20,
//                             top: 12,
//                             left: 20,
//                             bottom: 12,
//                             child: SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.13,
//                               width: MediaQuery.of(context).size.width * 0.78,
//                               child: TextFormField(
//                                 controller: complaint,
//                                 keyboardType: TextInputType.multiline,
//                                 maxLines: 4,
//                                 cursorColor: primaryBackgroundColor,
//                                 cursorErrorColor: primaryBackgroundColor,
//                                 validator: (v) {
//                                   if (v == '') {
//                                     return 'enter your Booking note';
//                                   }
//                                   return null;
//                                 },
//                                 style: Fonts().whiteFont(15, FontWeight.w500),
//                                 decoration: InputDecoration(
//                                   hintText: "write your note here".tr(),
//                                   hintStyle:
//                                       Fonts().whiteFont(15, FontWeight.w300),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         width: 1, color: primaryComponentColor),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   disabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         width: 1, color: primaryComponentColor),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         width: 1, color: primaryComponentColor),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               if (!_formKey.currentState!.validate()) {
//                                 return;
//                               } else if (pickedDate == "select" ||
//                                   timeFrom == "select" ||
//                                   timeTo == "select") {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('date and time are required'),
//                                     backgroundColor: primaryComponentColor,
//                                     duration: Duration(seconds: 5),
//                                   ),
//                                 );
//                               } else {
//                                 _formKey.currentState!.save();
//                                 BlocProvider.of<AppCubit>(context).sendBooking(
//                                     details: complaint.value.text,
//                                     date: pickedDate,
//                                     from: timeFrom,
//                                     to: timeTo);
//                               }
//                             },
//                             child: Container(
//                               width: 150,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: primaryComponentColor,
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     'Submit'.tr(),
//                                     style:
//                                         Fonts().secondFont(25, FontWeight.bold),
//                                   ),
//                                   const Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: secondTextColor,
//                                     size: 25,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BookingAvailable(),
//                               ));
//                         },
//                         child: Container(
//                           // width: 150,
//                           // height: 50,
//                           decoration: BoxDecoration(
//                             color: primaryComponentColor,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'available_times'.tr(),
//                                   style:
//                                       Fonts().secondFont(25, FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       );
//     });
//   }
// }
import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/global_var.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/booking_available.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import '../../core/core.dart';

class Booking extends StatefulWidget {
  final String date;
  final String fromTime;
  final String toTime;
  final int id;

  const Booking({
    super.key,
    required this.date,
    required this.fromTime,
    required this.toTime,
    required this.id,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  TextEditingController complaint = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
      if (state is BookingLoading) {
        OverlayLoadingProgress.start(
          context,
          widget: Container(
            width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 13),
            child: const AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
      if (state is BookingSuccess) {
        OverlayLoadingProgress.stop();
        prefs.setString('IdPhone', '');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('complaint sent successfully'),
            backgroundColor: primaryComponentColor,
            duration: Duration(seconds: 5),
          ),
        );
      }
      if (state is BookingError) {
        OverlayLoadingProgress.stop();
        prefs.setString('IdPhone', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }, builder: (context, state) {
      var model = BlocProvider.of<AppCubit>(context).loginModel;

      return Scaffold(
        body: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: kToolbarHeight),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 130,
                          height: 80,
                        ),
                      ],
                    ),
                    Appbar(
                      title: 'Booking'.tr(),
                      showBackButton: true,
                      topPadding: false,
                      fontSize: 25,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Date".tr(),
                                  style:
                                      Fonts().primaryFont(25, FontWeight.w500)),
                            ),
                            SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.055,
                              // width: (MediaQuery.of(context).size.width * 0.35),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                color: primaryComponentColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4.0),
                                  child: Center(
                                    child: Text(
                                      widget.date,
                                      style: Fonts()
                                          .whiteFont(18, FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Time".tr(),
                                  style:
                                      Fonts().primaryFont(25, FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "from".tr(),
                                          style: Fonts()
                                              .primaryFont(17, FontWeight.w500),
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          color: primaryComponentColor,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 4.0),
                                            child: Center(
                                              child: Text(
                                                widget.fromTime,
                                                style: Fonts().whiteFont(
                                                    18, FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "to".tr(),
                                          style: Fonts()
                                              .primaryFont(17, FontWeight.w500),
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          color: primaryComponentColor,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 4.0),
                                            child: Center(
                                              child: Text(
                                                widget.toTime,
                                                style: Fonts().whiteFont(
                                                    18, FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.16,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 0,
                            color: secondComponentColor,
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 12,
                          left: 20,
                          bottom: 12,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width * 0.78,
                            child: TextFormField(
                              controller: complaint,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              cursorColor: primaryBackgroundColor,
                              validator: (v) {
                                if (v == '') {
                                  return 'enter your Booking note';
                                }
                                return null;
                              },
                              style: Fonts().whiteFont(15, FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: "write your note here".tr(),
                                hintStyle:
                                    Fonts().whiteFont(15, FontWeight.w300),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primaryComponentColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primaryComponentColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else if (widget.date == "select" ||
                                widget.fromTime == "select" ||
                                widget.toTime == "select") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('date and time are required'),
                                  backgroundColor: primaryComponentColor,
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else {
                              _formKey.currentState!.save();
                              BlocProvider.of<AppCubit>(context).sendBooking(
                                  details: complaint.value.text,
                                  date: widget.date,
                                  from: widget.fromTime,
                                  timeId: widget.id
                                  //  to: widget.toTime,
                                  );
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryComponentColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Submit'.tr(),
                                  style:
                                      Fonts().secondFont(25, FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: secondTextColor,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => BookingAvailable(),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: primaryComponentColor,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text(
                    //             'available_times'.tr(),
                    //             style: Fonts().secondFont(25, FontWeight.bold),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
