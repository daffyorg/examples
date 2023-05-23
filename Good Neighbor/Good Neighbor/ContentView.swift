//
//  ContentView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    let viewModel = HomeViewModel(locationDataProvider: LocationDataProvider(), daffyDataProvider: DaffyDataProvider())
    
    var body: some View {
        HomePageView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
