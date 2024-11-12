# taskbbt

##Introduction

This is a pair of Flutter projects for the same application with two different versions.

#Versions: 
Version 1: 1.0.0
Version 2: 2.0.0

##Approach:

The project is divided into two parts: 

1. The first part is getting the current version of the app:
This is implemented with the help of Firebase Remote Config. This version is compared with the version of the app installed on the device every time the app is opened. If the versions are different, the user is prompted to update the app.
   
2. The second part is getting the latest version of the app:
This is is implemented in 3 parts:

a. Hosting the app:
This is accommplished by hosting the app on GitHub Releases [ Since Firebase Storage is no longer free :) ].

b. Downloading the latest version of the app:
This is accomplished by using the help of the dio package.
It downloads the latest version of the app from the GitHub Releases on the ExternalStorageDirectory of my app (which I get by using the help of the path_provider package).

c. Installing the latest version of the app:
This is accomplished by using the help of the open_file package with the same ExternalStorageDirectory as the path.
The user needs to give file access permission to the app to install the latest version of the app.

##How to run the project:

runn the following command in the terminal for version-1:
```
flutter pub get
flutter run
```

It will run the first version of the app which will prompt the user to update the app. After downloading and installing the latest version of the app, the user will be get the second version of the app.

##Tech Stack:
Flutter, Firebase, GitHub