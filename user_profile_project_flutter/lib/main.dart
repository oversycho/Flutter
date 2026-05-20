import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  // This widget is the root of your application.
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    // Color SurfaceColor = Colors.white10;
    // ignore: non_constant_identifier_names
    // Color PrimaryColor = Colors.pink.shade400;
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = Locale(newSelectedLanguageByUser.name);
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.toggleThemeMode,
    required this.selectedLanguageChanged,
  });
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType { photoshop, lightroom, afterEffects, illustrator, adobeXD }

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;

  void uppdateSkill(_SkillType skillType) {
    setState(() {
      _skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          SizedBox(width: 8),
          InkWell(
            onTap: widget.toggleThemeMode,

            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.sun_min),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.userName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 4),
                        Text(
                          localization.userBio,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location,
                              color: Theme.of(
                                context,
                              ).textTheme.titleSmall!.color,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                localization.bio,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Divider(height: 32, thickness: 0.4, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectLanguage),
                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    thumbColor: Theme.of(context).primaryColor,
                    children: {
                      _Language.en: Text(
                        localization.english,
                        style: TextStyle(fontSize: 13),
                      ),
                      _Language.fa: Text(
                        localization.farsi,
                        style: TextStyle(fontSize: 13),
                      ),
                    },
                    onValueChanged: (value) => _updateSelectedLanguage(value!),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(width: 10),
                  Icon(CupertinoIcons.chevron_down, size: 14),
                ],
              ),
            ),

            SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.horizontal,
                children: [
                  Skill(
                    skillName: 'photoshop',
                    skillImagepath: 'assets/images/app_icon_01.png',
                    skillShadow: Colors.blue,
                    isActive: _skill == _SkillType.photoshop,
                    type: _SkillType.photoshop,
                    ontap: () {
                      uppdateSkill(_SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: _SkillType.lightroom,
                    skillName: 'Lightroom',
                    skillImagepath: 'assets/images/app_icon_02.png',
                    skillShadow: Colors.blue,
                    isActive: _skill == _SkillType.lightroom,
                    ontap: () {
                      uppdateSkill(_SkillType.lightroom);
                    },
                  ),
                  Skill(
                    type: _SkillType.afterEffects,
                    skillName: 'After Effects',
                    skillImagepath: 'assets/images/app_icon_03.png',
                    skillShadow: const Color.fromARGB(255, 42, 25, 192),
                    isActive: _skill == _SkillType.afterEffects,
                    ontap: () {
                      uppdateSkill(_SkillType.afterEffects);
                    },
                  ),
                  Skill(
                    type: _SkillType.illustrator,
                    skillName: 'illustrator',
                    skillImagepath: 'assets/images/app_icon_04.png',
                    skillShadow: const Color.fromARGB(255, 228, 113, 5),
                    isActive: _skill == _SkillType.illustrator,
                    ontap: () {
                      uppdateSkill(_SkillType.illustrator);
                    },
                  ),
                  Skill(
                    type: _SkillType.adobeXD,
                    skillName: 'Adobe XD',
                    skillImagepath: 'assets/images/app_icon_05.png',
                    skillShadow: const Color.fromARGB(255, 255, 0, 170),
                    isActive: _skill == _SkillType.adobeXD,
                    ontap: () {
                      uppdateSkill(_SkillType.adobeXD);
                    },
                  ),
                ],
              ),
            ),
            Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.personalInformation,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.password,
                      prefixIcon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.bolt),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  // ignore: library_private_types_in_public_api
  final _SkillType type;
  final String skillName;
  final String skillImagepath;
  final Color skillShadow;
  final bool isActive;
  final Function() ontap;
  const Skill({
    super.key,

    required this.skillName,
    required this.skillImagepath,
    required this.skillShadow,
    required this.isActive,
    // ignore: library_private_types_in_public_api
    required this.type,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final DefultBorderRadius = BorderRadius.circular(15);
    return InkWell(
      borderRadius: DefultBorderRadius,
      onTap: ontap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(15),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      color: skillShadow,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: skillShadow.withOpacity(0.6),
                          blurRadius: 25,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(skillImagepath, width: 45, height: 45),
            ),
            const SizedBox(height: 8),
            Text(skillName, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faprimaryFontFamily = 'Yekan';
  final Brightness brightness;
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color appBarColor;
  final Color dividerColor;
  MyAppThemeConfig.dark()
    : primaryTextColor = Colors.white,
      dividerColor = const Color.fromARGB(136, 88, 88, 88),
      secondaryTextColor = Colors.white70,
      surfaceColor = Color.fromARGB(115, 167, 165, 165),
      backgroundColor = Color.fromARGB(255, 30, 30, 30),
      appBarColor = Colors.black,
      brightness = Brightness.dark;

  MyAppThemeConfig.light()
    : primaryTextColor = Colors.grey.shade900,
      dividerColor = const Color.fromARGB(134, 143, 142, 142),
      // ignore: deprecated_member_use
      secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
      surfaceColor = const Color.fromARGB(133, 172, 170, 170),
      backgroundColor = Color.fromARGB(244, 255, 253, 253),
      appBarColor = const Color.fromARGB(255, 189, 189, 189),
      brightness = Brightness.light;
  ThemeData getTheme(String countryCode) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      dividerColor: dividerColor,
      dividerTheme: DividerThemeData(thickness: 0.4, indent: 16, endIndent: 16),
      appBarTheme: AppBarTheme(backgroundColor: appBarColor, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),

        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: countryCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,

      primaryColor: primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
    TextTheme(
      bodyMedium: TextStyle(fontSize: 13, color: primaryTextColor),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: primaryTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: primaryTextColor,
      ),
      bodySmall: TextStyle(color: primaryTextColor),
    ),
  );
  TextTheme get faPrimaryTextTheme => TextTheme(
    bodyMedium: TextStyle(
      fontSize: 13,
      color: primaryTextColor,
      height: 1.7,
      fontWeight: FontWeight.w500,
      fontFamily: faprimaryFontFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 13,
      height: 1.5,
      fontWeight: FontWeight.bold,
      color: primaryTextColor,
      fontFamily: faprimaryFontFamily,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: primaryTextColor,
      fontFamily: faprimaryFontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: primaryTextColor,
      fontFamily: faprimaryFontFamily,
    ),
    bodySmall: TextStyle(
      color: primaryTextColor,
      fontFamily: faprimaryFontFamily,
    ),
  );
}

enum _Language { en, fa }
