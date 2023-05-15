import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryItemPage extends StatefulWidget {
  const DiaryItemPage(
      {super.key,
      required this.diaryData,
      required this.authorName,
      required this.authorImagePath,
      required this.calendarUsersCount});

  final dynamic diaryData, authorName, authorImagePath, calendarUsersCount;

  @override
  _DiaryItemPageState createState() => _DiaryItemPageState();
}

class _DiaryItemPageState extends State<DiaryItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 64,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left_rounded,
                        color: CupertinoColors.white, size: 28),
                  ),
                ),
                Text(
                  DateFormat('yyyy/MM/dd (EEE)')
                      .format(widget.diaryData['postTime'].toDate()),
                  style: const TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 64,
                  child: TextButton(
                      onPressed: null,
                      child: Text(
                        "관리",
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height - 84,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.calendarUsersCount != 1
                      ? SizedBox(
                          width: 36,
                          height: 36,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: widget.authorImagePath.isNotEmpty ||
                                    widget.authorImagePath != null
                                ? Image.network(
                                    widget.authorImagePath.toString(),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover)
                                : Text(
                                    widget.authorName.length < 3
                                        ? widget.authorName
                                        : widget.authorName.substring(0, 3),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                          ),
                        )
                      : const SizedBox(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      widget.diaryData['postTitle'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.inverseSurface),
                    child: Text(
                      DateFormat('hh:mm')
                          .format(widget.diaryData['postTime'].toDate()),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              widget.diaryData['postImagePath'].isNotEmpty
                  ? Image.network(
                      widget.diaryData['postImagePath'],
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                    )
                  : const SizedBox(),
              const SizedBox(height: 24),
              Text(
                widget.diaryData['postContent'],
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
