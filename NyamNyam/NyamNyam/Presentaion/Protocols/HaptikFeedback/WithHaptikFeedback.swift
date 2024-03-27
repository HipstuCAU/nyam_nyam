//
//  WithHaptikFeedback.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import UIKit

protocol WithHaptikFeedback {
    func triggerFeedback()
    func triggerLightFeedback()
    func triggerSoftFeedback()
    func triggerHeavyFeedback()
    func triggerRigidFeedback()
    func triggerCompleteFeedback()
}

extension WithHaptikFeedback {
    func triggerFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerLightFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerSoftFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerHeavyFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerRigidFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerCompleteFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        let repeats = 2
        let delayBetweenHaptics = 0.1
        
        for i in 0..<repeats {
            DispatchQueue.main.asyncAfter(deadline: .now() + (delayBetweenHaptics * Double(i))) {
                
                generator.impactOccurred()
                
                if i < repeats - 1 {
                    generator.prepare()
                }
            }
        }
    }
}
