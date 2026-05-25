# Project-specific ProGuard/R8 rules.
# Keep this file minimal unless you hit release-only crashes.

# Keep Flutter embedding and plugin registrant classes.
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# Keep line numbers for easier crash debugging.
-keepattributes SourceFile,LineNumberTable

# Optional WebView JS interface support.
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Flutter may reference Play deferred-component task types even when
# deferred components are not used in this app.
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
