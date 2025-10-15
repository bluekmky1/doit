# Doit Project Constitution

> 프로젝트 아키텍처, 원칙, 컨벤션을 정의하는 헌법 문서

---

## 📋 메타데이터

```yaml
project: Doit
framework: Flutter
architecture: Clean Architecture (3-Layer)
state_management: Riverpod
backend: Supabase
language: Dart
version: 1.0.0
last_updated: 2025-10-15
```

---

## 🎯 프로젝트 개요

할 일 관리와 운세 기반 추천 시스템을 결합한 Flutter 모바일 애플리케이션.
Clean Architecture 원칙을 기반으로 확장 가능하고 테스트 가능한 구조를 지향합니다.

### 핵심 Feature
- 할 일(Todo) 관리 시스템
- 운세(Fortune) 기반 추천
- 농장(Farm) 게임 요소
- 루틴(Routine) 관리
- 사용자 프로필 관리

---

## 🏛️ 아키텍처 원칙

### 1. Clean Architecture
```
┌─────────────────────────────────────┐
│        Presentation Layer           │  ← UI, ViewModel, State
│  (lib/ui/, lib/routes/, lib/theme/) │
└──────────────┬──────────────────────┘
               │ depends on
┌──────────────▼──────────────────────┐
│          Domain Layer               │  ← Model, UseCase
│         (lib/domain/)                │
└──────────────┬──────────────────────┘
               │ depends on
┌──────────────▼──────────────────────┐
│           Data Layer                │  ← Entity, Repository, DataSource
│  (lib/data/, lib/service/)          │
└─────────────────────────────────────┘
```

### 2. 핵심 원칙
- **의존성 역전 원칙**: 상위 레이어는 하위 레이어에만 의존
- **단일 책임 원칙**: 각 클래스/함수는 하나의 책임만 수행
- **명시적 에러 핸들링**: Result 패턴으로 모든 에러 처리
- **불변성**: State는 항상 불변 객체, copyWith로 업데이트
- **의존성 주입**: Riverpod Provider로 모든 의존성 관리

---

## 📁 디렉토리 구조

```
lib/
├── core/                           # 공통 기능 & 유틸리티
│   ├── common/
│   │   ├── data/                  # 공통 Entity (PageableEntity, FileEntity)
│   │   ├── repository/            # RepositoryResult 타입 정의
│   │   └── use_case/              # UseCaseResult 타입 정의
│   └── loading_status.dart        # 로딩 상태 Enum
│
├── data/                           # 데이터 레이어
│   └── {feature}/                 # Feature별 그룹핑 (user, todo, fortune, routine)
│       ├── entity/                # DB → Dart 객체 매핑
│       │   ├── {feature}_entity.dart
│       │   └── generated/         # json_serializable 생성 파일
│       ├── request_body/          # API 요청 DTO
│       │   ├── {action}_request_body.dart
│       │   └── generated/
│       ├── {feature}_remote_data_source.dart  # API 호출 로직
│       └── {feature}_repository.dart          # 데이터 추상화 & 에러 핸들링
│
├── domain/                         # 도메인 레이어
│   └── {feature}/                 # Feature별 그룹핑
│       ├── model/                 # 비즈니스 로직 데이터 모델
│       │   └── {feature}_model.dart
│       └── use_case/              # 비즈니스 유스케이스 (단일 액션)
│           └── {action}_{feature}_use_case.dart
│
├── ui/                             # 프레젠테이션 레이어
│   ├── {feature}/                 # Feature별 화면
│   │   ├── {feature}_view.dart   # UI 렌더링
│   │   ├── {feature}_view_model.dart  # 상태 관리 로직
│   │   ├── {feature}_state.dart  # 상태 객체 정의
│   │   ├── views/                # 복잡한 화면의 서브뷰
│   │   └── widgets/              # Feature 전용 위젯
│   └── common/                    # 공통 UI 요소
│       ├── widgets/               # 재사용 가능한 위젯
│       ├── consts/                # UI 상수 & Enum
│       └── game/                  # 게임 로직
│
├── routes/                         # 라우팅 설정
│   ├── app_router.dart            # GoRouter 설정
│   ├── routes.dart                # 라우트 경로 정의
│   ├── route_info.dart            # 라우트 정보 모델
│   ├── app_router_interceptor.dart  # 인증 가드
│   └── redirect_notifier.dart     # 리다이렉션 로직
│
├── service/                        # 외부 서비스 통합
│   └── supabase/                  # Supabase 클라이언트 관리
│       └── supabase_service.dart
│
├── theme/                          # 디자인 시스템
│   ├── doit_colors.dart           # 색상 팔레트
│   ├── doit_typos.dart            # 타이포그래피
│   └── doit_color_theme.dart      # ThemeExtension
│
├── util/                           # 헬퍼 함수
│   └── date_time_format_helper.dart
│
└── main.dart                       # 앱 진입점
```

