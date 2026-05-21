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
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    // final Color surFaceColor = const Color.fromARGB(90, 70, 69, 69);
    // final Color primaryColor = const Color.fromARGB(255, 189, 37, 168);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fa'), // Spanish
      ],
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
        selectedLanguageChanged: (_Language newselectedLanguageByUser) {
          setState(() {
            _locale = newselectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(_Language _langage) selectedLanguageChanged;
  const MyHomePage({
    super.key,
    required this.toggleThemeMode,
    required this.selectedLanguageChanged,
  });
  final Function() toggleThemeMode;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ignore: camel_case_types, constant_identifier_names
enum _skillType { photoshop, AdobeXD, illustrator, afterEffects, Lightroom }

class _MyHomePageState extends State<MyHomePage> {
  _skillType _Skill = _skillType.photoshop;
  _Language _language = _Language.en;
  void updateSelectedSkill(_skillType skillType) {
    setState(() {
      _Skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language Language) {
    widget.selectedLanguageChanged(Language);
    setState(() {
      _language = Language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle, style: textTheme.titleLarge),

        actions: [
          Icon(CupertinoIcons.bell_solid),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: InkWell(
              onTap: widget.toggleThemeMode,
              child: Icon(CupertinoIcons.brightness_solid),
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
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 15),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(localization.userName, style: textTheme.bodyLarge),

                        Text(
                          localization.userBio,
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.location, size: 18),
                            SizedBox(width: 10),
                            Text(
                              localization.location,
                              style: textTheme.titleSmall!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(CupertinoIcons.share_up, color: Colors.pink.shade400),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      localization.postsNumber,
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(localization.posts),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      localization.followersNumber,
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(localization.followers),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      localization.projectsNumber,
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(localization.projects),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 12),
              child: Text(localization.bio, style: textTheme.displaySmall),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(localization.selectLanguage),

                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    thumbColor: Theme.of(context).primaryColor,
                    children: {
                      _Language.en: Text(
                        localization.english,
                        style: textTheme.bodySmall,
                      ),
                      _Language.fa: Text(
                        localization.farsi,
                        style: textTheme.bodySmall,
                      ),
                    },
                    onValueChanged: (value) => _updateSelectedLanguage(value!),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(localization.skills),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.bolt_horizontal_circle_fill,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        skill(
                          skillType: _skillType.photoshop,
                          skillName: 'Photoshop',
                          skillImagePath: 'assets/images/app_icon_01.png',
                          skillShadowColor: const Color.fromARGB(
                            255,
                            5,
                            96,
                            255,
                          ),
                          isActive: _Skill == _skillType.photoshop,
                          onTap: () {
                            updateSelectedSkill(_skillType.photoshop);
                          },
                          textTheme: textTheme,
                        ),
                        skill(
                          skillType: _skillType.photoshop,
                          skillName: 'Photoshop',
                          skillImagePath: 'assets/images/app_icon_02.png',
                          skillShadowColor: const Color.fromARGB(
                            255,
                            5,
                            96,
                            255,
                          ),
                          isActive: _Skill == _skillType.Lightroom,
                          onTap: () {
                            updateSelectedSkill(_skillType.Lightroom);
                          },
                          textTheme: textTheme,
                        ),
                        skill(
                          skillType: _skillType.photoshop,
                          skillName: 'Photoshop',
                          skillImagePath: 'assets/images/app_icon_03.png',
                          skillShadowColor: const Color.fromARGB(
                            255,
                            46,
                            27,
                            129,
                          ),
                          isActive: _Skill == _skillType.afterEffects,
                          onTap: () {
                            updateSelectedSkill(_skillType.afterEffects);
                          },
                          textTheme: textTheme,
                        ),
                        skill(
                          skillType: _skillType.illustrator,
                          skillName: 'Illustrator',
                          skillImagePath: 'assets/images/app_icon_04.png',
                          skillShadowColor: const Color.fromARGB(
                            195,
                            199,
                            100,
                            7,
                          ),
                          isActive: _Skill == _skillType.illustrator,
                          onTap: () {
                            updateSelectedSkill(_skillType.illustrator);
                          },
                          textTheme: textTheme,
                        ),
                        skill(
                          skillType: _skillType.AdobeXD,
                          skillName: 'Adobe XD',
                          skillImagePath: 'assets/images/app_icon_05.png',
                          skillShadowColor: const Color.fromARGB(
                            255,
                            255,
                            0,
                            221,
                          ),
                          isActive: _Skill == _skillType.AdobeXD,
                          onTap: () {
                            updateSelectedSkill(_skillType.AdobeXD);
                          },
                          textTheme: textTheme,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    localization.personalInformation,
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.password,
                      prefixIcon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.bolt),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(localization.devSign, style: textTheme.titleSmall),
                SizedBox(width: 8),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: const Color.fromARGB(255, 0, 117, 250),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class skill extends StatelessWidget {
  // ignore: library_private_types_in_public_api
  final _skillType skillType;
  final String skillName;
  final String skillImagePath;
  final Color skillShadowColor;
  final bool isActive;
  final TextTheme textTheme;
  final Function() onTap;
  const skill({
    super.key,
    required this.textTheme,
    // ignore: library_private_types_in_public_api
    required this.skillType,
    required this.skillName,
    required this.skillImagePath,
    required this.skillShadowColor,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.2),

                // ignore: deprecated_member_use
                borderRadius: BorderRadius.circular(15),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: skillShadowColor.withOpacity(0.8),
                          blurRadius: 10,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(skillImagePath, width: 45, height: 45),
            ),
            SizedBox(height: 8),
            Text(skillName, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontsFamily = "Yekan";
  final Brightness brightness;
  final Color primaryColor = const Color.fromARGB(255, 44, 58, 185);
  final Color AppBarColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  final Color backgroundColor;
  final Color surFaceColor;
  final Color DividerColor;

  MyAppThemeConfig.dark()
    : primaryTextColor = Colors.white,
      secondaryTextColor = Colors.white70,
      AppBarColor = const Color.fromARGB(172, 2, 6, 17),
      backgroundColor = const Color.fromARGB(221, 19, 18, 18),
      brightness = Brightness.dark,
      surFaceColor = const Color.fromARGB(99, 48, 47, 47),
      DividerColor = const Color.fromARGB(255, 93, 94, 95);
  // ignore: non_constant_identifier_names

  MyAppThemeConfig.light()
    : primaryTextColor = Colors.black,
      secondaryTextColor = Colors.black54,
      AppBarColor = const Color.fromARGB(255, 255, 255, 255),
      backgroundColor = const Color.fromARGB(255, 245, 245, 245),
      brightness = Brightness.light,
      surFaceColor = const Color.fromARGB(97, 36, 34, 34),
      DividerColor = Color.fromARGB(2, 20, 20, 20);

  // ignore: non_constant_identifier_names

  ThemeData getTheme(String countryCode) {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      dividerTheme: DividerThemeData(
        color: surFaceColor,
        thickness: 0.8,
        indent: 16,
        endIndent: 16,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      primaryColor: primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surFaceColor,
        focusColor: surFaceColor.withOpacity(0.9),
        floatingLabelStyle: TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.white70),
        iconColor: Colors.white70,
      ),
      textTheme: countryCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppBarColor,
        elevation: 0,
        foregroundColor: secondaryTextColor,
      ),
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
    TextTheme(
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
    ),
  );
  TextTheme get faPrimaryTextTheme => TextTheme(
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: primaryTextColor,
      fontFamily: faPrimaryFontsFamily,
    ),
  );
}

enum _Language { en, fa }
