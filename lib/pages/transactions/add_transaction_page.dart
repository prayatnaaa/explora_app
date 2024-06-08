// import 'package:explora_app/components/cool_button.dart';
// import 'package:explora_app/components/text.dart';
// import 'package:explora_app/components/textfield.dart';
// import 'package:explora_app/contents/colors.dart';
// import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
// import 'package:explora_app/data/datasources/transaction_datasource.dart';
// import 'package:explora_app/pages/members/member_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddTransactionPage extends StatefulWidget {
//   final int memberId;
//   const AddTransactionPage({super.key, required this.memberId});

//   @override
//   State<AddTransactionPage> createState() => _AddTransactionPageState();
// }

// final TextEditingController typeController = TextEditingController();
// final TextEditingController amountController = TextEditingController();

// class _AddTransactionPageState extends State<AddTransactionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           TransactionBloc(transactionDatasource: TransactionDatasource()),
//       child: BlocListener<TransactionBloc, TransactionState>(
//         listener: (context, state) {
//           // TODO: implement listener
//           if (state is TransactionAdded) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: MyText(
//                     child: "Success",
//                     fontSize: 16,
//                     color: white,
//                     fontWeight: FontWeight.bold)));
//             // Navigator.pushReplacement(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) =>
//             //             MemberProfile(index: widget.memberId)));
//           }
//         },
//         child: BlocBuilder<TransactionBloc, TransactionState>(
//           builder: (context, state) {
//             return Scaffold(
//               body: Column(
//                 children: [
//                   MyTextField(
//                       onTap: () {},
//                       hintText: "Enter type of Transaction",
//                       controller: typeController),
//                   MyTextField(
//                       onTap: () {},
//                       hintText: "Enter amount",
//                       controller: amountController),
//                   CoolButton(
//                     text: "Add Transaction",
//                     color: themeColor,
//                     onTap: () {
//                       // context.read<TransactionBloc>().add(AddTransaction(
//                       //     memberId: widget.memberId,
//                       //     transactionId: int.tryParse(typeController.text) ?? 0,
//                       //     amount: int.tryParse(amountController.text) ?? 0));

//                       print(widget.memberId);

//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   MemberProfile(memberId: widget.memberId)));
//                     },
//                     textColor: white,
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
