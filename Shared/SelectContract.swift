//
//  CreateAccount.swift
//  My Citadel
//
//  Created by Maxim Orlovsky on 2/4/21.
//

import SwiftUI

struct SelectContract: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                Text("There are many forms of wallet contracts. Read about them and choose the type of the contracts. you would like to create")
                    .lineSpacing(6)
                    .font(.title3)
                    .padding(.vertical, 23)

                ZStack {
                    ContractCard(type: ContractType.current)
                    NavigationLink(destination: CreateCurrentContract()) {
                        EmptyView()
                    }
                    .frame(width: 0)
                    .opacity(0)
                }

                Text("Today we support only current account contracts; but with new releases we will continue to grow the set of possibilities. Have a sneak peak of what will be waiting you in the future:")
                    .lineSpacing(6)
                    .font(.title3)
                    .padding(.top, 23)

                ForEach([ContractType.instant, ContractType.saving, ContractType.staking, ContractType.liquidity, ContractType.trading]) { type in
                    ContractCard(type: type)
                }
            }
            .navigationTitle("Create a new contract")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) { Text("Dismiss") }
                }
            }
        }
    }
}

struct ContractCard: View {
    let type: ContractType
    
    #if os(macOS)
    let whiteColor = Color(CGColor.white)
    #else
    let whiteColor = Color(.white)
    #endif

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                HStack {
                    Spacer()
                    Image(systemName: type.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 166)
                        .offset(x: -20, y: 20)
                        .foregroundColor(.secondary)
                        .opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                }
                Text(type.title)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .textCase(.uppercase)
                    .padding()
            }
            .background(RadialGradient(gradient: type.gradient, center: .topLeading, startRadius: 66.6, endRadius: 313))

            HStack(alignment: .top) {
                Text(type.description)
                    .lineSpacing(6)
                    .font(.body)
                    .shadow(color: .white, radius: 6, x: 0, y: 0)
                Spacer()
            }
            .padding()
            .foregroundColor(.black)
            .background(whiteColor)
        }
        .cornerRadius(13)
        .shadow(radius: 6.66)
        .padding(.bottom, 13)
    }
}

struct SelectContract_Previews: PreviewProvider {
    static var previews: some View {
        CreateCurrentContract()
    }
}
