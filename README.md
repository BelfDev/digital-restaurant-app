<h1 align="center">
  <img width="200" src=".github/logo.jpg">
  <br>
  <br>
  [COVID-19] Digital Restaurant
  <br>
</h1>

<p align="middle">
  <img src=".github/ios_app_preview.jpg" height="560" hspace="24" />
  <img src=".github/android_app_preview.jpg" height="560" />
</p>

## Summary

The purpose of this research project was to devise a cross-platform mobile application that reimagined the eating out experience in view of the disruptions caused by the COVID-19 pandemic. The resulting product sought to maximise convenience and, at the same time, facilitate compliance with safety measures imposed by governments around the world. By adopting "Le Serveur", users were able to explore restaurant options, check-in at selected outlets, pick their favourite dishes from food menus, place orders, and express check-out at their preferred time.

## Running the project

Read the instructions below carefully to run the project on your local machine. Please keep in mind that the "Le Serveur" system also encompasses a [backend application](https://github.com/BelfDev/digital-restaurant-api), which must be running locally for the product to work as expected.

### Pre-requisites

| Technology | Minimum Version | Instalation Guide |
|----------------|-----------------|-----------------------------|
|**Flutter** |`v.1.20.3` |[Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
|**Dart** |`v.2.9.2`| *Installed automatically with Flutter* |
|**Git** |`v2.0.0`| [Git Docs](https://git-scm.com/downloads) |
<br>

> Flutter relies on a full installation of Android Studio to supply its Android platform dependencies. However, you can write your Flutter apps in a number of editors.

[Flutter Official Docs](https://flutter.dev/docs/get-started/install) will guide you through configuring your preferred IDE or Code Editor. For this project, the author recommends [Android Studio](https://developer.android.com/studio).

### Step-by-step

Once you have installed all the pre-requisites, please follow the steps below to run the frontend mobile application. You will need to issue a number of commands via your system's Terminal window.

<p align="middle">
<img height="200" src=".github/terminal.png">
</p>

1. **Clone the current repository to a local directory in your machine.**
     - *Copying the repository URL*<br>
    <img width="200" src=".github/clone_github.png"><br>
     - *Navigating to the root directory*<br>
    ```cd ~```<br>
     - *Cloning this repository into the root directory*<br>
    ```git clone https://github.com/BelfDev/digital-restaurant-app.git```<br>
     - *Stepping into the project's directory*<br>
    ```cd digital-restaurant-app```

2. **Open your favorite IDE (e.g. Android Studio).**
3. **Open the project using your favorite IDE.**
     - *Opening a the project using Android Studio*<br>
     ```File > Open > ~/digital-restaurant-app```
4. **Install all project dependencies.** -- *go back to your Terminal window.*
     - *Installing dependencies declared in `pubspec.yaml`*<br>
     ```flutter packages get```
5. **Open the Android or iOS Simulator.**
     - *You cannot open the iOS simulator if you are not using a MacOS machine*<br>
     - *Opening the iOS simulator via Android Studio*<br>
     <img width="200" src=".github/opening_simulator.png"><br>


2. Clone this repo to somewhere in your machine (Let's say... `myProjectFolder`)
3. Go to you `myProjectFolder`, then go to the challenge's folder
```bash
cd digital-restaurant-app
````
4. Run the project!
```bash
flutter run
```

(README WIP)
