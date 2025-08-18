//
//  EnterOTPView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 08/08/25.
//

import SwiftUI
import Combine

struct EnterOTPView: View {
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    
    var body: some View {
        VStack {
            
            Text("Verify your Email/Number")
                .font(.title2)
                .fontWeight(.semibold)
            
            
            Text("Enter 4 digit code sent to you")
                .font(.caption)
                .fontWeight(.thin)
                .padding(.top)
            
            HStack(spacing:15, content: {
                
                TextField("", text: $pinOne)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemBlue), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .modifier(OtpModifier(pin:$pinOne))
                    .onChange(of:pinOne){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinTwo
                        }
                    }
                    .focused($pinFocusState, equals: .pinOne)
                
                TextField("", text:  $pinTwo)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemBlue), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .modifier(OtpModifier(pin:$pinTwo))
                    .onChange(of:pinTwo){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinThree
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinOne
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinTwo)
                
                
                TextField("", text:$pinThree)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemBlue), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .modifier(OtpModifier(pin:$pinThree))
                    .onChange(of:pinThree){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinFour
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinTwo
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinThree)
                
                
                TextField("", text:$pinFour)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemBlue), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .modifier(OtpModifier(pin:$pinFour))
                    .onChange(of:pinFour){newVal in
                        if (newVal.count == 0) {
                            pinFocusState = .pinThree
                        }
                    }
                    .focused($pinFocusState, equals: .pinFour)
                
                
            })
            .padding(.vertical)
            .padding(.top, 10)

            Button{
                print("verified")
            } label: {
                Text("Verify")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 120)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .padding()
        }
    }
}

struct EnterOTPView_Previews: PreviewProvider {
    static var previews: some View {
        EnterOTPView()
    }
}
