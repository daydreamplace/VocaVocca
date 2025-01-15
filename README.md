# 📝 단어장 iOS 앱 프로젝트 VocaVocca

VocaVocca는 학습 단어장 iOS 앱 입니다.
---
![Frame 1](https://github.com/user-attachments/assets/f1f788a0-95ed-430d-9222-c21194c5959a)

## 목차
1. [프로젝트 소개](#pushpin-프로젝트-소개)
2. [팀 구성](#busts_in_silhouette-팀-구성)
3. [프로젝트 일정](#alarm_clock-프로젝트-일정)
4. [파일구조](#open_file_folder-파일구조)
5. [최소 지원버전](#computer-최소-지원버전)
6. [기술 스택](#hammer_and_wrench-기술-스택)
7. [주요 기능](#sparkles-주요-기능)
8. [설치 및 실행 방법](#inbox_tray-설치-및-실행-방법)

<br><br>

## :pushpin: 프로젝트 소개

한국어, 영어, 중국어, 일본어, 독일어, 스페인어 등 </p>
원하는 단어를 저장하고 학습할 수 있는 단어장 앱 프로젝트입니다.

### 시연영상
![Simulator Screen Recording - iPhone 16 Pro - 2025-01-15 at 20 43 21](https://github.com/user-attachments/assets/1acc3982-d6af-4828-a72c-56bb455c1f65)

- [VocaVocca 프로젝트 대시보드](https://www.notion.so/teamsparta/5-e1738a727feb4137a6cfd23d21c1dc9b)

### 대상 사용자

- 🧐 나만의 단어장이 필요한 사용자
- 🎓 간펴한 단어 학습이 필요한 사용자
- 🔍 단어 검색이 필요한 사용자 

---


## :busts_in_silhouette: 팀 구성
| NickName | 역할       | GitHub                           |
| -------- | -------- | --------------------------------- |
| AJG  | iOS 개발자 | [@AJG](https://github.com/AhnJunGyung) |
| Kkang  | iOS 개발자 | [@Kkang](https://github.com/kangminseoung) |
| Eden | iOS 개발자 | [@Eden](https://github.com/daydreamplace) | 
| MUN   | iOS 개발자 | [@MUN ](https://github.com/name-mun) | 
| 니쥬니  | iOS 개발자  | [@Watson_22](https://github.com/bryjna07) |

---

## :alarm_clock: 프로젝트 일정

- **시작일**: 25/01/07  
- **종료일**: 25/01/15

---

## :open_file_folder: 파일구조

```
📦 VocaVocca
└── 📦 VocaVocca
    ├── 📁 App
    │   ├── 📄 AppDelegate.swift
    │   └── 📄 SceneDelegate.swift
    │
    ├── 📁 Extension
    │   ├── 📄 UIColor+Custom.swift
    │   ├── 📄 UIStackView+ArrangedSubviews.swift
    │   └── 📄 UIView+AddSubviews.swift
    │
    ├── 📁 Model
    │   ├── 📄 CoreDataManager.swift
    │   ├── 📄 Language.swift
    │   ├── 📄 LearningResult.swift
    │   ├── 📄 NetworkManager.swift
    │   ├── 📄 RecordData+CoreDataClass.swift
    │   ├── 📄 RecordData+CoreDataProperties.swift
    │   ├── 📄 TranslationsResponse.swift
    │   ├── 📄 UserDefaultsManager.swift
    │   ├── 📄 VocaBookData+CoreDataClass.swift
    │   ├── 📄 VocaBookData+CoreDataProperties.swift
    │   ├── 📄 VocaData+CoreDataClass.swift
    │   └── 📄 VocaData+CoreDataProperties.swift
    │
    ├── 📁 Resource
    │   ├── 🎨 Assets.xcassets
    │   ├── 📃 Info.plist
    │   └── 🎬 LaunchScreen.storyboard
    │
    ├── 📁 View
    │   ├── 📁 CustomView
    │   │   ├── 📄 CustomButton.swift
    │   │   ├── 📄 CustomCardView.swift
    │   │   ├── 📄 CustomModalView.swift
    │   │   ├── 📄 CustomSelectedOption.swift
    │   │   ├── 📄 CustomTagView.swift
    │   │   └── 📄 CustomTextFieldView.swift
    │   │
    │   ├── 📁 Learning
    │   │   ├── 📄 CoachmarkView.swift
    │   │   ├── 📄 CoachmarkViewController.swift
    │   │   ├── 📄 FlashcardView.swift
    │   │   ├── 📄 FlashcardViewController.swift
    │   │   ├── 📄 LearningResultView.swift
    │   │   ├── 📄 LearningResultViewController.swift
    │   │   ├── 📄 LearningView.swift
    │   │   ├── 📄 LearningViewCell.swift
    │   │   └── 📄 LearningViewController.swift
    │   │
    │   ├── 📁 Record
    │   │   ├── 📄 RecordResultView.swift
    │   │   ├── 📄 RecordResultViewCell.swift
    │   │   ├── 📄 RecordResultViewController.swift
    │   │   ├── 📄 RecordView.swift
    │   │   └── 📄 RecordViewController.swift
    │   │
    │   └── 📁 Voca
    │       ├── 📄 VocaBookModalViewController.swift
    │       ├── 📄 VocaBookSelectCell.swift
    │       ├── 📄 VocaBookSelectView.swift
    │       ├── 📄 VocaBookSelectViewController.swift
    │       ├── 📄 VocaMainTableViewCell.swift
    │       ├── 📄 VocaMainView.swift
    │       ├── 📄 VocaMainViewController.swift
    │       └── 📄 VocaModalViewController.swift
    │
    ├── 📁 ViewModel
    │   ├── 📁 Learning
    │   │   ├── 📄 CoachmarkViewModel.swift
    │   │   ├── 📄 FlashcardViewModel.swift
    │   │   ├── 📄 LearningResultViewModel.swift
    │   │   └── 📄 LearningViewModel.swift
    │   │
    │   ├── 📁 Record
    │   │   ├── 📄 RecordResultViewModel.swift
    │   │   └── 📄 RecordViewModel.swift
    │   │
    │   └── 📁 Voca
    │       ├── 📄 VocaBookModalViewModel.swift
    │       ├── 📄 VocaBookSelectViewModel.swift
    │       ├── 📄 VocaMainViewModel.swift
    │       └── 📄 VocaModalViewModel.swift
    ├── 📄 .gitignore
    ├── 📁 Frameworks
    │   ├── 📦 CoreData
    │   └── 📦 VocaVocca
    └── ⚙️ Config
```

---

## :computer: 최소 지원버전
-  iOS 16

---

## :hammer_and_wrench: 기술 스택

### ReactiveX
- RxSwift
- RxCocoa
- RxGesture

### UI Frameworks
- UIKit
- AutoLayout

### 데이터 처리
- UserDefaults
- CoreData

### API 통신
- URLSession

### 활용 API
- DeepL API

### 📝 Technologies & Tools

<p>
  <!-- Swift -->
  <img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"/>
  <!-- UIKit -->
  <img src="https://img.shields.io/badge/UIKit-2396F3?style=flat-square&logo=apple&logoColor=white"/>
  <!-- CoreData -->
  <img src="https://img.shields.io/badge/CoreData-007AFF?style=flat-square&logo=apple&logoColor=white"/>
  <!-- RxSwift -->
  <img src="https://img.shields.io/badge/RxSwift-B7178C?style=flat-square&logo=reactivex&logoColor=white"/>
  <!-- RxCocoa -->
  <img src="https://img.shields.io/badge/RxCocoa-B7178C?style=flat-square&logo=reactivex&logoColor=white"/>
  <!-- RxGesture -->
  <img src="https://img.shields.io/badge/RxGesture-B7178C?style=flat-square&logo=reactivex&logoColor=white"/>
<p>
  <!-- SnapKit -->
  <img src="https://img.shields.io/badge/SnapKit-0C78FF?style=flat-square&logo=swift&logoColor=white"/>
  <!-- URLSession -->
  <img src="https://img.shields.io/badge/URLSession-1572B6?style=flat-square&logo=swift&logoColor=white"/>
  <!-- UserDefaults -->
  <img src="https://img.shields.io/badge/UserDefaults-808080?style=flat-square&logo=apple&logoColor=white"/>
  <!-- GitHub -->
  <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/>
  <!-- Figma -->
  <img src="https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=figma&logoColor=white"/>
  <!-- Notion -->
  <img src="https://img.shields.io/badge/Notion-000000?style=flat-square&logo=notion&logoColor=white"/>
  <!-- Slack -->
  <img src="https://img.shields.io/badge/Slack-4A154B?style=flat-square&logo=slack&logoColor=white"/>
</p>

---

## :sparkles: 주요 기능

1. **단어장 생성 및 단어 저장**

   6개 국어의 단어장, 원하는 단어를 저장할 수 있습니다.

2. **단어 검색 기능**

   입력한 단어의 뜻을 확인할 수 있습니다.

3. **플래시카드 학습 기능**

   사용자가 만든 단어장의 단어를 가지고 플래시카드 학습을 할 수 있습니다

4. **맞은단어, 틀린단어 확인**

   기록 탭에서 학습한 단어를 확인할 수 있습니다.

---

## :inbox_tray: 설치 및 실행 방법
1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/daydreamplace/VocaVocca.git
```
2. 프로젝트 디렉토리로 이동합니다.
```bash
cd VocaVocca

```
3. Xcode에서 `VocaVocca.xcodeproj` 파일을 엽니다.
