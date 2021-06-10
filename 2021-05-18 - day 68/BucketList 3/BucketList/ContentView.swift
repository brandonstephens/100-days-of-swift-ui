//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/18/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading…")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Sucess!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
