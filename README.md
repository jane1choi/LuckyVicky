<img width=900px src="https://github.com/user-attachments/assets/07c67a4d-8e1b-4bf9-a042-0cf81a4897e8"> 

<p></p>

> **초긍정의 힘! 긍정적 사고를 위한 사고 변환기 - 럭키비키**
>   
> 팀 정보 : 개인 프로젝트   
> 프로젝트 기간 : 2024.07.12 ~  
> 앱스토어 출시 : 2024.08.18

### 🔽 앱스토어 바로가기 

[<img width=200px src=https://user-images.githubusercontent.com/42789819/115149387-d42e1980-a09e-11eb-88e3-94ca9b5b604b.png>](https://apps.apple.com/kr/app/%EB%9F%AD%ED%82%A4%EB%B9%84%ED%82%A4-%EA%B8%B0%EB%B6%84-%EC%A2%8B%EC%9D%80-%EC%98%A4%EB%8A%98%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%82%AC%EA%B3%A0-%EB%B3%80%ED%99%98%EA%B8%B0/id6590637266)

## 🍀 서비스 소개
OpenAI를 활용하여 부정적 상황이나 말을 긍정적으로 바꿔주는 서비스입니다.

원하는 인물을 선택하고, 힘든 일이나 상황을 입력하면 해당 인물의 사고방식으로 바꿔드려요!

초긍정적으로 생각할 수 있는 방법을 확인하고, 마음에 드는 답변은 사진으로 저장할 수 있어요!

럭키비키와 함께라면 초긍정의 힘으로 어떤 상황이든 이겨낼 수 있습니다🍀🍀 

## 🍀 주요 기능
| <img width=260px src="https://github.com/user-attachments/assets/c1f4da32-f678-4aad-84bd-37031007dc96"> | <img width=260px src="https://github.com/user-attachments/assets/12fd68dd-bf41-4d47-9730-eb9b8987ddd2"> | <img width=260px src="https://github.com/user-attachments/assets/090c9843-1825-4e5d-9267-9a7cdbc1438e"> |
| :-------------: | :----------: |  :----------: |
| 인물 선택하기 | 고민 입력하기 | 결과 확인 및 저장하기 |

## 🍀 개발 환경
<p align="left">
<img src ="https://img.shields.io/badge/Swift-5.9-ff69b4">
<img src ="https://img.shields.io/badge/Xcode-15.2-blue">
<img src ="https://img.shields.io/badge/iOS-16.0+-orange">
<br>
  
## 🍀 Framework/Architecture
- SwiftUI
- Combine
- SPM
- MVVM + Clean Architecture
![architecture](https://github.com/user-attachments/assets/62d48588-e33d-4f11-9b39-d9b440c02b7f)

> **Clean Architecture**
> 
- Data Layer : DB로부터 데이터를 가져오는 책임을 갖습니다. Repository, API(Network)를 갖습니다.
- Domain Layer : 앱의 비즈니스 로직을 담당합니다. UseCase, Entity, Repository Protocol을 갖습니다.
- Presentaion Layer : UI 로직 관련 책임을 갖습니다. MVVM 패턴을 활용했습니다.

> **Coordinator Pattern**
> 
- 화면 전환을 담당하는 객체입니다.
- 화면 간 의존성을 줄이고 화면 이동을 할 수 있게 돕습니다.
- 뷰 재사용성을 높일 수 있습니다.
- 화면 전환 로직이 복잡하지 않아 MainCoordinator 만을 사용했습니다.

> **MVVM + Combine**
> 
- Presentation, Domain, Data 전반의 비동기 처리를 Combine을 이용해 하였습니다.
- ViewModel 에서 바뀌는 데이터에 따라 View가 변경되도록 Reactive Programming 을 구현하였습니다.

## 🍀 외부 라이브러리
| 라이브러리(Library) | 사용목적(Purpose) |
|:---|:----------|
| Swinject| DI |
| Moya / CombineMoya | Network |
| FirebaseAuth | 애플 소셜 로그인 |
| FirebaseDatabase | DB |
| fastlane | CD |

## 🔫 기술적 도전 & 문제 해결 기록
- [UseCase 해결기](https://janechoi.tistory.com/87)   
- [에러처리 잘못해서 DB 날린 썰](https://janechoi.tistory.com/88)   
- [fastlane을 이용해 배포 자동화하기](https://janechoi.tistory.com/89)   






