//
//  FontScratchApp.swift
//  FontScratch
//
//  Created by 강동영 on 10/15/25.
//

import SwiftUI
import DesignSystem

@main
struct FontScratchApp: App {
  
  init() {
    print("✅ Before Regist")
    findPretendard()
    
    // Runtime에 폰트 등록
    DesignSystem.FontManager.registerAllFonts()
    
    // import DesignSystem 주석하고 호출하면 됩니다.
//    FontManager.registerAllFonts()
    
    print("✅ After Regist")
    findPretendard()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

private func findPretendard() {
  var isFound = false
  for family in UIFont.familyNames.sorted() {
    if family.contains("Pretendard") {
      isFound = true
      print("💬 \(family)")
      for name in UIFont.fontNames(forFamilyName: family) {
        print("   • \(name)")
      }
    }
  }
  if !isFound {
    print("not exist Pretendard in Font")
  }
}
