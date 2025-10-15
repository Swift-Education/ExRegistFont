//
//  FontScratchApp.swift
//  FontScratch
//
//  Created by 강동영 on 10/15/25.
//

import SwiftUI
import DesignSystem
import UIKit
@main
struct FontScratchApp: App {
  
  init() {
    // Runtime에 폰트 등록
    //    DesignSystem.FontManager.registerAllFonts()
    //    UIFont.
    for family in UIFont.familyNames.sorted() {
      if family.contains("Pretendard") {
        print("💬 \(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
          print("   • \(name)")
        }
      } else {
        print("not exist Pretendard in Font")
      }
    }
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
