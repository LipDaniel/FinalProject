import 'package:flutter/material.dart';
import 'package:projectsem4/constraint.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text('Cài đặt',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: AppConstraint.mainColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/image/avatar.jpeg',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Lipdaniel',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text('iaoht.dev@gmail.com', style: TextStyle(color: AppConstraint.colorSlogan),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              _item(
                title: 'Tài khoản',
                data: Column(
                  children: [
                    __itemSetting(
                        onTap: () {},
                        title: 'Thông tin cá nhân',
                        subTitle: 'Chỉ sửa thông tin tài khoản của bạn',
                        icon: const Icon(Icons.supervised_user_circle)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'Face ID / Touch ID',
                        subTitle: 'Quản lý cách đăng nhập của bạn',
                        icon: const Icon(Icons.lock)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                      title: 'Xác thực hai lớp',
                      subTitle:
                          'Bảo mật thêm tài khoản của bạn để đảm bảo an toàn',
                      icon: const Icon(Icons.verified_user),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                      title: 'Nâng cấp tài khoản',
                      subTitle: 'Nâng cấp tài khoản để thêm nhiều ưu đãi',
                      icon: const Icon(Icons.airplane_ticket),
                    ),
                  ],
                ),
              ),
              _item(
                title: 'Hệ thống',
                data: Column(
                  children: [
                    __itemSetting(
                      title: 'Hỗ trợ & Báo cáo',
                      subTitle: 'Chỉ sửa thông tin tài khoản của bạn',
                      icon: const Icon(Icons.support_agent),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'Về chúng tôi',
                        subTitle: 'Quản lý cách đăng nhập của bạn',
                        icon: const Icon(Icons.info)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'Đăng xuất',
                        subTitle: 'Đăng xuất tài khoản của bạn',
                        icon: const Icon(Icons.logout),
                        onTap: () {},
                        suffix: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _item({required String title, required Widget data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 0.1,
                      offset: const Offset(3, 8),
                      color: Colors.grey.withOpacity(0.3))
                ],
                borderRadius: BorderRadius.circular(10)),
            child: data),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget __itemSetting(
      {required String title,
      required String subTitle,
      required Icon icon,
      Function()? onTap,
      Widget? suffix}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppConstraint.mainColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: icon),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        subTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          suffix ??
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              )
        ],
      ),
    );
  }
}
