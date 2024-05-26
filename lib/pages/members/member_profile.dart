import 'dart:async';

import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/remote_datasource.dart';
import 'package:explora_app/helper/member_button.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberProfile extends StatefulWidget {
  final int index;
  const MemberProfile({super.key, required this.index});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  final MemberBloc memberBloc =
      MemberBloc(remoteDataSource: RemoteDataSource());
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final idNumController = TextEditingController();
  final phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => memberBloc..add(LoadMember()),
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, memberState) {
          if (memberState is MemberInitial ||
              memberState is MemberAdded ||
              memberState is MemberDeleted ||
              memberState is MemberEdited) {
            BlocProvider.of<MemberBloc>(context).add(LoadMember());
          } else if (memberState is MemberLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: themeColor,
              ),
            );
          } else if (memberState is MemberLoaded) {
            final members = memberState.members;
            final member = members[widget.index];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColor,
                foregroundColor: white,
                title: MyText(
                  child: "Member Details",
                  fontSize: 24,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: white,
                hoverColor: themeColor,
                child: Icon(
                  Icons.add,
                  color: themeColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MemberButton(
                        title: "Add",
                        addressController: addressController,
                        nameController: nameController,
                        phoneNumController: phoneNumController,
                        idNumController: idNumController,
                        birthDateController: birthDateController,
                        onPressed: () {
                          Member newMember = Member(
                            nomor_induk:
                                int.tryParse(idNumController.text) ?? 0,
                            nama: nameController.text,
                            alamat: addressController.text,
                            tgl_lahir: birthDateController.text,
                            telepon: phoneNumController.text,
                          );

                          memberBloc.add(AddMember(member: newMember));
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      );
                    },
                  );
                },
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          member.nama,
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailItem(
                          "ID Number", member.nomor_induk.toString()),
                      _buildDetailItem("Name", member.nama),
                      _buildDetailItem("Address", member.alamat),
                      _buildDetailItem("Birth Date", member.tgl_lahir),
                      _buildDetailItem("Phone Number", member.telepon),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showEditDeleteDialog(member);
                          },
                          icon: Icon(Icons.edit, color: white),
                          label: MyText(
                            child: "Edit / Delete",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (memberState is MemberError) {
            return Center(
              child: Text(memberState.error),
            );
          }
          return const SizedBox(
            child: Text("Failed"),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDeleteDialog(Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: MyText(
                    child: "What do you want?",
                    fontSize: 24,
                    color: themeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CoolButton(
                      text: 'Edit',
                      color: Colors.yellow,
                      onTap: () {
                        _prepareForEditing(member);
                        _showEditDialog(member);
                      },
                    ),
                    const SizedBox(width: 10),
                    CoolButton(
                      text: "Delete",
                      color: Colors.red,
                      onTap: () {
                        memberBloc.add(DeleteMember(id: member.id));
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _prepareForEditing(Member member) {
    setState(() {
      addressController.text = member.alamat;
      nameController.text = member.nama;
      phoneNumController.text = member.telepon;
      idNumController.text = member.nomor_induk.toString();
      birthDateController.text = member.tgl_lahir;
    });
  }

  void _showEditDialog(Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MemberButton(
          title: "Edit",
          addressController: addressController,
          nameController: nameController,
          phoneNumController: phoneNumController,
          idNumController: idNumController,
          birthDateController: birthDateController,
          onPressed: () {
            Member updatedMember = Member(
              status_aktif: 1,
              id: member.id,
              nomor_induk: int.tryParse(idNumController.text) ?? 0,
              nama: nameController.text,
              alamat: addressController.text,
              tgl_lahir: birthDateController.text,
              telepon: phoneNumController.text,
            );

            memberBloc.add(EditMember(member: updatedMember));
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }
}
