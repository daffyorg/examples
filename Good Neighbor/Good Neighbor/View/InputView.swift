//
//  InputView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/19/23.
//

import SwiftUI

struct InputView: View {
    @State private var apiKey = ""
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Image("launchImage")
                .resizable()
            .frame(width: 165, height: 80)
            .padding(56)
            Text("Please enter your Daffy API key to continue")
                .font(Fonts.caption1)
                .foregroundColor(Color.neutral700)
                .padding(10)
            TextField("Daffy API Key", text: $apiKey)
                .padding(10)
                .background(Color.background2)
                .cornerRadius(8)
                .padding(.bottom)
            Button("Submit") {
                print(apiKey)
                apiKey = ""
                viewModel.handleAPIKey(apiKey)
            }
            .buttonStyle(.borderedProminent)
            .disabled(apiKey.isEmpty)
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(viewModel: HomeViewModel(locationDataProvider: LocationDataProvider(), daffyDataProvider: DaffyDataProvider()))
    }
}
