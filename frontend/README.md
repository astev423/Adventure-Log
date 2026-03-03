https://coolors.co/palette/6b9080-a4c3b2-cce3de-eaf4f4-f6fff8

-Use debug mode for reload on save, use lightbulb to wrap or extract widgets
-Trying to make UI for both android and web is taking too long, focus on just web and important features,
try getting it to work on android near end instead
-Use scrollview for overflow so it works on mobile

# For Android
-Need to enable location permission in the android/app/src/main/AndroidManifest.xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

# Challenges
-Realizing maps integration is very hard, apis can be challenging
-Responsive design for web/mobile. My scaled ui won't work because of different screen resolutions, so I need two seperate ui options depending on if screen size if less than or greater than a certain size
-Using SQLModel to reduce needing seperate model for API and separate model for db table. This avoids some boilerplate but what if I only want to get certain info and not everything in db table? Then this breaks  down. Overall I think it is better to just write two separate models as it provides much more flexibility


