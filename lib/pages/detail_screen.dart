import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/colors/global.dart';
import 'package:quran_app/models/model_ayat.dart';

import 'package:quran_app/models/model_surah.dart';

class DetailScreen extends StatelessWidget {
  final int nomorSurah;
  const DetailScreen({super.key, required this.nomorSurah});

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$nomorSurah");
    return Surah.fromJson(jsonDecode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      initialData: null,
      future: _getDetailSurah(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold();
        }
        Surah surah = snapshot.data!;
        return Scaffold(
          backgroundColor: backgorund,
          appBar: _appBar(context: context, surah: surah),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _detailContainer(surah: surah),
              )
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (nomorSurah == 1 ? 1 : 0))),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: surah.jumlahAyat + (nomorSurah == 1 ? -1 : 0)),
            ),
          ),
        );
      },
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27 / 2),
                        color: primary),
                    child: Center(
                      child: Text(
                        "${ayat.nomor}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(
                color: text,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      );

  Widget _detailContainer({required Surah surah}) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Stack(
          children: [
            Container(
              height: 257,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffDF98FA),
                    Color(0xff9055FF),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                  "assets/svg/quran.svg",
                  width: 324 - 55,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        surah.namaLatin,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      surah.arti,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.35),
                      thickness: 2,
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surah.tempatTurun.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " ${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    SvgPicture.asset("assets/svg/bismillah.svg")
                  ],
                ),
              ),
            )
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgorund,
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset("assets/svg/back.svg"),
          ),
          const SizedBox(width: 24),
          Text(
            surah.namaLatin,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/search_icon.svg")),
        ],
      ),
    );
  }
}
