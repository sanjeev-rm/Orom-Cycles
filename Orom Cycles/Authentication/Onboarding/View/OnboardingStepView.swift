//
//  OnboardingView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 12/06/23.
//

import SwiftUI

struct OnboardingStepView: View {
    
    /// The OnboardingContent that is being presented.
    var onboardingStep: OnboardingStep
    
    var body: some View {
        VStack(spacing: 32) {
            // The image.
            onboardingStep.image
            
            // The title and description.
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(onboardingStep.title)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color(oromColor: .labelPrimary))
                    Spacer()
                }
                Text(onboardingStep.description)
                    .font(.system(size: 17, weight: .light))
                    .foregroundColor(Color(oromColor: .labelSecondary))
            }
            .padding()
        }
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStepView(onboardingStep: .one)
    }
}
