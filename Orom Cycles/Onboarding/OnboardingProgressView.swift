//
//  OnboardingProgressView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

struct OnboardingProgressView: View {
    
    /// The current OnboardingContent that is being presented.
    var currentOnboardingStep: OnboardingStep
    
    var body: some View {
        HStack {
            ForEach(OnboardingStep.allCases, id: \.self) { onboardingStep in
                let isPresenting = onboardingStep == currentOnboardingStep
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: isPresenting ? 20 : 10,
                           height: 10)
                    .foregroundColor(isPresenting ? .primary : .secondary)
            }
        }
    }
}

struct OnboardingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProgressView(currentOnboardingStep: .one)
    }
}
