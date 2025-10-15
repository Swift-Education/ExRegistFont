import Foundation
import SwiftUI

@MainActor
public enum FontManager {
  private static var registeredFonts: Set<String> = []
  
  /// 폰트가 필요할 때마다 자동으로 등록하는 함수
  public static func registerFontIfNeeded(_ fontName: String) {
    // 이미 등록된 폰트는 스킵
    guard !registeredFonts.contains(fontName) else { return }
    
    // Bundle.module에서 폰트 파일 찾기
    guard let fontURL = findFontURL(for: fontName) else {
      print("⚠️ Font file not found for: \(fontName)")
      return
    }
    
    // 폰트 등록
    guard let fontData = NSData(contentsOf: fontURL),
          let provider = CGDataProvider(data: fontData),
          let font = CGFont(provider) else {
      print("⚠️ Failed to create CGFont for: \(fontName)")
      return
    }
    
    var error: Unmanaged<CFError>?
    if CTFontManagerRegisterGraphicsFont(font, &error) {
      registeredFonts.insert(fontName)
      print("✅ Font registered: \(fontName)")
    } else if let error = error?.takeRetainedValue() {
      print("⚠️ Font registration failed for \(fontName): \(error)")
    }
  }
  
  /// Bundle.module에서 폰트 파일 URL 찾기
  private static func findFontURL(for fontName: String) -> URL? {
    let extensions = ["otf", "ttf"]
    
    for ext in extensions {
      if let url = Bundle.module.url(forResource: fontName, withExtension: ext) {
        return url
      }
    }
    
    return nil
  }
  
  /// 모든 Pretendard 폰트를 한번에 등록하는 함수 (옵션)
  public static func registerAllFonts() {
    Pretendard.allCases
      .map { $0.value }
      .forEach {
        registerFontIfNeeded($0)
      }
  }
}

public enum Pretendard: Int, CaseIterable {
  case black = 900
  case extraBold = 800
  case bold = 700
  case semiBold = 600
  case medium = 500
  case regular = 400
  case light = 300
  case extraLight = 200
  case thin = 100
  
  var value: String {
    switch self {
    default:
      return "Pretendard-\(self.displayName)"
    }
  }
  
  private var displayName: String {
    let name = String(describing: self)
    // lowerCamelCase → UpperCamelCase 변환
    return name.prefix(1).uppercased() + name.dropFirst()
  }
}
