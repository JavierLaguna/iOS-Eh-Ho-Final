# 📱 Eh-Ho iOS

[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)

## 📝 Description

Little iOS client for consume `https://mdiscourse.keepcoding.io/` API

> Final iOS Practice for KeepCoding Mobile 10

## 📷 Screenshots

![Splash](/captures/splash.png)
![Login](/captures/login.png)
![Register](/captures/register.png)

![Topics](/captures/topics.png)
![Search Topic](/captures/search_topic.png)
![Create Topic](/captures/create_topic.png)

![Topic Detial](/captures/topic_detail.png)
![Reply Topic](/captures/reply_topic.png)

![Users](/captures/users.png)
![Search User](/captures/search_user.png)
![User Detail](/captures/user_detail.png)

![Categories](/captures/categories.png)
![Settings](/captures/settings.png)

## 🚩 Instructions

//

## 🚧 Application Architecture

[Swift](https://developer.apple.com/swift/) app based on ([MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) + [Coordinators](https://blog.kulman.sk/architecting-ios-apps-coordinators/)) as main architecture.

[URLSession](https://developer.apple.com/documentation/foundation/urlsession) as networking layer.

[Realm](https://realm.io/) for local database.

[GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) as Git methodology.

## ✅ App Features

##### Register

- Register new users

##### Login

- Login for registered users

##### Topics

- Paginated list of recent topic
- Pull to refresh topics
- Search topics
- Create new topic
- Delete topic

##### Posts

- Topic detail with paginated list of posts
- Reply topic using post

##### Users

- List users
- Pull to refresh users
- Search users
- User detail view

##### Categories

- List all categories

##### Settings

- User logout

## 🛠 Work in progress

- Cache user objects on Realm database.
  > Branch ➡️ feature/cacheUsers

## 👨‍💻 Author

> Javier Laguna
