https://coolors.co/palette/6b9080-a4c3b2-cce3de-eaf4f4-f6fff8

-Use debug mode for reload on save, use lightbulb to wrap or extract widgets

# For Android
-Need to enable location permission in the android/app/src/main/AndroidManifest.xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

# Challenges
-Realizing maps integration is very hard, apis can be challenging
-Responsive design for web/mobile. My scaled ui won't work because of different screen resolutions, so I need two seperate ui options depending on if screen size if less than or greater than a certain size
