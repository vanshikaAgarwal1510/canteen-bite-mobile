import 'dart:collection';

import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:canteen_bite_mobile/webservice/response/WalletTransactionResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/GlobalData.dart';
import '../model/WalletTransaction.dart';
import '../utils/Constants.dart';
import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../webservice/ApiCall.dart';
import 'Wallet.dart';

class WalletState extends State<Wallet> {
  String filter = 'all';
  List<WalletTransaction> transactions =[];

  Future<void> fetchWalletDetails() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({"apikey": Constants.apiKey,});

    try {
      WalletTransactionResponse response= await apiCall.fetchWalletDetails(request);

      if(response.status ==200){
        setState(() {
          transactions = response.data!;
        });
      }
    } on NetworkException catch (networkException) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  List<WalletTransaction> get filteredTransactions {
    if (filter == 'debit') {
      return transactions.where((t) => t.type == TransactionType.debit).toList();
    }
    if (filter == 'credit') {
      return transactions.where((t) => t.type == TransactionType.credit).toList();
    }
    return transactions;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchWalletDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Column(
        children: [
          Stack(
            children: [
              AppBar(
                title: Text(
                  "CampusBite Wallet",
                  style: TextStyle(
                    fontFamily: "poppins_bold",
                    color: Color(0xFFF6F1F1),
                  ),
                ),
                backgroundColor: Color(0xFFFE9D1D),
                leading: SizedBox(),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/food_doodle.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.4),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Color(0xFFF6F1F1)),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //card
                Container(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD46A00 ),Color(0xFFFE9D1D), Color(0xFFD46A00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFE9D1D).withAlpha(100),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -8,
                  bottom: -12,
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 100,
                    color: Colors.white.withAlpha(40),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT WALLET BALANCE',
                                style: TextStyle(
                                  color: Color(0xD9FFFFFF),
                                  fontSize: 13,
                                  fontFamily: "poppins_bold",
                                  letterSpacing: 0.6,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '₹450.00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: "poppins_bold",
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white70),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle, color: Color(0xFF6EE7B7), size: 13),
                              SizedBox(width: 4),
                              Text(
                                'Active Wallet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "poppins_bold"
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child:
                          InkWell(
                            onTap: (){},
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.open_in_new_rounded, color: Color(0xFFFE9D1D),size: 20),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      "Transfer",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "poppins_bold"
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child:
                          InkWell(
                            onTap: (){},
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(80),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.description_outlined, color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Statement',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "poppins_bold"
                                      ),
                                    ),
                                  ),
                                ],
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
                        ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 14, 10, 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFF5D68D)),
                  ),
                  child: const Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFEDC2),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: SizedBox(
                          width: 38,
                          height: 38,
                          child: Icon(Icons.info_outline_rounded, color: Color(0xFF946200), size: 25),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Top-Up Unavailable',
                              style: TextStyle(
                                  color: Color(0xFF783F00),
                                  fontSize: 14,
                                  fontFamily: "poppins_bold"
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Online wallet top-up service is currently inactive.',
                              style: TextStyle(
                                color: Color(0xFF854D0E),
                                fontFamily: "poppins",
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: Color(0xFFE8E7EA)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Transaction History',
                        style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 14,
                            fontFamily: "poppins_bold"
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          filterChip('All', 'all'),
                          const SizedBox(width: 8),
                          filterChip('Spent', 'debit'),
                          const SizedBox(width: 8),
                          filterChip('Refunds', 'credit'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (filteredTransactions.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: Center(
                            child: Text(
                              'No transactions found',
                              style: TextStyle(color: Colors.black45, fontSize: 12, fontFamily: "poppins"),
                            ),
                          ),
                        )
                      else
                        ...filteredTransactions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final transaction = entry.value;
                          return transactionTile(
                            transaction,
                            showDivider: index != filteredTransactions.length - 1,
                          );
                        }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filterChip(String label, String value) {
    final selected = filter == value;
    return Material(
      color: selected ? Color(0xFF16171B) : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => setState(() => filter = value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF64748B),
              fontSize: 12,
              fontFamily: "poppins",
              fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionTile(
      WalletTransaction transaction, {
        required bool showDivider,
      }) {
    final isCredit = transaction.type == TransactionType.credit;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFF1F5F9)))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isCredit? Color(0xFFECF5DA): Color(0xFFFAECB9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(isCredit?Icons.keyboard_return_rounded:Icons.restaurant, color: isCredit? Color(0xFF4C572C): Color(0xFFB86802), size: 20),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13,
                    fontFamily: "poppins_bold"
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${GlobalData.convertToLocalDate(transaction.date)},${GlobalData.convertToLocalTime(transaction.date)}",
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontFamily: "poppins_semibold"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: isCredit ? Color(0xFF779830) : const Color(0xFF0F172A),
                  fontSize: 13,
                  fontFamily: "poppins_bold"
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: isCredit
                      ? const Color(0xFF779830).withAlpha(40)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  transaction.status,
                  style: TextStyle(
                    color: isCredit
                        ? const Color(0xFF4C572C)
                        : const Color(0xFF475569),
                    fontSize: 9,
                      fontFamily: "poppins_bold"
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}



