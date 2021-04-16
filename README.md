# RxFlow_ReactorKit

<center><img src="https://github.com/hansangjin96/RxFlow_ReactorKit/blob/main/%ED%99%94%EB%A9%B4-%EA%B8%B0%EB%A1%9D-2021-04-14-%EC%98%A4%ED%9B%84-12.47.58.gif" width="50%" height="50%"></center>

# RxFlow와 도입을 결정하게 된 계기

`RxFlow`란 Coordinator패턴을 Rx로 wrapping한 navigation framework이다.

기존 ReactorKit같은 경우 화면 전환에 관련된 로직을 View 혹은 Reactor에서 처리하고 있기 때문에,

화면 로직 분리에 대한 필요성을 느끼고 도입을 검토하게 되었다.

# 목표

1. `RxFlow`의 도입을 검토하기 위해 토이 프로젝트를 만들어 검증한다.
2. 프로젝트를 Develop하여 화면의 Depth를 늘린다.
   - 로그인 여부에 따른 화면 이동
   - 두가지 화면전환을 동시에 처리
   - Alert 표시
3. Test Code를 작성하여 화면 전환에 관련된 테스트를 한다.
4. 작업 내용을 문서화 한다.

# 블로그

[RxFlow 도입하기 1](https://velog.io/@hansangjin96/RxSwift-RxFlow-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-1)

[RxFlow 도입하기 2](https://velog.io/@hansangjin96/RxSwift-RxFlow-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-2)

[RxFlow 톺아보기 1](https://velog.io/@hansangjin96/RxSwiftRxFlow-%ED%86%BA%EC%95%84%EB%B3%B4%EA%B8%B0-1)

# **Requirements**

- Xcode 12.x
- Swift 5.x

# **CocoaPods**

- RxFlow
- ReactorKit
