buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.4")
        classpath("com.google.gms:google-services:4.3.8")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// نقل مجلد build إلى مجلد خارجي (اختياري)
gradle.beforeProject {
    val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get().asFile
    buildDir = File(newBuildDir, project.name)
}

// حذف ملفات build القديمة
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}