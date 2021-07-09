import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Providers/DarkMode.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const route='/setting';
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 45),
            _ListTile(
              title: 'language',
              icon: Icons.language,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppTheme.black2,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          language.words['language'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        _LanguageButton(
                            label: 'کوردی', code: 'kr', direction: 'rtl'),
                        _LanguageButton(
                            label: 'English', code: 'en', direction: 'ltr'),
                        _LanguageButton(
                            label: 'عربی', code: 'ar', direction: 'rtl')
                      ],
                    ),
                  ),
                );
              },
            ),
            Consumer<DarkThemePreference>(builder: (ctx, mode, _) {
              Provider.of<DarkThemePreference>(context).getTheme();
              print("mode dark:${mode.darkTheme}");
              var val = mode.darkTheme;
              return Switch(
                  value: val,
                  onChanged: (value) {
                    print(value);
                    val = value;
                    Provider.of<DarkThemePreference>(context, listen: false)
                        .setDarkTheme(value);
                  });
            }),
            FlatButton(
                onPressed: () {
                  print(language.languageCode);
                },
                child: Text(language.words['language'])),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function onTap;

  const _ListTile(
      {this.title,
      this.icon,
      this.color = const Color(0xff9E9E9E),
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        'title',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final String code;
  final String direction;

  const _LanguageButton(
      {@required this.label, @required this.code, @required this.direction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      textColor: Colors.black,
      onPressed: () {
        Provider.of<Language>(context, listen: false)
            .setLanguage(code, direction);
        Navigator.of(context).pop();
      },
      child: Text(label, style: Theme.of(context).textTheme.headline4),
    );
  }
}
