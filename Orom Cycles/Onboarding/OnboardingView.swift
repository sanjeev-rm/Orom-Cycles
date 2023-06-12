//
//  OnboardingView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    /// The OnboardingContent that is being presented.
    var onboardingStep: OnboardingStep
    
    var body: some View {
        VStack {
            
            // The Skip button
            HStack {
                Spacer()
                Button {
                } label: {
                    Text("Skip")
                        .font(.system(size: 17, weight: .medium))
                }
            }
            
            Spacer()
            
            // The Image.
            
            VStack(spacing: 32) {
                onboardingStep.image
                
                // The title and description.
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(onboardingStep.title)
                            .font(.system(size: 32, weight: .semibold))
                        Spacer()
                    }
                    Text(onboardingStep.description)
                        .font(.system(size: 17, weight: .light))
                }
            }
            
            Spacer()
            
            // The progress view.
            // Button is presented instead of preogress view if it's the 4th OnboardingContent.
            if onboardingStep == .four {
                Button {
                } label: {
                    Text("Find me a cycle")
                        .font(.system(size: 22, weight: .medium))
                        .frame(width: UIScreen.main.bounds.width - 100, height: 40)
                }
                .buttonStyle(.borderedProminent)
                .shadow(radius: 4)
            } else {
                OnboardingProgressView(currentOnboardingStep: onboardingStep)
            }
        }
        .padding(32)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingStep: .four)
    }
}
