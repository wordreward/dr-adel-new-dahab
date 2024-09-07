import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/screens/booking.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingAvailable extends StatefulWidget {
  const BookingAvailable({super.key});

  @override
  State<BookingAvailable> createState() => _BookingAvailableState();
}

class _BookingAvailableState extends State<BookingAvailable> {
  PageController pageController = PageController();
  bool isLast = false;
  bool isFirst = true;
  int currentPageIndex = 0; // Track the current page index

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAvailableDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = BlocProvider.of<AppCubit>(context).loginModel;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
              child: ConditionalBuilder(
                condition:
                    BlocProvider.of<AppCubit>(context).getAvailableDatesModel !=
                        null,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) => Column(
                  children: [
                    Appbar(
                      title: 'available_times'.tr(),
                      showBackButton: true,
                      topPadding: false,
                      fontSize: 25,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isFirst
                            ? const SizedBox(width: 20, height: 1)
                            : GestureDetector(
                                onTap: () {
                                  pageController.previousPage(
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                              ),
                        Flexible(
                          child: Text(
                            BlocProvider.of<AppCubit>(context)
                                    .timesbyDate[currentPageIndex][
                                'date'], // Adjust this to display the current page's date
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        isLast
                            ? const SizedBox(width: 20, height: 1)
                            : GestureDetector(
                                onTap: () {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: BlocProvider.of<AppCubit>(context)
                            .timesbyDate
                            .length,
                        onPageChanged: (int index) {
                          setState(() {
                            currentPageIndex = index;
                            isFirst = index == 0;
                            isLast = index ==
                                BlocProvider.of<AppCubit>(context)
                                        .timesbyDate
                                        .length -
                                    1;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          final bookingData = BlocProvider.of<AppCubit>(context)
                              .timesbyDate[pageIndex];
                          final availableSlots =
                              bookingData['available'] as List<String>;
                          final unavailableSlots =
                              bookingData['unavailable'] as List<String>;

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              childAspectRatio:
                                  2, // Ratio to make the slots wider
                              crossAxisSpacing: 4, // Spacing between columns
                              mainAxisSpacing: 4, // Spacing between rows
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemCount:
                                availableSlots.length + unavailableSlots.length,
                            itemBuilder: (context, index) {
                              if (index < availableSlots.length) {
                                return BookingSlot(
                                  date: bookingData['date'],
                                  time: availableSlots[index],
                                  available: true,
                                  onTap: (date, from, to) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Booking(
                                              date: date,
                                              fromTime: from,
                                              toTime: to,
                                               id: BlocProvider.of<AppCubit>(context)
                                    .timesbyDate[currentPageIndex][
                                'id'],
                                              ),
                                        ));
                                    // BlocProvider.of<AppCubit>(context)
                                    //     .sendBooking(
                                    //         date: date, from: from, to: to);
                                  },
                                );
                              } else {
                                final unavailableIndex =
                                    index - availableSlots.length;
                                return BookingSlot(
                                  date: bookingData['date'],
                                  time: unavailableSlots[unavailableIndex],
                                  available: false,
                                  onTap: (date, from, to) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Booking(
                                              date: date,
                                              fromTime: from,
                                              toTime: to,
                                              id: BlocProvider.of<AppCubit>(context)
                                    .timesbyDate[currentPageIndex][
                                'id'],
                                              ),
                                        ));
                                    // BlocProvider.of<AppCubit>(context)
                                    //     .sendBooking(
                                    //         date: date, from: from, to: to);
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 20),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           isFirst
                    //               ? const SizedBox(
                    //                   width: 20,
                    //                   height: 1,
                    //                 )
                    //               : GestureDetector(
                    //                   onTap: () {
                    //                     pageController.previousPage(
                    //                         duration:
                    //                             const Duration(milliseconds: 750),
                    //                         curve: Curves.fastLinearToSlowEaseIn);
                    //                   },
                    //                   child: Icon(
                    //                     Icons.arrow_back_ios,
                    //                     size: 20,
                    //                   )),
                    //           Flexible(
                    //             child: Text(
                    //               bookingData[0]['date'],
                    //               style: const TextStyle(
                    //                   fontSize: 16, fontWeight: FontWeight.bold),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //           isLast
                    //               ? const SizedBox(
                    //                   width: 20,
                    //                   height: 1,
                    //                 )
                    //               : GestureDetector(
                    //                   onTap: () {
                    //                     pageController.nextPage(
                    //                         duration:
                    //                             const Duration(milliseconds: 750),
                    //                         curve: Curves.fastLinearToSlowEaseIn);
                    //                   },
                    //                   child: Icon(
                    //                     Icons.arrow_forward_ios,
                    //                     size: 20,
                    //                     //color: AppColors.red,
                    //                   ),
                    //                 ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 30,
                    //       ),
                    //       Expanded(
                    //         child: PageView.builder(
                    //           controller: pageController,
                    //           physics: BouncingScrollPhysics(),
                    //           itemBuilder: (context, index) => ListView.builder(
                    //             itemCount: bookingData.length,
                    //             itemBuilder: (context, index) {
                    //               final slot = bookingData[index];
                    //               final time = slot['time'];
                    //               final available = slot['available'] == 1;

                    //               return BookingSlot(
                    //                 time: time,
                    //                 available: available,
                    //               );
                    //             },
                    //           ),

                    //           // BlocProvider.of<AppCubit>(
                    //           //                                       context).timesbyDate[index],
                    //           itemCount: BlocProvider.of<AppCubit>(context)
                    //               .timesbyDate
                    //               .length,
                    //           onPageChanged: (int index) {
                    //             if (index ==
                    //                 BlocProvider.of<AppCubit>(context)
                    //                         .timesbyDate
                    //                         .length -
                    //                     1) {
                    //               setState(() {
                    //                 isLast = true;
                    //                 print('isLast');
                    //               });
                    //             } else {
                    //               setState(() {
                    //                 isLast = false;
                    //                 print('notLas');
                    //               });
                    //             }
                    //             if (index == 0) {
                    //               setState(() {
                    //                 isFirst = true;
                    //                 print('notLas');
                    //               });
                    //             } else {
                    //               setState(() {
                    //                 isFirst = false;
                    //                 print('notLas');
                    //               });
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Expanded(
                    //   child: Column(
                    //     children: [
                    //       // Date selector
                    //       Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             IconButton(
                    //               icon: Icon(Icons.arrow_back_ios),
                    //               onPressed: () {},
                    //             ),
                    //             Text(
                    //               '10 March 2024',
                    //               style: TextStyle(
                    //                   fontSize: 20, fontWeight: FontWeight.bold),
                    //             ),
                    //             IconButton(
                    //               icon: Icon(Icons.arrow_forward_ios),
                    //               onPressed: () {},
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Text("data"),
                    //       Expanded(
                    //         child: ListView.builder(
                    //           itemCount: bookingData.length,
                    //           itemBuilder: (context, index) {
                    //             final slot = bookingData[index];
                    //             final time = slot['time'];
                    //             final available = slot['available'] == 1;

                    //             return BookingSlot(
                    //               time: time,
                    //               available: available,
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class BookingSlot extends StatelessWidget {
  final String date;
  final String time;
  final bool available;
  final Function(String, String, String) onTap;

  const BookingSlot({
    Key? key,
    required this.date,
    required this.time,
    required this.available,
    required this.onTap,
  }) : super(key: key);

  String formatTime(String timeRange) {
    final parts = timeRange.split(' to ');
    final fromTime = parts[0].split(' ')[1];
    final toTime = parts[1];
    return '$fromTime - $toTime';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!available) {
          // Show a Snackbar if the slot is not available
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('not_available'.tr()),
              duration: Duration(seconds: 2),
            ),
          );
          return; // Early return to prevent further execution
        }

        try {
          // Trim the time string to remove any leading or trailing whitespace
          final trimmedTime = time.trim();

          // Check if the time format is in Arabic
          bool isArabic = trimmedTime.contains('من');

          if (isArabic) {
            // Arabic format: "من hh:mm AM الي hh:mm AM"
            final regex = RegExp(
                r'من\s+(\d{1,2}:\d{2}\s?[APMapm]{2})\s*الي\s*(\d{1,2}:\d{2}\s?[APMapm]{2})',
                caseSensitive: false); // Case-insensitive

            final match = regex.firstMatch(trimmedTime);

            if (match != null && match.groupCount == 2) {
              final fromTimeString = match.group(1)!.trim();
              final toTimeString = match.group(2)!.trim();

              // Parse the time using DateFormat
              final fromTime = DateFormat("h:mm a").parse(fromTimeString);
              final toTime = DateFormat("h:mm a").parse(toTimeString);

              // Format the parsed times to "HH:mm"
              final formattedFromTime = DateFormat('HH:mm').format(fromTime);
              final formattedToTime = DateFormat('HH:mm').format(toTime);

              onTap(date, formattedFromTime, formattedToTime);
            } else {
              throw FormatException(
                  "Time format is incorrect for Arabic format: $trimmedTime");
            }
          } else {
            // English format: "from hh:mm AM to hh:mm AM"
            final regex = RegExp(
                r'from\s+(\d{1,2}:\d{2}\s?[APMapm]{2})\s*to\s*(\d{1,2}:\d{2}\s?[APMapm]{2})',
                caseSensitive: false); // Case-insensitive

            final match = regex.firstMatch(trimmedTime);

            if (match != null && match.groupCount == 2) {
              final fromTimeString = match.group(1)!.trim();
              final toTimeString = match.group(2)!.trim();

              // Parse the time using DateFormat
              final fromTime = DateFormat("h:mm a").parse(fromTimeString);
              final toTime = DateFormat("h:mm a").parse(toTimeString);

              // Format the parsed times to "HH:mm"
              final formattedFromTime = DateFormat('HH:mm').format(fromTime);
              final formattedToTime = DateFormat('HH:mm').format(toTime);

              onTap(date, formattedFromTime, formattedToTime);
            } else {
              throw FormatException(
                  "Time format is incorrect for English format: $trimmedTime");
            }
          }
        } catch (e) {
          print('Error parsing time: $e');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: available ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
