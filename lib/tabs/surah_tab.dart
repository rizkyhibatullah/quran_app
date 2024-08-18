import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/colors/global.dart';
import 'package:quran_app/models/model_surah.dart';
import 'package:quran_app/pages/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});
  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString("assets/data/surah.json");
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _getSurahList(),
      initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return ListView.separated(
          itemBuilder: (context, index) => _surahItem(
              context: context, surah: snapshot.data!.elementAt(index)),
          separatorBuilder: (context, index) => Divider(
            color: const Color(0xff7880ad).withOpacity(0.35),
          ),
          itemCount: snapshot.data!.length,
        );
      },
    );
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailScreen(nomorSurah: surah.nomor)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  SvgPicture.asset("assets/svg/nomor_surah.svg"),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Center(
                      child: Text(
                        "${surah.nomor}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          surah.tempatTurun.name,
                          style: GoogleFonts.poppins(
                            color: text,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: text,
                          ),
                        ),
                        Text(
                          " ${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(
                            color: text,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text(
                surah.nama,
                style: GoogleFonts.amiri(
                  color: primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