---

## 🔄 데이터 흐름

### Request Flow (User Action → API)
```
User Interaction
    ↓
View (UI Event)
    ↓
ViewModel.method()
    ↓
UseCase.call()
    ↓
Repository.method() → RepositoryResult<T>
    ↓
RemoteDataSource.method()
    ↓
Supabase API
```

### Response Flow (API → UI Update)
```
Supabase API Response
    ↓
RemoteDataSource (JSON → Entity)
    ↓
Repository (Entity → RepositoryResult<Entity>)
    ↓
UseCase (Entity → Model, RepositoryResult → UseCaseResult)
    ↓
ViewModel (state = state.copyWith(...))
    ↓
View (UI Rebuild)
```

---

## 📦 레이어별 책임

### 1️⃣ Data Layer (`lib/data/`)

#### Entity
```dart
@JsonSerializable(fieldRename: FieldRename.snake)
class UserDataEntity {
  final String userId;
  final String nickname;
  // ...

  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
    _$UserDataEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataEntityToJson(this);
}
```
- **역할**: API 응답/요청 데이터를 Dart 객체로 매핑
- **규칙**:
  - `@JsonSerializable` 사용, snake_case 자동 변환
  - `generated/` 폴더에 `.g.dart` 파일 생성
  - 필드는 final, 모든 필드 초기화 강제
  - `fromJson`/`toJson` 팩토리 메서드 필수

#### RequestBody
```dart
@JsonSerializable(fieldRename: FieldRename.snake)
class PostUserDataRequestBody {
  final String userId;
  final String nickname;
  // ...

  Map<String, dynamic> toJson() => _$PostUserDataRequestBodyToJson(this);
}
```
- **역할**: API 요청 데이터 직렬화
- **규칙**: Entity와 동일, fromJson은 선택적

#### RemoteDataSource
```dart
class UserRemoteDataSource {
  final SupabaseClient _supabaseClient;

  Future<UserDataEntity> getUserData({required String userId}) async {
    final PostgrestMap data = await _supabaseClient
        .from('user')
        .select()
        .eq('user_id', userId)
        .single();
    return UserDataEntity.fromJson(data);
  }
}
```
- **역할**: 외부 API 호출 캡슐화
- **규칙**:
  - 오직 네트워크 호출만 담당, 에러 핸들링은 Repository에서
  - Entity 타입만 반환
  - Provider로 의존성 주입

#### Repository
```dart
class UserRepository extends Repository {
  final UserRemoteDataSource _userRemoteDataSource;

  Future<RepositoryResult<UserDataEntity>> getUserData({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult(
        data: await _userRemoteDataSource.getUserData(userId: userId),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult(
        error: e,
        messages: ['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } // ... 다른 예외 처리
  }
}
```
- **역할**: 데이터 소스 추상화 & 에러 핸들링
- **규칙**:
  - 모든 예외를 `RepositoryResult<T>`로 변환
  - Entity 타입만 다룸
  - try-catch로 모든 예외 처리
  - 사용자 친화적 에러 메시지 작성

---

### 2️⃣ Domain Layer (`lib/domain/`)

#### Model
```dart
class UserDataModel extends Equatable {
  final String id;
  final String nickname;
  // ...

  const UserDataModel({...});

  UserDataModel copyWith({...}) => UserDataModel(...);

  factory UserDataModel.fromEntity(UserDataEntity entity) =>
    UserDataModel(...);

  @override
  List<Object?> get props => [...];
}
```
- **역할**: 비즈니스 로직에서 사용하는 데이터 구조
- **규칙**:
  - `Equatable` 상속으로 값 비교
  - 모든 필드 final, const 생성자
  - `copyWith` 메서드 필수
  - `fromEntity` 팩토리 메서드로 Entity 변환
  - props 오버라이드로 동등성 비교 필드 정의

