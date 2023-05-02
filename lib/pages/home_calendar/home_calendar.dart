import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:plancation/pages/home_calendar/home_calendar.style.dart';
import '../../components/calendar/calendar.dart';

class HomeCalendarComponent extends StatelessWidget {
  const HomeCalendarComponent({super.key});

  void refresh() {
    print("Refresh!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child:
        Container(
          height: 72,
          child:
          CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            middle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){},
                    iconSize: 36,
                    padding: EdgeInsets.all(0),
                    icon: SvgPicture.asset(
                      'assets/svgs/menu_icon.svg',
                    )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('April', style: containerTitleTextStyle),
                    Text('2023'),
                  ],
                ),
                IconButton(
                  onPressed: (){},
                  iconSize: 36,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        child: Calendar(),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 16
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Logger().d("Add!"),
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary),
        shape: CircleBorder(side: BorderSide(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
