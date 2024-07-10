import 'package:explora_app/components/button.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/components/my_snackbar.dart';
import 'package:explora_app/components/null_data.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/interest_bloc/interest_bloc.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/transactions/add_transaction_dialog.dart';
import 'package:explora_app/models/interest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController percentController = TextEditingController();
    return BlocListener<InterestBloc, InterestState>(
      listener: (context, state) {
        if (state is BungaAdded) {
          _showMyCustomSnackBar(context, "Interest has been set!",
              color: Colors.green, contentColor: white);
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      child: BlocBuilder<InterestBloc, InterestState>(
        bloc: BlocProvider.of<InterestBloc>(context)..add(LoadBunga()),
        builder: (context, state) {
          if (state is InterestInitial || state is BungaAdded) {
            BlocProvider.of<InterestBloc>(context).add(LoadBunga());
          }
          if (state is InterestLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is BungaLoaded) {
            final listBunga = state.listBunga;
            final bunga = state.activeBunga.persen;

            return Scaffold(
              key: _scaffoldKey,
              floatingActionButton: FloatingActionButton(
                  foregroundColor: white,
                  backgroundColor: themeColor,
                  onPressed: () {
                    showDialog(
                        context: _scaffoldKey.currentContext!,
                        builder: (ctx) => BlocProvider<InterestBloc>.value(
                              value: context.read<InterestBloc>(),
                              child: Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                          child: "Manage Interest",
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.w600),
                                      MyTextField(
                                          onTap: () {},
                                          hintText: "Set Interest Percentage",
                                          controller: percentController),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      _button(() {
                                        _confirmationDialog(
                                            context,
                                            double.tryParse(
                                                    percentController.text) ??
                                                0);
                                      }, "Add")
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: Icon(
                    Icons.add,
                    color: white,
                  )),
              backgroundColor: themeColor,
              body: Column(
                children: [
                  _currentBungaHolder(currentBunga: bunga),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: _containerForList(
                      child: listBunga.isEmpty
                          ? const NullData()
                          : ListView.builder(
                              itemCount: listBunga.length,
                              itemBuilder: (context, index) {
                                return _bungaHistoryContainer(
                                    listBunga[index].persen);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("An error occurred"),
          );
        },
      ),
    );
  }
}

Widget _bungaHistoryContainer(double history) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
            child: "$history%",
            fontSize: 16,
            color: black,
            fontWeight: FontWeight.w600),
        Divider(
          color: grey,
        ),
        const SizedBox(
          height: 5,
        )
      ],
    ),
  );
}

void _confirmationDialog(BuildContext context, double interest) {
  showDialog(
      context: context,
      builder: (ctx) => BlocProvider<InterestBloc>.value(
            value: context.read<InterestBloc>(),
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                        child: "Interest is set to",
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.bold),
                    MyText(
                        child: "$interest%",
                        fontSize: 24,
                        color: themeColor,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 20,
                    ),
                    _button(() {
                      Bunga bunga = Bunga(persen: interest, isActive: 1);
                      BlocProvider.of<InterestBloc>(context)
                          .add(AddBunga(bunga: bunga));
                      Navigator.of(context, rootNavigator: true).pop();
                    }, "Confirm")
                  ],
                ),
              ),
            ),
          ));
}

Widget _button(VoidCallback onTap, String text, [Color? color]) {
  color ??= themeColor;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: lightGreen),
          color: color,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: MyText(
              child: text,
              fontSize: 12,
              color: white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

void showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.only(
            top: 24,
            bottom: 12,
            left: 16,
            right: 16), // Sesuaikan dengan padding yang Anda inginkan
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
          top: 60), // Mengatur margin top agar SnackBar muncul di atas layar
    ),
  );
}

Widget _containerForList({required Widget child}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MyText(
              child: "All interest",
              fontSize: 18,
              color: black,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: child),
        ],
      ),
    ),
  );
}

Widget _currentBungaHolder({required double currentBunga}) {
  return Column(
    children: [
      MyText(
          child: "Active Interest",
          fontSize: 24,
          color: white,
          fontWeight: FontWeight.bold),
      const SizedBox(
        height: 20,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: MyText(
              child: "$currentBunga%",
              fontSize: 24,
              color: white,
              fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

void _showMyCustomSnackBar(BuildContext context, String message,
    {required Color? color, required Color? contentColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: color,
      showCloseIcon: true,
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: contentColor,
          ),
          const SizedBox(
            width: 6,
          ),
          MyText(
              child: message,
              fontSize: 12,
              color: contentColor,
              fontWeight: FontWeight.w500),
        ],
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          right: 20,
          left: 20),
    ),
  );
}
