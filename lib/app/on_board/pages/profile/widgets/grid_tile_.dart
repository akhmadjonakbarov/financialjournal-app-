import 'package:flutter/material.dart';

class GridTile_ extends StatelessWidget {
  final String title;
  final String svgPath;
  const GridTile_({
    super.key,
    required this.title,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Image.asset(
                svgPath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFA6ABB5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
