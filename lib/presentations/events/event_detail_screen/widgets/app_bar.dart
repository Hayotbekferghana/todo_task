part of "../event_detail_screen.dart";

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar(this.event);
  final Event event;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      expandedHeight: 248.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    maxRadius: 20.w,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: AppColors.black,
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, EventEditScreen.route(event));
                    },
                    child: SizedBox(
                      width: 44.w,
                      height: 21.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            AppIcons.edit,
                            colorFilter: ColorFilter.mode(
                                AppColors.white, BlendMode.srcIn),
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                event.name,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.17,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppIcons.time,
                    colorFilter:
                        ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${event.firstDate} - ${event.secondDate}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.17,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Visibility(
                visible: event.location.isNotEmpty,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppIcons.location,
                      colorFilter:
                          ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      event.location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
