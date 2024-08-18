import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/colors/global.dart';
import 'package:quran_app/tabs/hijb_tab.dart';
import 'package:quran_app/tabs/page_tab.dart';
import 'package:quran_app/tabs/para_tab.dart';
import 'package:quran_app/tabs/surah_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorund,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNaviagationBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _greetings(),
              ),
              SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: backgorund,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: _tabBar(),
                ),
                shape: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: Color(0xffaaaaaa).withOpacity(.1),
                  ),
                ),
              )
            ],
            body: const TabBarView(
              children: [SurahTab(), ParaTab(), PageTab(), HijbTab()],
            ),
          ),
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      dividerColor: primary,
      unselectedLabelColor: text,
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      tabs: [
        _tabItems("Surah"),
        _tabItems("Para"),
        _tabItems("Page"),
        _tabItems("Hijb"),
      ],
    );
  }

  Tab _tabItems(String label) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Column _greetings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Assalamualaikum",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: text,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Muhammad Rizky",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
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
          child: SvgPicture.asset("assets/svg/quran.svg"),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svg/quran_small.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    child: Text(
                      "Last Read",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                child: Text(
                  "Al-Fatiah",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Text(
                  "Ayah No:1",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  BottomNavigationBar _bottomNaviagationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: grey,
      items: [
        _bottomBarItems(
            icon: "assets/svg/quran_bottom_bar.svg", label: "Quran"),
        _bottomBarItems(
            icon: "assets/svg/lamp_bottom_bar.svg", label: "Arah Kiblat"),
        _bottomBarItems(
            icon: "assets/svg/person_bottom_bar.svg", label: "Sholat"),
        _bottomBarItems(icon: "assets/svg/hand_bottom_bar.svg", label: "Doa"),
        _bottomBarItems(
            icon: "assets/svg/bookmark_bottom_bar.svg", label: "Bookmark"),
      ],
    );
  }

  BottomNavigationBarItem _bottomBarItems(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            color: text,
          ),
          activeIcon: SvgPicture.asset(
            icon,
            color: primary,
          ),
          label: label);

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgorund,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svg/menu_icon.svg"),
          ),
          const SizedBox(width: 24),
          Text(
            "Quran App",
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
