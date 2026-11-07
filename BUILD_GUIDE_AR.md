# دليل فتح وبناء مشروع Quit Now — Windows

## لماذا ظهر لك MainActivity.kt فقط؟

النسخة السابقة `v2.1` كانت حزمة مصدرية أولية ومحدودة، ولذلك لم تكن تحتوي على بقية الشاشات. النسخة الحالية `v2.3` تحتوي على ملفات التطبيق موزعة داخل مجلدات واضحة. كذلك قد تظهر شاشة واحدة فقط إذا فتحت ملف Kotlin منفرداً بدلاً من فتح مشروع Gradle كاملاً.

## 1) فك الضغط وافتح المجلد الصحيح

1. فك ضغط `QuitNow_Android_Project_v2_3.zip` بالكامل.
2. افتح المجلد `QuitNow_Android_Project`.
3. تأكد أنك ترى `settings.gradle.kts` و`build.gradle.kts` و`gradlew.bat`.
4. في Android Studio اختر File ثم Open ثم اختر هذا المجلد الرئيسي.
5. في نافذة الملفات على اليسار اختر العرض **Project** لإظهار الهيكل الكامل.
6. لا تفتح `MainActivity.kt` باعتباره المشروع، ولا تفتح مجلد `app` وحده.

## 2) الملفات التي يجب أن تراها

```text
QuitNow_Android_Project/
├── settings.gradle.kts
├── build.gradle.kts
├── gradle.properties
├── gradlew
├── gradlew.bat
├── gradle/wrapper/
│   ├── gradle-wrapper.jar
│   └── gradle-wrapper.properties
├── app/
│   ├── build.gradle.kts
│   └── src/
│       ├── main/
│       │   ├── AndroidManifest.xml
│       │   ├── java/com/toquitsmoking/quitnow/
│       │   │   ├── MainActivity.kt
│       │   │   ├── QuitNowApp.kt
│       │   │   ├── data/UserPreferences.kt
│       │   │   ├── domain/ProgressCalculator.kt
│       │   │   └── ui/
│       │   │       ├── Palette.kt
│       │   │       └── screens/
│       │   │           ├── OnboardingScreen.kt
│       │   │           ├── HomeScreen.kt
│       │   │           ├── RescueScreen.kt
│       │   │           ├── CoachScreen.kt
│       │   │           ├── InsightsScreen.kt
│       │   │           ├── ProfileScreen.kt
│       │   │           ├── RecoveryScreen.kt
│       │   │           └── HealthTimelineScreen.kt
│       │   └── res/
│       └── test/
└── setup_windows.ps1
```

## 3) المتطلبات

- JDK 21.
- Android SDK Command-line Tools.
- Android SDK Platform 37.
- Android SDK Build Tools 36.0.0.
- اتصال بالإنترنت أول مرة لتنزيل Gradle ومكتبات AndroidX/Compose.

**مهم:** Android SDK الكامل لا يمكن وضعه عملياً داخل ملف ZIP؛ حجمه كبير ويُثبت كحزم رسمية منفصلة من Google. Gradle Wrapper وملفاته موجودة في المشروع وسيقوم بتنزيل Gradle 9.3.1 تلقائياً عند أول تشغيل.

## 4) إعداد SDK

إذا كانت أدوات `sdkmanager` مثبتة ومسموحاً باستخدامها، اضبط متغيري البيئة `JAVA_HOME` و`ANDROID_HOME` ثم افتح PowerShell داخل مجلد المشروع وشغّل:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup_windows.ps1
```

يقوم السكربت بفحص JDK وSDK، ثم يطلب تراخيص Android ويثبت:
- `platform-tools`
- `platforms;android-37`
- `build-tools;36.0.0`

على حاسوب الشركة لا تثبت أدوات أو تغيّر إعدادات النظام دون موافقة IT. يمكن تنفيذ البناء على حاسوب شخصي أو بيئة CI معتمدة بدلاً من ذلك.

## 5) الاختبار والبناء

من جذر المشروع:

```bat
gradlew.bat testDebugUnitTest
gradlew.bat assembleDebug
```

ملف APK التجريبي:
`app\build\outputs\apk\debug\app-debug.apk`

حزمة AAB غير موقعة للنشر بعد إعداد مفتاح الرفع:
`gradlew.bat bundleRelease`

## 6) قبل النشر على Google Play

- راجع آخر `versionCode` في Play Console واجعل رقم المشروع أعلى منه.
- لا تغير `applicationId`: `com.toquitsmoking.quitnow`.
- أنشئ upload key جديداً وسجل شهادة PEM في Play Console بعد التأكد من البناء والاختبارات.
- لا تشارك ملف JKS أو كلمة مروره.
- اختبر على هاتف حقيقي وإصدارات Android مختلفة.

## 7) حدود الوظائف الحالية

المدرب الحالي يعمل محلياً بقواعد مساعدة وليس نموذج ذكاء اصطناعي مولداً. لا توجد مزامنة سحابية أو حسابات أو إشعارات مجدولة في هذه النسخة. إضافة AI حقيقي تتطلب خادماً آمناً ومفتاح API محفوظاً على الخادم، لا داخل التطبيق، مع سياسة خصوصية وحدود استخدام واختبارات سلامة.
