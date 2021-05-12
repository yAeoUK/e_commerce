import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/helper/shared_preferences_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
   Key?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        // overflow: Overflow.visible,
        children: [
           CircleAvatar(
            //backgroundImage: AssetImage('assets/images/Profile Image.png'),
            backgroundImage: NetworkImage(context.read<UserRepositoryBase>().getUser().foldRight(null, (r, previous) => r.image.uri.toString())),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.white),
                ),
                color: const Color(0xFFF5F6F9),
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