#### UseCase
```dart
class GetUserDataUseCase {
  final UserRepository _userRepository;

  GetUserDataUseCase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<UseCaseResult<UserDataModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<UserDataEntity> result =
        await _userRepository.getUserData(userId: userId);

    return switch (result) {
      SuccessRepositoryResult() => SuccessUseCaseResult(
        data: UserDataModel.fromEntity(result.data),
      ),
      FailureRepositoryResult() => FailureUseCaseResult(
        message: result.messages?[0],
      ),
    };
  }
}
```
- **역할**: 단일 비즈니스 로직 캡슐화
- **규칙**:
  - 하나의 UseCase = 하나의 액션
  - `call()` 메서드로 실행
  - Repository 의존, Model 반환
  - `RepositoryResult → UseCaseResult` 변환
  - switch 표현식으로 Result 분기
  - Provider.autoDispose로 자동 메모리 관리

---

### 3️⃣ Presentation Layer (`lib/ui/`)

#### View
```dart
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileState state = ref.watch(profileViewModelProvider);
    final ProfileViewModel viewModel = ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      body: ...,
    );
  }
}
```
- **역할**: UI 렌더링
- **규칙**:
  - `ConsumerWidget` 또는 `ConsumerStatefulWidget` 사용
  - `ref.watch`로 상태 구독, `ref.read`로 ViewModel 접근
  - 비즈니스 로직 없음, 오직 UI 표현만

#### State
```dart
class ProfileState {
  final String userName;
  final Gender gender;
  final LoadingStatus updateProfileLoadingStatus;
  // ...

  const ProfileState({...});

  const ProfileState.init()
    : userName = '',
      gender = Gender.male,
      updateProfileLoadingStatus = LoadingStatus.none,
      // ...

  ProfileState copyWith({...}) => ProfileState(...);
}
```
- **역할**: 화면의 불변 상태 정의
- **규칙**:
  - 모든 필드 final
  - `.init()` 네임드 생성자로 초기 상태
  - `copyWith` 메서드 필수
  - Enum/Model 타입 사용, 원시 타입 최소화

#### ViewModel
```dart
class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({
    required ProfileState state,
    required UpdateUserDataUseCase updateUserDataUseCase,
    required SupabaseClient supabaseClient,
  }) : _updateUserDataUseCase = updateUserDataUseCase,
       _supabaseClient = supabaseClient,
       super(state);

  final UpdateUserDataUseCase _updateUserDataUseCase;
  final SupabaseClient _supabaseClient;

  Future<void> saveProfile() async {
    state = state.copyWith(updateProfileLoadingStatus: LoadingStatus.loading);

    // UseCase 실행
    final UseCaseResult<void> result = await _updateUserDataUseCase(...);

    // 결과에 따른 상태 업데이트
    switch (result) {
      case SuccessUseCaseResult():
        state = state.copyWith(updateProfileLoadingStatus: LoadingStatus.success);
      case FailureUseCaseResult():
        state = state.copyWith(updateProfileLoadingStatus: LoadingStatus.error);
    }
  }

  void changeUserName({required String userName}) {
    state = state.copyWith(userName: userName);
  }
}
```
- **역할**: 상태 관리 & 비즈니스 로직 호출
- **규칙**:
  - `StateNotifier<{Feature}State>` 상속
  - UseCase 의존성 주입
  - 모든 상태 변경은 `state = state.copyWith(...)`
  - 비동기 작업은 LoadingStatus로 상태 추적
  - Public 메서드만 View에서 호출

---

## 🔐 에러 핸들링

### Result 패턴

#### RepositoryResult (Data Layer)
```dart
sealed class RepositoryResult<T> {
  const RepositoryResult();
}

class SuccessRepositoryResult<T> extends RepositoryResult<T> {
  const SuccessRepositoryResult({required this.data});
  final T data;
}

class FailureRepositoryResult<T> extends RepositoryResult<T> {
  const FailureRepositoryResult({this.error, this.messages});
  final Object? error;
  final List<String>? messages;  // 사용자 친화적 메시지
}
```

