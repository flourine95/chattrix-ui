# Agora SDK ProGuard Rules
# Keep Agora SDK classes
-keep class io.agora.**{*;}
-dontwarn io.agora.**

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Agora RTC Engine
-keep class io.agora.rtc.** { *; }
-keep class io.agora.rtc2.** { *; }

# Keep Agora video and audio processing
-keep class io.agora.base.** { *; }
-keep class io.agora.utils.** { *; }

# Keep WebRTC related classes
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }
