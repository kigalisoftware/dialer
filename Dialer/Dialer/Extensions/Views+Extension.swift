//
//  Views+Extension.swift
//  Dialer
//
//  Created by Cédric Bahirwe on 06/06/2021.
//

import SwiftUI

struct MTNDisabling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disabled(CTCarrierDetector.shared.cellularProvider().status == false)
    }
}

struct BiometricsAccessibility: ViewModifier {
    private let biometrics = BiometricsAuth.shared
    var onEvaluation: (Bool) -> Void
    @AppStorage(UserDefaults.Keys.allowBiometrics)
    private var allowBiometrics = false
    
    func body(content: Content) -> some View {
        content
            .onTapGesture(perform: manageBiometrics)
    }
    
    private func manageBiometrics() {
        if allowBiometrics {
            biometrics.onStateChanged(onEvaluation)
        } else {
            onEvaluation(true)
        }
    }
}
#if DEBUG
struct LanguagePreview: ViewModifier {
    init(_ language: LanguagePreview.Language) {
        self.language = language
    }

    let language: Language
    enum Language: String {
        case en, fr, kin
    }
    func body(content: Content) -> some View {
        content
            .environment(\.locale, .init(identifier: language.rawValue))
    }
}
#endif

extension View {
    /// Handle  Tap Gesture for Biometrics Evaluation
    func onTapForBiometrics(onEvaluation: @escaping(Bool) -> Void) -> some View {
        ModifiedContent(content: self, modifier: BiometricsAccessibility(onEvaluation: onEvaluation))
    }
    
    /// Disable access if `Mtn` sim card is not detected
    /// - Returns: a disabled view if mtn card is not detected (no interaction).
    func momoDisability() -> some View {
        ModifiedContent(content: self, modifier: MTNDisabling())
    }
    
    
    /// Dismiss keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    /// Preview UI in supported languages in debug mode
    #if DEBUG
    func previewIn(_ language: LanguagePreview.Language) -> some View {
        ModifiedContent(content: self, modifier: LanguagePreview(language))
    }
    #endif
}

func drawImage(_ name: String, size: CGSize = CGSize(width: 60, height: 40)) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { _ in
        // Draw image in circle
        let image = UIImage(named: name)!
        let size = CGSize(width: 55, height: 35)
        let rect = CGRect(x: 0, y: 5, width: size.width, height: size.height)
        image.draw(in: rect)
    }
}
