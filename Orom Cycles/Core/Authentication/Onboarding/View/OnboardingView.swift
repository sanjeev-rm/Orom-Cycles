//
//  OnboardingView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State var currentStep = OnboardingStep.one
    
    var body: some View {
        VStack {
            
            skipButton
            
            Spacer()
            
            // Image and the Text.
            TabView(selection:$currentStep) {
                ForEach(OnboardingStep.allCases, id: \.self) { onboardingStep in
                    OnboardingStepView(onboardingStep: onboardingStep)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // Progress View or the button.
            if currentStep == .four {
                findMeACycleButton
            } else {
                OnboardingProgressView(currentOnboardingStep: currentStep)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40)
            }
        }
        .padding(16)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}



extension OnboardingView {
    
    /// The skip button
    private var skipButton: some View {
        HStack {
            Spacer()
            Button {
                authenticationViewModel.showOnboardingView = false
            } label: {
                Text("Skip")
                    .font(.system(size: 17, weight: .medium))
            }
        }
        .padding([.top, .trailing], 24)
    }
    
    /// The find me a cycle button
    private var findMeACycleButton: some View {
        Button {
            authenticationViewModel.showOnboardingView = false
        } label: {
            Text("Find me a cycle")
                .font(.system(size: 22, weight: .medium))
                .frame(width: UIScreen.main.bounds.width - 100, height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
}
