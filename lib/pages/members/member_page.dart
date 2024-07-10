import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/components/my_snackbar.dart';
import 'package:explora_app/components/null_data.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final nameController = TextEditingController();
    final birthDateController = TextEditingController();
    final idNumController = TextEditingController();
    final phoneNumController = TextEditingController();

    int idNum() {
      DateTime now = DateTime.now();
      String id = '${now.hour}${now.minute}${now.second}';
      return int.tryParse(id) ?? 0;
    }

    Future<void> selectDate() async {
      DateTime initialDate =
          DateTime.tryParse(birthDateController.text) ?? DateTime.now();
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now().subtract(const Duration(days: 100000)),
          lastDate: DateTime.now());

      if (picked != null || picked != initialDate) {
        birthDateController.text = picked.toString().substring(0, 10);
      }
    }

    return Scaffold(
      backgroundColor: white,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: _addMemberButton(() {
          showModalBottomSheet(
              context: context,
              builder: (ctx) => BlocProvider<MemberBloc>.value(
                  value: context.read<MemberBloc>(),
                  child: BlocListener<MemberBloc, MemberState>(
                    listener: (context, state) {
                      if (state is MemberAdded) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                                child: "Add new member",
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 24,
                            ),
                            // _textfield(idNumController, "Member's ID"),
                            _idNumGenerator(idNum()),
                            _textfield(nameController, "Member's name"),
                            TextFormField(
                              controller: birthDateController,
                              decoration: InputDecoration(
                                  labelText: "Member's birth date",
                                  labelStyle: GoogleFonts.poppins(
                                      color: black, fontSize: 12),
                                  hoverColor: lightGreen,
                                  fillColor: lightGreen,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: themeColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: lightGreen)),
                                  filled: false),
                              readOnly: true,
                              onTap: () => selectDate(),
                            ),
                            _textfield(
                                phoneNumController, "Member's phone number"),
                            _textfield(addressController, "Member's address"),
                            const SizedBox(
                              height: 20,
                            ),
                            _button(() {
                              showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      BlocProvider<MemberBloc>.value(
                                        value: context.read<MemberBloc>(),
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    MyText(
                                                        child:
                                                            "Are you sure you want to add ${nameController.text}?",
                                                        fontSize: 16,
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                _addMemberConfirmData(
                                                    idNum().toString(),
                                                    // idNumController.text,
                                                    nameController.text,
                                                    addressController.text,
                                                    birthDateController.text,
                                                    phoneNumController.text),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                _button(() {
                                                  Member member = Member(
                                                      // nomor_induk: int.tryParse(
                                                      //         idNumController
                                                      //             .text) ??
                                                      //     0,
                                                      nomor_induk: idNum(),
                                                      nama: nameController.text,
                                                      alamat: addressController
                                                          .text,
                                                      tgl_lahir:
                                                          birthDateController
                                                              .text,
                                                      telepon:
                                                          phoneNumController
                                                              .text);

                                                  BlocProvider.of<MemberBloc>(
                                                          context)
                                                      .add(AddMember(
                                                          member: member));
                                                  Navigator.of(ctx).pop();
                                                }, "Confirm"),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                _button(() {
                                                  Navigator.pop(context);
                                                }, "Cancel", Colors.red)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                            }, "Submit"),
                            const SizedBox(
                              height: 5,
                            ),
                            // _button(() {
                            //   Navigator.pop(context);
                            // }, "Cancel", Colors.red)
                          ],
                        ),
                      ),
                    ),
                  )));
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<MemberBloc, MemberState>(
              listener: (context, state) {
                if (state is MemberAdded) {
                  _showMyCustomSnackBar(context, "Member successfully added!",
                      color: Colors.green, contentColor: white);
                }
                // TODO: implement listener
              },
              child: BlocBuilder(
                  bloc: BlocProvider.of<MemberBloc>(context)..add(LoadMember()),
                  builder: (context, state) {
                    if (state is MemberInitial ||
                        state is MemberAdded ||
                        state is MemberEdited ||
                        state is MemberDeleted) {
                      BlocProvider.of<MemberBloc>(context).add(LoadMember());
                    } else if (state is MemberLoading) {
                      return const LoadingScreen();
                    } else if (state is MemberLoaded) {
                      final members = state.members;

                      members.sort((a, b) => a.nama.compareTo(b.nama));
                      if (members.isEmpty) {
                        return const NullData();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: members.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: themeColor),
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MyText(
                                                      child:
                                                          members[index].nama,
                                                      fontSize: 12,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    // _isMemberActiveContainer(
                                                    //     activeStatus:
                                                    //         members[index]
                                                    //             .status_aktif)
                                                    Row(
                                                      children: [
                                                        MyText(
                                                            child:
                                                                "nomor induk ",
                                                            fontSize: 12,
                                                            color: black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        MyText(
                                                            child:
                                                                members[index]
                                                                    .nomor_induk
                                                                    .toString(),
                                                            fontSize: 12,
                                                            color: black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      context.go(
                                                          "/member/${members[index].id}");
                                                    },
                                                    icon: Icon(
                                                      Icons.info_outline,
                                                      color: black,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      );
                    } else if (state is MemberError) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: MyText(
                              child: state.error,
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

String currencyFormatter(int number) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: "Rp ");
  String formattedNumber = formatter.format(number);

  return formattedNumber;
}

Widget _addMemberButton(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 200,
      decoration: BoxDecoration(
          color: themeColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.add_circle,
              color: white,
            ),
            MyText(
                child: "Create new member",
                fontSize: 12,
                color: white,
                fontWeight: FontWeight.bold),
          ],
        ),
      ),
    ),
  );
}

Widget _idNumGenerator(int idNum) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                child: "Registration Number",
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.normal),
            const SizedBox(
              width: 4,
            ),
            MyText(
                child: idNum.toString(),
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.w600),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _textfield(TextEditingController? controller, String labelText) {
  if (controller!.text.isEmpty) {
    print("cannot");
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: controller.text,
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(color: black, fontSize: 12),
            hoverColor: lightGreen,
            fillColor: lightGreen,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: themeColor)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            filled: false)),
  );
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