#### UseCaseResult (Domain Layer)
```dart
sealed class UseCaseResult<T> {
  const UseCaseResult();
}

class SuccessUseCaseResult<T> extends UseCaseResult<T> {
  const SuccessUseCaseResult({required this.data});
  final T data;
}

class FailureUseCaseResult<T> extends UseCaseResult<T> {
  const FailureUseCaseResult({this.error, this.message});
  final Object? error;
  final String? message;  // 단일 메시지
}
```

### 에러 처리 흐름
```
Exception 발생 (Supabase, Network, etc.)
    ↓
Repository: try-catch로 캡처
    ↓
FailureRepositoryResult 생성 (사용자 메시지 포함)
    ↓
UseCase: switch로 분기
    ↓
FailureUseCaseResult 생성
    ↓
ViewModel: switch로 분기
    ↓
State 업데이트 (LoadingStatus.error, 메시지 저장)
    ↓
View: 에러 UI 표시 (SnackBar, Dialog 등)
```

---

## 🎨 상태 관리 (Riverpod)

### Provider 타입별 용도

```dart
// 1. 싱글톤 인스턴스 (Service, DataSource, Repository)
final Provider<UserRepository> userRepositoryProvider = Provider(
  (ref) => UserRepository(ref.watch(userRemoteDataSourceProvider)),
);

// 2. 자동 dispose UseCase
final AutoDisposeProvider<GetUserDataUseCase> getUserDataUseCaseProvider =
  Provider.autoDispose((ref) => GetUserDataUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ));

// 3. 화면별 상태 관리 (ViewModel)
final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
  profileViewModelProvider = StateNotifierProvider.autoDispose(
    (ref) => ProfileViewModel(
      state: const ProfileState.init(),
      updateUserDataUseCase: ref.read(updateUserDataUseCaseProvider),
      supabaseClient: ref.read(supabaseServiceProvider),
    ),
  );
```

### Provider 네이밍 규칙
- **DataSource**: `{feature}RemoteDataSourceProvider`
- **Repository**: `{feature}RepositoryProvider`
- **UseCase**: `{action}{Feature}UseCaseProvider`
- **ViewModel**: `{feature}ViewModelProvider`
- **Service**: `{service}ServiceProvider`

### ref 사용 규칙
- `ref.watch`: 상태 구독 (UI 리빌드)
- `ref.read`: 값 읽기/메서드 호출 (리빌드 없음)
- `ref.listen`: 상태 변경 리스너 (부수 효과)

---

## 🚦 라우팅 (GoRouter)

### 라우트 정의
```dart
// routes.dart
enum Routes {
  home(name: 'home', path: '/'),
  farm(name: 'farm', path: 'farm'),  // nested route
  profile(name: 'profile', path: 'profile'),
  // ...
}
```

### Nested Routes 구조
```
/                      → HomeView
  /farm                → FarmView (홈 하위)
  /fortune             → FortuneView
  /my                  → MyView
    /my/profile        → ProfileView (마이 하위)
    /my/routine        → RoutineView
```

### 라우트 가드
```dart
// app_router_interceptor.dart
FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
  // 인증 체크
  final bool isLoggedIn = _supabaseClient.auth.currentSession != null;

  if (!isLoggedIn && state.matchedLocation != Routes.signIn.path) {
    return Routes.signIn.name;
  }

  // 온보딩 체크
  // ...

  return null;  // 리다이렉트 없음
}
```

### 화면 전환 애니메이션
- **Fade**: 대부분의 화면 전환 (80ms)
- **NoTransition**: 탭 네비게이션 (즉시 전환)

---

## 📝 네이밍 컨벤션

### 파일명
- **View**: `{feature}_view.dart`
- **ViewModel**: `{feature}_view_model.dart`
- **State**: `{feature}_state.dart`
- **Model**: `{feature}_model.dart`
- **Entity**: `{feature}_entity.dart`
- **RequestBody**: `{action}_{feature}_request_body.dart`
- **UseCase**: `{action}_{feature}_use_case.dart`
- **Repository**: `{feature}_repository.dart`
- **DataSource**: `{feature}_remote_data_source.dart`
- **Widget**: `{description}_widget.dart`

### 클래스명
- **PascalCase**: `UserDataModel`, `GetUserDataUseCase`
- **Provider 변수**: camelCase + Provider 접미사

