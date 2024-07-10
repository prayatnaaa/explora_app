import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/components/my_snackbar.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:explora_app/pages/transactions/transactions_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/components/text.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MemberProfile extends StatefulWidget {
  final String id;
  const MemberProfile({super.key, required this.id});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  final MemberBloc memberBloc =
      MemberBloc(remoteDataSource: RemoteDataSource());
  final TransactionBloc transactionBloc =
      TransactionBloc(transactionDatasource: TransactionDatasource());
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final idNumController = TextEditingController();
  final phoneNumController = TextEditingController();
  final List<TransactionType> transactionsTypes =
      TransactionType.transactionsType;

  bool addressIsSelected = false;
  @override
  Widget build(BuildContext context) {
    int memberId = int.tryParse(widget.id) ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            context.go("/member");
          },
          icon: const Icon(Icons.arrow_back),
          color: black,
        ),
        elevation: 0,
        title: MyText(
            child: "Member Profile",
            fontSize: 16,
            color: black,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: white,
      body: Column(
        children: [
          BlocListener<MemberBloc, MemberState>(
            listener: (context, state) {
              if (state is MemberDeleted) {
                // context.pushReplacement("/member");
                _successDeleteMessage(context);
              }

              if (state is MemberEdited) {
                showCustomSnackBar(context, "Member Successfully edited!",
                    color: Colors.green, contentColor: white);
                context.pop();
              }
              if (state is MemberError) {
                showCustomSnackBar(context, "Invalid data!",
                    color: Colors.red, contentColor: white);
              }
              // TODO: implement listener
            },
            child: BlocBuilder(
                bloc: BlocProvider.of<MemberBloc>(context)
                  ..add(LoadMemberById(id: memberId)),
                builder: (context, state) {
                  if (state is MemberInitial || state is MemberEdited) {
                    BlocProvider.of<MemberBloc>(context)
                        .add(LoadMemberById(id: memberId));
                  } else if (state is MemberLoading) {
                    return const Center(
                      child: LoadingScreen(),
                    );
                  } else if (state is MemberLoadedById) {
                    final member = state.memberDetail;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 400,
                              height: 220,
                              decoration: BoxDecoration(
                                  border: Border.all(color: themeColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _isMemberActiveContainer(
                                        activeStatus: member.statusAktif),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: MyText(
                                          child: member.nama,
                                          fontSize: 24,
                                          color: black,
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      children: [
                                        _editButton(context,
                                            memberId: member.id,
                                            isActive: member.statusAktif,
                                            memberName: member.nama,
                                            memberNoInduk: member.nomor_induk,
                                            memberBirthdate: member.tglLahir,
                                            memberAddress: member.alamat,
                                            memberPhone: member.telepon),
                                        _deleteMember(context,
                                            memberName: member.nama,
                                            id: member.id)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 220,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _memberAttributeContainer(
                                      member.id.toString(),
                                      Icons.perm_identity),
                                  _memberAttributeContainer(
                                      member.nomor_induk.toString(),
                                      Icons.description),
                                  _memberAttributeContainer(
                                      member.alamat, Icons.location_on),
                                  _memberAttributeContainer(
                                      member.telepon, Icons.phone),
                                  _memberAttributeContainer(
                                      member.tglLahir, Icons.calendar_today),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is MemberError) {
                    return Center(
                      child: MyText(
                          child: state.error,
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.normal),
                    );
                  }
                  return Container();
                }),
          ),
          //TODO: transactions
          Expanded(
            child: BlocBuilder<MemberBloc, MemberState>(
              bloc: BlocProvider.of<MemberBloc>(context)
                ..add(LoadMemberById(id: memberId)),
              builder: (context, state) {
                if (state is MemberInitial) {
                  LoadMemberById(id: memberId);
                } else if (state is MemberLoading) {
                  return const LoadingScreen();
                } else if (state is MemberLoadedById) {
                  final member = state.memberDetail;
                  return TransactionsContainer(
                    isActive: member.statusAktif,
                    id: memberId,
                  );
                } else if (state is MemberError) {
                  return const LoadingScreen();
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _memberAttributeContainer(String text, IconData icon, [double? height]) {
  return Container(
    width: 300,
    height: height,
    decoration: BoxDecoration(
        color: themeColor, borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  weight: 1,
                  icon,
                  color: white,
                ),
              ),
            ],
          ),
          Flexible(
            flex: 3,
            child: MyText(
              child: text,
              fontSize: 12,
              color: white,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _editButton(BuildContext context,
    {required String memberName,
    required int memberNoInduk,
    required String memberBirthdate,
    required String memberAddress,
    required String memberPhone,
    required memberId,
    required int? isActive}) {
  final TextEditingController nameController =
      TextEditingController(text: memberName);
  final TextEditingController addressController =
      TextEditingController(text: memberAddress);
  final TextEditingController phoneController =
      TextEditingController(text: memberPhone);
  final TextEditingController noIndukController =
      TextEditingController(text: memberNoInduk.toString());
  final TextEditingController birthDateController =
      TextEditingController(text: memberBirthdate);

  Future<void> selectDate() async {
    DateTime initialDate = DateTime.tryParse(memberBirthdate) ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now().subtract(const Duration(days: 100000)),
        lastDate: DateTime.now());

    if (picked != null || picked != initialDate) {
      birthDateController.text = picked.toString().substring(0, 10);
    }
  }

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (ctx) => BlocProvider.value(
                value: context.read<MemberBloc>(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textfield(noIndukController, "No Induk"),
                      _textfield(nameController, "Name"),
                      _textfield(addressController, "Address"),
                      _textfield(phoneController, "Phone"),
                      GestureDetector(
                        onTap: () => selectDate(),
                        child: AbsorbPointer(
                          child: _textfield(birthDateController, "Birth Date"),
                        ),
                      ),
                      StatefulBuilder(builder: (context, StateSetter setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Active Status"),
                            Switch(
                              value: isActive == 1,
                              onChanged: (bool value) {
                                setState(() {
                                  isActive = value ? 1 : 0;
                                });
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                            ),
                          ],
                        );
                      }),
                      _button(() {
                        Member member = Member(
                          id: memberId,
                          status_aktif: isActive,
                          nomor_induk:
                              int.tryParse(noIndukController.text) ?? 0,
                          nama: nameController.text,
                          alamat: addressController.text,
                          tgl_lahir: birthDateController.text,
                          telepon: phoneController.text,
                        );
                        print(isActive);
                        showDialog(
                            context: context,
                            builder: (ctx) => BlocProvider.value(
                                  value: context.read<MemberBloc>(),
                                  child: Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _editMemberConfirmData(
                                              id: member.id.toString(),
                                              name: member.nama,
                                              address: member.alamat,
                                              birthDate: member.tgl_lahir,
                                              phoneNumber: member.telepon),
                                          _button(() {
                                            BlocProvider.of<MemberBloc>(context)
                                                .add(
                                                    EditMember(member: member));
                                            context.pop();
                                          }, "Confirm"),
                                          _cancelButton(context)
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      }, "Edit"),
                      _cancelButton(context)
                    ],
                  ),
                ),
              ));
    },
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: themeColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: MyText(
              child: "Edit",
              fontSize: 12,
              color: white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget _deleteMember(BuildContext context,
    {required String memberName, required int id}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) => BlocProvider.value(
                  value: context.read<MemberBloc>(),
                  child: Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyText(
                              child: "Are you sure you want to delete",
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                          MyText(
                              child: memberName,
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            height: 12,
                          ),
                          _button(() {
                            BlocProvider.of<MemberBloc>(context)
                                .add(DeleteMember(id: id));
                            context.pop();

                            context.pop();
                          }, "Delete", Colors.red),
                          _cancelButton(context)
                        ],
                      ),
                    ),
                  ),
                ));
      },
      child: const MyText(
          child: "Delete",
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w600),
    ),
  );
}

void _successDeleteMessage(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                    child: "Member successfully deleted!",
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 20,
                ),
                _button(() {
                  context.go('/member');
                }, "Ok")
              ],
            ),
          ),
        );
      });
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
            labelStyle: GoogleFonts.poppins(
                color: black, fontSize: 12, fontWeight: FontWeight.w600),
            hoverColor: black,
            fillColor: black,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: grey)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: black)),
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

Widget _editMemberConfirmData(
    {required String id,
    required String name,
    required String address,
    required String birthDate,
    required String phoneNumber}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyText(
          child: "Name",
          fontSize: 12,
          color: black,
          fontWeight: FontWeight.w400),
      MyText(
          child: name, fontSize: 12, color: black, fontWeight: FontWeight.bold),
      Divider(
        color: grey,
        thickness: 1,
      ),
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

Widget _cancelButton(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const MyText(
                child: "Cancel",
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w500)),
      ),
    ],
  );
}

Widget _isMemberActiveContainer({required int? activeStatus}) {
  if (activeStatus == 0) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyText(
              child: "Inactive",
              fontSize: 12,
              color: black,
              fontWeight: FontWeight.bold),
          const SizedBox(
            width: 4,
          ),
          const SizedBox(
              width: 12,
              height: 12,
              child: CircleAvatar(
                backgroundColor: Colors.red,
              ))
        ],
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyText(
            child: "Active",
            fontSize: 12,
            color: black,
            fontWeight: FontWeight.bold),
        const SizedBox(
          width: 4,
        ),
        const SizedBox(
            width: 12,
            height: 12,
            child: CircleAvatar(
              backgroundColor: Colors.green,
            ))
      ],
    ),
  );
}