Widget _addMemberConfirmData(String id, String name, String address,
    String birthDate, String phoneNumber) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyText(
          child: "ID", fontSize: 12, color: black, fontWeight: FontWeight.w400),
      MyText(
          child: id, fontSize: 12, color: black, fontWeight: FontWeight.bold),
      Divider(
        color: grey,
        thickness: 1,
      ),
      const SizedBox(
        height: 2,
      ),
      MyText(
          child: "Phone number",
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.w400),
      MyText(
          child: phoneNumber,
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.bold),
      Divider(
        color: grey,
      ),
      const SizedBox(
        height: 2,
      ),
      MyText(
          child: "Address",
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.w400),
      MyText(
          child: address,
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.bold),
      Divider(
        color: grey,
      ),
      const SizedBox(
        height: 2,
      ),
      MyText(
          child: "Birth Date",
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.w400),
      MyText(
          child: birthDate,
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.bold),
      Divider(
        color: grey,
      ),
      const SizedBox(
        height: 2,
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

Widget _isMemberActiveContainer({required int? activeStatus}) {
  if (activeStatus == 0) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
              width: 12,
              height: 12,
              child: CircleAvatar(
                backgroundColor: Colors.red,
              )),
          const SizedBox(
            width: 4,
          ),
          MyText(
              child: "Inactive",
              fontSize: 12,
              color: black,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
            width: 12,
            height: 12,
            child: CircleAvatar(
              backgroundColor: Colors.green,
            )),
        const SizedBox(
          width: 4,
        ),
        MyText(
            child: "Active",
            fontSize: 12,
            color: black,
            fontWeight: FontWeight.bold),
      ],
    ),
  );
}
