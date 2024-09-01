# SHINHAN HACKATHON WITH SSAFY (24.08.30 - 24.09.01)
![image](https://github.com/user-attachments/assets/57ade290-7e88-4c06-bef9-1ba85f99c813)


## 프로젝트 소개
**금융 활동 자동화 서비스 신한플로우** - 금융 활동을 자동화하여 일상에 녹아들게 합니다.


![Frame 1094310](https://github.com/user-attachments/assets/3ba0f5f2-89f8-420e-a28a-0bfc32e51a84)



**Flow**는 조건과 액션으로 구성된 기본 단위로, 지정된 조건이 충족되면 설정된 액션이 실행됩니다.

- **조건**: 액션이 실행될 기준으로, 날짜, 시간, 위치 등의 간단한 조건부터 계좌 잔액이나 소비액 등 사용자 정보에 기반한 복잡한 조건까지 설정할 수 있습니다.
- **액션**: 조건이 충족될 때 실행되는 작업으로, 계좌 송금, 잔액 확인, 카드 사용액 확인 등 다양한 액션을 수행할 수 있습니다.

## **팀원 구성**



| 홍권 | 최민주 | 문인규 | 김정현 | 이호준 |
| --- | --- | --- | --- | --- |
| [<img src="https://github.com/gwonhong.png" width="60px;"/><br /><sub><a href="https://github.com/gwonhong">gwonhong</a></sub>](https://github.com/gwonhong/shinhan-flow-service) | [<img src="https://github.com/minjumost.png" width="60px;"/><br /><sub><a href="https://github.com/minjumost">minjumost</a></sub>](https://github.com/gwonhong/shinhan-flow-service) | [<img src="https://github.com/InGyu-Moon.png" width="60px;"/><br /><sub><a href="https://github.com/InGyu-Moon">InGyu-Moon</a></sub>](https://github.com/gwonhong/shinhan-flow-service) | [<img src="https://github.com/invent819.png" width="60px;"/><br /><sub><a href="https://github.com/invent819">invent819</a></sub>](https://github.com/gwonhong/shinhan-flow-service) | [<img src="https://github.com/ghwns82.png" width="60px;"/><br /><sub><a href="https://github.com/ghwns82">ghwns82</a></sub>](https://github.com/gwonhong/shinhan-flow-service) |

## **1. 개발 환경**

- FE: Flutter
- BE: Java, Spring Boot
- VCS: Git, Github
- 협업 툴: Github, Github Issues, Notion
- 배포 환경:
    - FE: 아이폰 앱 로컬 빌드
    - BE: AWS ec2로 배포
- 디자인: [FIgma](https://www.figma.com/design/3uTcNeAh5HcjMUiigHm77N/%EC%8B%B8%ED%94%BC-%EC%8B%A0%ED%95%9C-%ED%95%B4%EC%BB%A4%ED%86%A4)
- [Git Issue, 커밋, 브랜치, PR 라벨 및 컨벤션](https://github.com/shinhan-flow/shinhan-flow-service/wiki/%EC%BB%A4%EB%B0%8B-%EC%BB%A8%EB%B2%A4%EC%85%98)
- [코드 컨벤션](https://github.com/shinhan-flow/shinhan-flow-service/wiki/%EC%BD%94%EB%93%9C-%EC%BB%A8%EB%B2%A4%EC%85%98)

## **2. 빌드 및 실행 방법**

### BE

Spring Boot + gradle을 사용한 프로젝트로 다음의 명령어를 통해 빌드가 가능합니다:

```bash
cd be/ShinhanFlow
./gradlew build
```

이후 빌드 결과물을 다음과 같이 실행하면 됩니다:

```bash
cd build/libs
java -jar shinhanflow-0.0.1-SNAPSHOT.jar
```


### FE

1. android studio 에서 프로젝트를 열고 프로젝트 위치에서 `flutter pub get` 명령어를 통해 라이브러리를 받은 후 `dart run build_runner watch` 를 실행하여 generator 파일을 생성합니다.
2. android simulator 를 실행하여 android studio에 가상 디바이스가 감지 되면 실행 할 수 있습니다.

## **3. 채택한 개발 기술과 브랜치 전략**

### Spring Boot

HTTP RESTful API 서버를 만들기에 적합한 프레임워크. 근 시일 내에 학습할 예정이며 팀원들이 다른 언어에 비해 상대적으로 Java에 대한 숙련도가 높아 선택하게 되었습니다.

### Spring Security

필요한 기초적인 JWT 토큰 인증 기능을 포함하며, 강력한 인증 및 권한 부여 기능을 제공면서도 다양한 설정을 커스터마이징할 수 있어 선택했습니다.

### Flutter

짧은 기간 내에 두 모바일 OS를 위한 앱 출시가 가능한 크로스 플랫폼 프레임워크이며 팀원의 숙련도가 높아 채택하게 되었습니다.

### Github Flow

Github-flow 전략을 기반으로 main 여러 feature 브랜치를 개발에 활용했습니다. 

여기에 develop 브랜치를 추가하여, main 브랜치는 최종적으로 배포하는 용도로 쓰이는 브랜치, develop 브랜치는 그 전까지 모든 feature 브랜치가 분기되고 병합되는 브랜치로 사용했습니다.

## 4. **프로젝트 구조**

<details>
<summary>AI</summary>
  
```text
.
├── back_up
│   ├── example_openai
│   │   ├── ans
│   │   │   ├── ex10_blogging.py_ans1.txt
│   │   │   └── ex10_blogging.py_ans2.txt
│   │   ├── ex1.py
│   │   ├── ex10_blogging.py
│   │   ├── ex2.py
│   │   ├── ex3.py
│   │   ├── ex4.py
│   │   ├── ex5.py
│   │   ├── ex6_multi_persona.py
│   │   ├── ex7_give_thinking_time.py
│   │   ├── ex8_set_format.py
│   │   └── ex9_auto.py
│   ├── model_ver1.py
│   ├── model_ver1_test.py
│   ├── model_ver2.py
│   ├── sample.py
│   ├── test1.py
│   ├── test_answer
│   │   ├── model_ver1.py_20240829_120945.json
│   │   ├── model_ver1.py_20240829_121112.json
│   │   ├── ...
│   │   ├── model_ver1_test.py_20240829_082938_37.json
│   │   └── test.json
│   ├── tmp.py
│   └── tmp2.py
├── chat.py
├── info.json
├── lambda_function.py
├── main.py
├── prompt
│   ├── ver1
│   │   ├── enumerate_actions.json
│   │   ├── enumerate_triggers.json
│   │   ├── explain_flow.json
│   │   ├── set_data_format.json
│   │   └── set_output_format.json
│   └── ver3
│       ├── check_action_value.json
│       ├── check_list.json
│       ├── check_trigger_value.json
│       └── error_rule.json
├── test_case
│   └── 1.txt
├── tmp.py
├── tmp2.py
├── tmp3.py
└── utils.py
```

</details>

<details>

<summary>BE</summary>

```text
.
├── java
│   └── com
│       └── ssafy
│           └── shinhanflow
│               ├── ShinhanFlowApplication.java
│               ├── auth
│               │   ├── controller
│               │   │   └── AuthController.java
│               │   ├── custom
│               │   │   ├── CustomUserDetailService.java
│               │   │   └── CustomUserDetails.java
│               │   ├── dto
│               │   │   ├── LoginSuccessResponseDto.java
│               │   │   └── UserDetailDto.java
│               │   ├── jwt
│               │   │   ├── JWTFilter.java
│               │   │   ├── JWTResponse.java
│               │   │   ├── JWTUtil.java
│               │   │   └── LoginFilter.java
│               │   └── service
│               │       └── AuthService.java
│               ├── config
│               │   ├── AwsConfig.java
│               │   ├── CorsMvcConfig.java
│               │   ├── FirebaseConfig.java
│               │   ├── SecurityConfig.java
│               │   ├── SwaggerConfig.java
│               │   ├── WebClientConfig.java
│               │   └── error
│               │       ├── ErrorCode.java
│               │       ├── ErrorResponse.java
│               │       ├── FinanceApiErrorBody.java
│               │       ├── SuccessResponse.java
│               │       └── exception
│               │           ├── BadRequestException.java
│               │           ├── BusinessBaseException.java
│               │           ├── FinanceApiException.java
│               │           ├── GlobalExceptionHandler.java
│               │           └── NotFoundException.java
│               ├── controller
│               │   ├── ai
│               │   │   └── FlowGeneratorController.java
│               │   ├── finance
│               │   │   ├── CurrentAccountController.java
│               │   │   ├── ExchangeController.java
│               │   │   ├── ExchangeRateController.java
│               │   │   └── FinanceProductController.java
│               │   ├── flow
│               │   │   └── FlowController.java
│               │   └── member
│               │       └── MemberController.java
│               ├── domain
│               │   ├── action
│               │   │   ├── Action.java
│               │   │   ├── BalanceNotificationAction.java
│               │   │   ├── ExchangeAction.java
│               │   │   ├── ExchangeRateNotificationAction.java
│               │   │   ├── TextNotificationAction.java
│               │   │   └── TransferAction.java
│               │   ├── entity
│               │   │   ├── ActionEntity.java
│               │   │   ├── CreditScoreEntity.java
│               │   │   ├── ExchangeRateEntity.java
│               │   │   ├── FlowEntity.java
│               │   │   ├── MemberEntity.java
│               │   │   └── TriggerEntity.java
│               │   └── trigger
│               │       ├── Trigger.java
│               │       ├── account
│               │       │   ├── BalanceTrigger.java
│               │       │   ├── DepositTrigger.java
│               │       │   ├── TransferTrigger.java
│               │       │   └── WithDrawTrigger.java
│               │       ├── date
│               │       │   ├── DayOfMonthTrigger.java
│               │       │   ├── DayOfWeekTrigger.java
│               │       │   ├── MultiDateTrigger.java
│               │       │   ├── PeriodDateTrigger.java
│               │       │   └── SpecificDateTrigger.java
│               │       ├── exchange
│               │       │   └── ExchangeRateTrigger.java
│               │       ├── product
│               │       │   └── InterestRateTrigger.java
│               │       └── time
│               │           └── SpecificTimeTrigger.java
│               ├── dto
│               │   ├── FcmMessageRequestDto.java
│               │   ├── ai
│               │   │   ├── FlowGeneratorLambdaFunctionRequestBodyDto.java
│               │   │   ├── FlowGeneratorLambdaFunctionResponseBodyDto.java
│               │   │   ├── FlowGeneratorRequestDto.java
│               │   │   └── FlowGeneratorResponseDto.java
│               │   ├── finance
│               │   │   ├── FinanceApiRequestDto.java
│               │   │   ├── FinanceApiResponseDto.java
│               │   │   ├── MemberRequestDto.java
│               │   │   ├── MemberResponseDto.java
│               │   │   ├── current
│               │   │   │   ├── CurrentAccountBalanceRequestDto.java
│               │   │   │   ├── CurrentAccountBalanceResponseDto.java
│               │   │   │   ├── ...
│               │   │   │   ├── CurrentAccountWithdrawRequestDto.java
│               │   │   │   └── CurrentAccountWithdrawResponseDto.java
│               │   │   ├── exchange
│               │   │   │   ├── ExchangeRateDto.java
│               │   │   │   ├── ExchangeRateRequestDto.java
│               │   │   │   ├── ...
│               │   │   │   ├── ExchangeRequestDto.java
│               │   │   │   └── ExchangeResponseDto.java
│               │   │   ├── header
│               │   │   │   ├── RequestHeaderDto.java
│               │   │   │   └── ResponseHeaderDto.java
│               │   │   └── product
│               │   │       ├── DepositAndSavingProductsRequestDto.java
│               │   │       ├── DepositAndSavingProductsResponseDto.java
│               │   │       ├── LoanProductsRequestDto.java
│               │   │       └── LoanProductsResponseDto.java
│               │   ├── flow
│               │   │   ├── CreateFlowRequestDto.java
│               │   │   ├── FlowDetailResponseDto.java
│               │   │   └── GetFlowListResponseDto.java
│               │   └── member
│               │       ├── CreditScoreRequestDto.java
│               │       ├── CreditScoreResponseDto.java
│               │       └── SignUpRequestDto.java
│               ├── repository
│               │   ├── ActionRepository.java
│               │   ├── CreditScoreRepository.java
│               │   ├── ExchangeRateRepository.java
│               │   ├── FlowRepository.java
│               │   ├── MemberRepository.java
│               │   └── TriggerRepository.java
│               ├── scheduler
│               │   └── DateScheduler.java
│               ├── service
│               │   ├── ai
│               │   │   ├── FlowGeneratorService.java
│               │   │   └── LocalFlowGeneratorService.java
│               │   ├── finance
│               │   │   ├── CurrentAccountService.java
│               │   │   ├── ExchangeRateService.java
│               │   │   ├── ExchangeService.java
│               │   │   ├── FinanceProductService.java
│               │   │   └── FinanceTriggerService.java
│               │   ├── flow
│               │   │   ├── FinanceActionService.java
│               │   │   └── FlowService.java
│               │   └── member
│               │       └── MemberService.java
│               └── util
│                   ├── FinanceApiFetcher.java
│                   ├── FinanceApiHeaderGenerator.java
│                   ├── FinanceApiService.java
│                   ├── FirebaseCloudMessageService.java
│                   ├── LambdaFunctionInvoker.java
│                   ├── TriggerChecker.java
│                   └── constants
│                       ├── AccountProduct.java
│                       ├── Condition.java
│                       └── Currency.java
└── resources
    ├── application.yml
    └── fcm-sdk.json
```

</details>

<details>

<summary>FE</summary>

```text
.
├── account
│   ├── component
│   │   └── account_card.dart
│   ├── model
│   │   ├── account_balance_model.dart
│   │   ├── account_holder_model.dart
│   │   ├── account_model.dart
│   │   └── account_transaction_history_model.dart
│   ├── param
│   │   └── account_param.dart
│   ├── provider
│   │   ├── account_holder_provider.dart
│   │   ├── account_provider.dart
│   │   ├── account_transaction_history_provider.dart
│   │   ├── account_transfer_provider.dart
│   │   └── widget
│   │       ├── account_transaction_history_form_provider.dart
│   │       └── account_transfer_form_provider.dart
│   ├── repository
│   │   └── account_repository.dart
│   └── view
│       ├── account_transaction_history_screen.dart
│       └── account_transfer_screen.dart
├── action
│   ├── model
│   │   └── enum
│   │       └── action_type.dart
│   ├── param
│   │   ├── action_balance_notification_param.dart
│   │   ├── action_exchange_param.dart
│   │   ├── action_exchange_rate_notification_param.dart
│   │   ├── action_text_notification_param.dart
│   │   └── action_transfer_param.dart
│   ├── provider
│   │   └── widget
│   │       ├── balance_notification_action_form_provider.dart
│   │       ├── exchange_action_form_provider.dart
│   │       ├── exchange_rate_notification_action_form_provider.dart
│   │       ├── notifiacation_category_provider.dart
│   │       ├── text_notification_action_form_provider.dart
│   │       └── transfer_action_form_provider.dart
│   └── view
│       ├── action_exchange_screen.dart
│       ├── action_notification_screen.dart
│       └── action_transfer_screen.dart
├── auth
│   ├── model
│   │   ├── login_model.dart
│   │   └── token_model.dart
│   ├── param
│   │   ├── login_param.dart
│   │   └── sign_up_param.dart
│   ├── provider
│   │   ├── auth_provider.dart
│   │   ├── login_provider.dart
│   │   ├── sign_up_provider.dart
│   │   └── widget
│   │       └── widget
│   │           ├── login_form_provider.dart
│   │           └── sign_up_form_provider.dart
│   ├── repository
│   │   └── auth_repository.dart
│   └── view
│       ├── login_screen.dart
│       └── sign_up_screen.dart
├── common
│   ├── component
│   │   ├── bottom_nav_button.dart
│   │   ├── default_appbar.dart
│   │   ├── default_flashbar.dart
│   │   ├── default_text_button.dart
│   │   ├── drop_down_button.dart
│   │   ├── sliver_pagination_list_view.dart
│   │   ├── table_calendar.dart
│   │   ├── text_input_form.dart
│   │   └── time_picker.dart
│   ├── logger
│   │   └── custom_logger.dart
│   ├── model
│   │   ├── bank_model.dart
│   │   ├── base_form_model.dart
│   │   ├── default_model.dart
│   │   └── entity_enum.dart
│   ├── param
│   │   ├── default_param.dart
│   │   └── pagination_param.dart
│   ├── provider
│   │   ├── pagination_provider.dart
│   │   ├── provider_observer.dart
│   │   ├── router_provider.dart
│   │   ├── secure_storage_provider.dart
│   │   └── widget
│   │       └── select_provider.dart
│   └── repository
│       └── base_pagination_repository.dart
├── dio
│   ├── dio_interceptor.dart
│   └── provider
│       └── dio_provider.dart
├── exchange
│   ├── model
│   │   └── exchange_rate_model.dart
│   ├── provider
│   │   └── exchange_provider.dart
│   └── repository
│       └── exchange_repository.dart
├── flow
│   ├── model
│   │   ├── enum
│   │   │   ├── action_category.dart
│   │   │   ├── trigger_category.dart
│   │   │   └── widget
│   │   │       ├── flow_property.dart
│   │   │       └── trigger_enum.dart
│   │   └── flow_model.dart
│   ├── param
│   │   ├── enum
│   │   │   └── flow_type.dart
│   │   ├── flow_param.dart
│   │   └── trigger
│   │       ├── account
│   │       │   ├── trigger_balance_account_param.dart
│   │       │   ├── trigger_deposit_account_param.dart
│   │       │   ├── trigger_transfer_account_param.dart
│   │       │   └── trigger_withdraw_account_param.dart
│   │       ├── trigger_date_time_param.dart
│   │       ├── trigger_exchange_param.dart
│   │       ├── trigger_param.dart
│   │       └── trigger_product_param.dart
│   ├── provider
│   │   ├── flow_provider.dart
│   │   └── widget
│   │       ├── account_trigger_form_provider.dart
│   │       ├── exchange_trigger_form_provider.dart
│   │       ├── flow_form_provider.dart
│   │       ├── product_trigger_form_provider.dart
│   │       ├── time_form_provider.dart
│   │       └── trigger_category_provider.dart
│   ├── repository
│   │   └── flow_repository.dart
│   └── view
│       ├── flow_detail_screen.dart
│       ├── flow_init_screen.dart
│       └── trigger_category_screen.dart
├── home_screen.dart
├── main.dart
├── member
│   ├── model
│   │   └── member_model.dart
│   ├── provider
│   │   └── member_provider.dart
│   ├── repository
│   │   └── member_repository.dart
│   └── view
│       └── member_info_screen.dart
├── notification
│   ├── param
│   │   └── notification_param.dart
│   └── provider
│       └── notification_provider.dart
├── permission_screen.dart
├── product
│   ├── model
│   │   ├── product_account_model.dart
│   │   ├── product_loan_model.dart
│   │   └── product_saving_model.dart
│   ├── provider
│   │   └── product_provider.dart
│   ├── repository
│   │   └── product_repository.dart
│   └── view
│       └── product_account_screen.dart
├── prompt
│   ├── param
│   │   └── prompt_param.dart
│   ├── provider
│   │   └── prompt_provider.dart
│   └── repository
│       └── prompt_repository.dart
├── splash_screen.dart
├── theme
│   └── text_theme.dart
├── trigger
│   ├── component
│   │   └── trigger_history_component.dart
│   ├── model
│   │   └── enum
│   │       ├── foreign_currency_category.dart
│   │       ├── product_property.dart
│   │       ├── time_category.dart
│   │       └── widget
│   │           └── account_property.dart
│   └── view
│       ├── account_trigger_screen.dart
│       ├── date_trigger_screen.dart
│       ├── exchange_trigger_screen.dart
│       ├── product_trigger_screen.dart
│       └── time_trigger_screen.dart
└── util
    ├── reg_exp_util.dart
    ├── text_form_formatter.dart
    └── util.dart
```

</details>

## 5. **역할 분담**

| **이름** | **구분** | **역할 및 수행업무** |
| --- | --- | --- |
| 홍권 | 팀장 | 서버 금융망 api 호출 서비스 구현 및 ai 서비스 배포 |
| 문인규 | 팀원 | 서버 인증 및 인가, 비즈니스 로직 구현, 금융망 api 연결 |
| 김정현 | 팀원 | UI/UX 디자인 및 앱 개발 |
| 최민주 | 팀원 | 서버 메인 비즈니스 로직(플로우) 개발 |
| 이호준 | 팀원 | AI 프롬프트 개발 |

## **6. 개발 기간 및 작업 관리**

### 개발 기간

기획: 7월 17일 ~ 8월 1일

예선 결과 발표: 8월 12일

개발: 8월 14일 ~ 8월 29일

해커톤: 8월 30일 ~ 9월 1일

### **작업 관리**

- GitHub Issues와 노션을 사용하여 진행 상황을 공유했습니다.
- 매일 회의를 진행하며 각 팀원의 진행 상황과 문제점들을 공유하고 해결책을 논의했습니다.
- 3일에 한 번씩 스프린트 회의를 진행하며 주어진 목표와 일정에 대한 진행 상황을 점검하고, 필요시 우선순위를 재조정했습니다.
- 이를 통해 팀원 간의 협업과 커뮤니케이션을 강화하고, 프로젝트의 일관된 흐름을 유지할 수 있었습니다.

## **7. 신경 쓴 부분 및** 트러블 슈팅

### Trigger와 Action interface 구현

메인 로직의 Trigger와 Action 클래스를 어떻게 구현할지에 대해 많은 고민이 있었습니다. Flow가 실행되려면 해당 Flow의 모든 Trigger를 확인해야 하는데, 처음에는 여러 조건문을 반복적으로 사용하는 방식으로 해결하려 했습니다. 

하지만 각 Trigger 클래스마다 조건을 확인하는 메서드가 다르고, 새로운 조건이 추가될 경우 유지 보수가 어려워지고 코드의 가독성도 떨어졌습니다.

이 문제를 해결하기 위해, 모든 Trigger와 Action을 인터페이스로 선언하고 각각의 인터페이스에 isTriggered와 execute라는 추상 메서드를 추가했습니다. 이를 통해 각 Trigger와 Action이 해당 인터페이스를 구현하도록 설계하여, 확장성과 가독성을 높일 수 있었습니다.

### 제네릭을 사용해 금융망 API 호출 함수 구현 및 중복 코드 제거

우리가 사용할 금융망 API가 한 두가지가 아니었는데, 각 함수마다 fetch 함수를 중복하여 작성하는 것이 다양한 에러 핸들링 및 추후 확장성에 있어 매우 좋지 않다고 느껴져 이를 공통 함수로 빼서 구현하고자 했습니다.
하지만 문제는, fetch 함수가 대상이 되는 api에 따라 받아야하는 RequestDto 및 반환해야하는 ResponseDto 타입이 다르다는 점에 있었습니다.

이에 Java의 Generic 및 reflection을 활용해 fetch 함수를 구현했습니다. 인자가 되는 Dto는 `FinanceApiRequestDto`라는 최상위 클래스를 상속받은 것만 허용하도록 `<T extends FinanceApiRequestDto>`와 같이 작성을 하였고, 추가로 이에 쌍이 되는 `~ResponseDto`의 class를 인자로 넘기도록 하여 금융망 api의 response를 적절히 parsing할 수 있도록 하였습니다.
이를 통해 추후 다양한 곳에서 손쉽게 금융망 api 호출을 할 수 있었습니다.

### JSON 역직렬화 시 동적으로 구현 클래스에 할당

모든 Trigger와 Action은 추상 인터페이스를 구현하도록 설계 하였습니다. 각 구현 클래스가 가지고 있는 데이터의 형태가 모두 달라서 하나하나 파싱하는것은 매우 좋지 않은 코드라고 생각했습니다. 그래서 JsonTypeInfo와 JsonSubTypes 어노테이션을 활용하여 추상 클래스를 통해 동적으로 구현클래스를 얻을 수 있도록 코드를 구현하였습니다. 이를 사용함으로서 새로운 클래스가 추가되더라도 코드 한줄만 추가하면 되며, 확장에 열려있는 코드가 될 수 있었습니다. 

### 서버 부하 최소화

메인 서버의 부하를 최소화하기 위해 금융망 API에 요청하는 데이터를 먼저 서비스 데이터베이스에 저장하고, 일정 기간 후 업데이트가 필요한 경우에만 금융망 API에 요청하여 데이터베이스를 갱신하도록 했습니다. 이를 통해 서버 부하를 최소화하고 효율성을 높이고자 했습니다.

환율 정보의 경우, 금융망 API 서버에서 10분마다 최신화되므로, 자체 데이터베이스에 해당 정보를 저장해 두고 10분마다 한 번씩 API 요청을 보내 최신 데이터를 반영했습니다.

### 성능 향상을 위한 CoT 기법 활용

**Chain of Thought (CoT)** 기법은 2022년 1월 구글 리서치 팀이 발표한 "Chain-of-Thought Prompting Elicits Reasoning in Large Language Models" 논문에서 제안된 방법입니다. 이 기법은 문제 해결 과정을 작은 단계로 나누어 순서대로 생각을 전개함으로써 최종 답을 도출하는 방식입니다. 이를 통해, 사용자의 복잡한 요청을 단계별로 분석하여 어떤 조건을 처리해야 하는지, 필요한 액션이 무엇인지, 그리고 어떤 경우에는 수행할 수 없는지 등을 판단할 수 있게 하였습니다.

### 성능 향상과 효율성을 고려한 SC기법 활용

생성형 AI는 확률적으로 결과를 생성하여 오류가 발생할 수 있습니다. 이를 보완하기 위해 **Self-Consistency (SC)** 기법을 도입했습니다. 이 기법은 2022년 3월에 발표된 "Self-Consistency Improves Chain of Thought Reasoning in Language Models" 논문에서 소개되었습니다. SC 기법은 동일한 CoT 프로세스를 여러 번 수행한 후, 가장 많이 나온 답을 최종 결과로 채택하는 방식입니다.  SC를 수행할때 CoT의 시행 횟수를 5회로 설정했습니다. 시행 횟수를 5회로 정한 이유는 정확도와 효율성의 균형을 맞추기 위함입니다. 간단한 테스트 케이스들을 테스트한 결과, 정확도가 약 80%임을 확인했습니다. 목표 정확도를 95%로 설정했는데, 베르누이의 이항분포 확률 공식을 사용해 필요한 시행 횟수를 계산해본 결과, 5회가 적절하다는 결론을 내렸습니다.더 많은 시행 횟수는 더 높은 정확도를 보장하지만, 계산 비용과 처리 시간이 비례해서 증가하기 때문에 시스템의 성능과 자원 활용 측면에서 최적화된 횟수를 계산하여 정했습니다.

### 보안 강화 방안

생성형 AI 사용 시 발생할 수 있는 **보안 이슈**를 해결하기 위해, 몇 가지 전략을 적용했습니다. 먼저, 데이터의 형식과 값을 검증하고 필터링하는 절차를 도입했으며, 출력 형식을 제한하여 예상치 못한 결과를 방지했습니다. 또한, 프롬프트 탈취와 같은 보안 위협에 대비하기 위해 프롬프트에 학습되는 기록을 주기적으로 초기화하고, 사용자별로 별도의 체인을 구성하여 타인의 로그 탈취 행위를 방어할 수 있도록 설계했습니다.

### 사용자의 요구를 파악하기 위한  Discriminator와 Generator

사용자가 제시하는 난해한 요청을 AI가 효과적으로 이해하고 처리하기 어려운 문제가 있습니다. 사용자들은 종종 모호하거나 복잡한 요구를 하게 되는데, 일반적인 AI 시스템은 이러한 요청을 정확히 파악하지 못해 원하는 결과를 제공하지 못하는 경우가 많습니다. 이 문제를 해결하기 위해, GAN(Generative Adversarial Network)의 Generator와 Discriminator 구조를 차용하여 사용자의 요구를 파악하고 해석하는 역할을 부여했습니다. Generator는 사용자의 난해한 요청을 앱이 이해할 수 있는 명확한 형태로 변환하는 작업을 수행하며, Discriminator는 이 변환된 요청이 실제 의도에 부합하는지를 검증합니다. 이를 통해 AI가 사용자 요청의 의미를 점점 더 정확하게 이해하도록 학습됩니다. 이 접근법을 통해 AI는 사용자의 복잡한 요구를 더 잘 파악하고, 앱에 적합하게 해석할 수 있는 능력을 갖추게 됩니다. 결과적으로, 사용자가 어떤 요구를 제시하더라도 AI가 이를 명확하게 이해하고, 적절하게 대응할 수 있도록 했습니다.

## 8. 페이지 별 기능
 <p> <strong>1. 메인화면</strong></p><p>메인화면에서는 사용자의 계좌와 현재 금융 관련 정보, 마지막으로 사용자가 생성한 플로우 리스트를 한 눈에 확인할 수 있으며, 해당 화면에서 토글을 통해 플로우를 활성화하거나 비활성화 상태로 변경할 수 있습니다.</p>
 <img src="https://github.com/user-attachments/assets/0a1c7bca-2a76-455d-92f6-cb6c41c62080" alt="Main Screen" width="300" height="600"/>
<img src="https://github.com/user-attachments/assets/66e544a5-e782-40d1-b51a-4853053e2ed8" alt="플로우 생성 폼1" width="300" height="600"/>
<img src="https://github.com/user-attachments/assets/345f1c39-8661-4ed2-bf5c-997cfd6b8b0e" alt="플로우 생성 폼2" width="300" height="600"/>
    <img src="https://github.com/user-attachments/assets/7bc0f3f2-c82f-4262-9cb7-7acd32995f03" alt="플로우 생성 타이틀, 설명" width="300" height="600"/>
     <img src="https://github.com/user-attachments/assets/ff614ce9-e07c-48e7-9884-1e85796af065" alt="플로우 액션 목록" width="300" height="600"/>
 <img src="https://github.com/user-attachments/assets/1fa77dc3-6cda-4db0-8c7c-0412ee827ff7" alt="송금 행동" width="300" height="600"/>
 
 <img src="https://github.com/user-attachments/assets/a8fbbbce-0717-4133-a5ed-32ee71f6e58e" alt="알림 행동" width="300" height="600"/>
 <img src="https://github.com/user-attachments/assets/e8f59fcd-b299-437b-92f5-d23fa8dde613" alt="계좌 조건" width="300" height="600"/>



## 9. 개선목표

### 유효성 검증

사용자가 입력하는 다양한 조건 각각 들에 대한 유효성 검증은 구현했으나, 조건 중 함께 쓰이면 의미가 불분명해지는 조건들이 존재합니다. 이를 명확히 정의하고 구현하여 사용자들의 불편함을 덜도록 하고자 합니다.

### AI 서버 배포

OpenAI API를 활용해 사용자의 응답으로 Flow를 생성하는 서비스를 구현완료했으나, 이를 배포하여 서버와 통신하게 만드는 것에 실패하였습니다. 이를 성공적으로 배포하고 어플리케이션을 통해 호출할 수 있도록 하게 만들어 사용자 경험을 높히고자 합니다.

### 폐쇄형 AI 모델을 이용한 데이터 보호

ChatGPT와 같은 공개형 AI 모델에 민감한 데이터를 입력할 경우 발생할 수 있는 보안적 이슈를 해결하기 위해, 폐쇄형 AI 모델을 사용하여 서비스를 제공하고자 합니다. 이를 통해 개인정보 등의 민감한 데이터가 외부에 노출되지 않도록 보호하면서, 보다 안전한 환경에서 AI 서비스를 제공할 수 있도록 개선하고자 합니다.
