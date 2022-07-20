part of 'widgets.dart';

Widget BTNExpandedIconWidget({callback, status, icon}) {
  return (Expanded(
    child: GestureDetector(
      onTap: () async {
        await callback();
      },
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: status ? mainColor : Colors.grey),
          child: Icon(
            icon,
            color: Colors.white,
          )),
    ),
  ));
}
