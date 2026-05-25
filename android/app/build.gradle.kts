import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.shubham.seven"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
    // ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.shubham.seven"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = 2
        versionName = "1.0.1"
    }

    signingConfigs {
    create("release") {
        keyAlias = keystoreProperties["keyAlias"]?.toString() ?: ""
        keyPassword = keystoreProperties["keyPassword"]?.toString() ?: ""
        storeFile = file(keystoreProperties["storeFile"] ?: error("storeFile not found in key.properties"))
        storePassword = keystoreProperties["storePassword"]?.toString() ?: ""
        println("KEY ALIAS: ${keystoreProperties["keyAlias"]}")
    }
}

    buildTypes {
        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
        release {
                signingConfig = signingConfigs.getByName("release")
                isMinifyEnabled = true
                isShrinkResources = true
                proguardFiles(
                    getDefaultProguardFile("proguard-android-optimize.txt"),
                    "proguard-rules.pro"
                )
        }
    }
}

dependencies {
    // Required for deferred component splitinstall classes referenced by Flutter/R8.
    implementation("com.google.android.play:feature-delivery:2.1.0")
    implementation("com.google.android.play:app-update:2.1.0")      // for in-app updates
    implementation("com.google.android.play:review:2.0.1")  
}

flutter {
    source = "../.."
}
