## [FontScratch/Info.plist](FontScratch/Info.plist)

### info.plist 폰트 작성 규칙
- info.plist는 빌드(컴파일+링킹) 시점에 앱 번들에 포함됩니다.
- info.plist에 `UIAppFonts` 키를 사용하면 **앱 타겟**에 있는 폰트 `리소스`를 등록할 수 있습니다.
- info.plist 에 작성되는 폰트의 이름 값과 리소스 이름이 같아야합니다. 이때 대소문자를 구분합니다.
- lower, Upper 전부 작성하여 주석처리하며 비교 가능합니다.
https://github.com/Swift-Education/ExRegistFont/blob/0de6fafc6a8776db2d34c233ddcad4001f284293/FontScratch/Info.plist#L3-L34

## [Pretendard 열겨형](FontScratch/FontManager.swift)
- Font를 DesignSystem 모듈로 분리하였을 때, App에서 앱 번들을 생성하기 때문에 SPM에서는 info.plist를 사용할 수 없어서 코드로 직접 등록해야합니다.
- 코드로 폰트를 적용할 때도 위에서 설명한 폰트 규칙을 따릅니다.

폰트 규칙을 따르기 위해서는 **두 가지 방법**이 있습니다.
1. `resource`에 추가 된 Font의 이름을 `lowerCamelCase`로 수정
2. Swift 컨벤션에 따라 작성 된 enum case 값을 `resource` 이름에 따라서 `UpperCamelCase`로 수정

- 아래의 코드는 2번을 따라 리소스 원본 이름을 수정하지않고, 코드 레벨에서 `UpperCamelCase`로 변경합니다.

```swift
var value: String {
  switch self { 
  default:
    // AS-IS: case black의 경우
    return "Pretendard-\(self)" // ❌ Font not Founded: Pretendard-black
    // TO-BE: case black의 경우
    return "Pretendard-\(self.displayName)" // ✅ Font Founded: Pretendard-Black
  } 
} 
```

https://github.com/Swift-Education/ExRegistFont/blob/0de6fafc6a8776db2d34c233ddcad4001f284293/FontScratch/FontManager.swift#L67-L90
