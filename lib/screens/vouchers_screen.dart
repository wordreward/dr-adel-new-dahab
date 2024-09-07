import 'package:adelnewversion/core/theme/colors.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/app_cubit/app_cubit.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllTrans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.0125),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Appbar(
                    topPadding: false,
                    fontSize: 20,
                    // textAlign: TextAlign.center,
                    title: 'points_report'.tr(),
                    showBackButton: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.only(
                          left: 20.0, bottom: 20, right: 20, top: 0),
                      decoration: const BoxDecoration(
                        color: primaryTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: ConditionalBuilder(
                        condition: BlocProvider.of<AppCubit>(context)
                                .getTransactionsModel !=
                            null,
                        builder: (context) {
                          var model = BlocProvider.of<AppCubit>(context)
                              .getTransactionsModel;
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: model!.transactions!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(
                                    model.transactions![index].points
                                        .toString(),
                                    style: const TextStyle(
                                      color: primaryComponentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(model.transactions![index].name!,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        model.transactions![index].date == null
                                            ? SizedBox()
                                            : Text(
                                                model.transactions![index].date
                                                    .toString()
                                                    .split('00')[0],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                      ]),
                                  leading: model.transactions![index].points
                                          .toString()
                                          .contains('-')
                                      ? const CircleAvatar(
                                          backgroundColor:
                                              primaryComponentColor,
                                          child: Icon(
                                            Icons.remove_outlined,
                                            color: primaryTextColor,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor:
                                              primaryComponentColor,
                                          child: Icon(
                                            Icons.add,
                                            color: primaryTextColor,
                                          ),
                                        ));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 1,
                                color: backButtonColor,
                              );
                            },
                          );
                        },
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