### 변수/메서드명
- **Private**: `_supabaseClient`, `_getUserData()`
- **Public**: `userName`, `saveProfile()`
- **Boolean**: `isLoading`, `hasError`, `canSubmit`
- **콜백**: `onPressed`, `onChanged`, `onSubmit`

### 폴더명
- **소문자**: `user`, `todo`, `fortune`
- **복수형 지양**: `widget` (O), `widgets` (X) - 단, 프로젝트는 widgets 사용 중

---

## ✅ 코드 컨벤션

### Dart 스타일 가이드 준수
```dart
// 1. 타입 명시
final String userName = 'John';
final List<Todo> todos = [];

// 2. 후행 콤마 (trailing comma)
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Title'),
    ),  // ← 콤마
    body: Container(),  // ← 콤마
  );  // ← 콤마
}

// 3. final 우선 사용
final UserRepository repository;  // const 불가능한 경우
const String apiKey = 'abc123';   // 컴파일 타임 상수

// 4. Named parameters for >= 2개 파라미터
void updateUser({
  required String id,
  required String name,
}) { }

// 5. Pattern matching (Dart 3.0+)
return switch (result) {
  SuccessResult() => ...,
  FailureResult() => ...,
};
```

### 주석 규칙
```dart
/// Public API에 대한 문서화 주석
///
/// [userName]은 3-20자여야 합니다.
void setUserName(String userName) { }

// 구현 세부사항 설명
// TODO: 입력 검증 로직 추가 필요
// FIXME: 메모리 누수 가능성
```

### Import 순서
```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. 외부 패키지 (알파벳 순)
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 4. 프로젝트 내부 (상대 경로)
import '../../core/loading_status.dart';
import '../domain/user/model/user_data_model.dart';
```

---

## 🧪 테스트 전략

### 테스트 우선순위
1. **UseCase 테스트**: 비즈니스 로직 검증
2. **Repository 테스트**: 에러 핸들링 검증
3. **ViewModel 테스트**: 상태 변경 로직 검증
4. **Widget 테스트**: UI 인터랙션 검증

### Mock 전략
```dart
// Riverpod overrides 활용
final container = ProviderContainer(
  overrides: [
    userRepositoryProvider.overrideWithValue(MockUserRepository()),
  ],
);
```

---

## 🚀 빌드 & 배포

### 코드 생성
```bash
# json_serializable 실행
flutter pub run build_runner build --delete-conflicting-outputs

# watch 모드 (자동 재생성)
flutter pub run build_runner watch
```

### 환경 변수
```dart
// .env 파일 (gitignore 필수)
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=xxx

// 접근
await dotenv.load();
final String url = dotenv.env['SUPABASE_URL']!;
```

---

## 📚 참고 자료

### 패키지
- **상태 관리**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- **라우팅**: [go_router](https://pub.dev/packages/go_router)
- **백엔드**: [supabase_flutter](https://pub.dev/packages/supabase_flutter)
- **코드 생성**: [json_serializable](https://pub.dev/packages/json_serializable)
- **동등성**: [equatable](https://pub.dev/packages/equatable)

### 아키텍처 레퍼런스
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)

---

## 🔄 변경 이력

| 날짜 | 버전 | 변경사항 |
|------|------|---------|
| 2025-10-15 | 1.0.0 | 초기 Constitution 작성 |

---

## ✨ 개선 로드맵

### 단기 (1-3개월)
- [ ] Repository 인터페이스 분리 (테스트 용이성)
- [ ] Mapper 클래스 도입 (Entity ↔ Model 변환)
- [ ] 커스텀 Exception 타입 정의
- [ ] Unit 테스트 커버리지 80% 달성

### 중기 (3-6개월)
- [ ] Feature 모듈 완전 독립화 (패키지 분리)
- [ ] CI/CD 파이프라인 구축
- [ ] 성능 모니터링 도구 연동
- [ ] Offline-first 아키텍처 도입

### 장기 (6개월+)
- [ ] Multi-platform 지원 (Web, Desktop)
- [ ] Micro-frontend 아키텍처 검토
- [ ] GraphQL 마이그레이션 고려

---

## 📞 연락처

프로젝트 아키텍처 관련 질문은 팀 채널 또는 이슈 트래커를 통해 문의하세요.

---

**Last Updated**: 2025-10-15
**Constitution Version**: 1.0.0
