# RxFlow_ReactorKit

# 목표

1. `RxFlow`의 도입을 검토하기 위해 토이 프로젝트를 만들어 검증한다.
2. 프로젝트를 Develop하여 화면의 Depth를 늘린다.
   - 로그인 기능 구현
     1. 로그인 되어있을 시 바로 MainTab으로 이동
     2. 로그인이 안되어있거나, 로그아웃 했을 시 로그인 화면으로 이동

   - Main에서 셀 클릭시 Detail로 이동
   - MainDetail에서 버튼 클릭 시 Middle Tap으로 이동

   - Middle Tap에서 twoDepthFlow버튼 클릭시 Setting에서 Alert를 띄움
   - Middle Tap에서 toDetail버튼 클릭시 MiddleDetailVC Present, Dismiss

   - Setting에서 버튼 클릭시 Alert띄워줌
   - logout버튼 클릭시 로그아웃 후 로그인페이지로 이동

3. Test Code를 작성하여 화면 전환에 관련된 테스트를 한다.
4. 작업 내용을 문서화 한다.

# 블로그

[RxFlow 도입하기 1](https://velog.io/@hansangjin96/RxSwift-RxFlow-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-1)

[RxFlow 도입하기 2](https://velog.io/@hansangjin96/RxSwift-RxFlow-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-2)

[RxFlow 톺아보기 1](https://velog.io/@hansangjin96/RxSwiftRxFlow-%ED%86%BA%EC%95%84%EB%B3%B4%EA%B8%B0-1)

# 구현

<center><img src="https://github.com/hansangjin96/RxFlow_ReactorKit/blob/main/%ED%99%94%EB%A9%B4-%EA%B8%B0%EB%A1%9D-2021-04-14-%EC%98%A4%ED%9B%84-12.47.58.gif" width="50%" height="50%"></center>
