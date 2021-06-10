//
//  File.swift
//  Edutainment
//
//  Created by Patrick Hill on 3/5/21.
//

import Foundation

import SwiftUI
import Combine

class PracticeStatus: ObservableObject  {
    @Published var showResults:Bool = false
}

struct FooView: View {
    @State private var flag = false

    var body: some View {
        PracticeView().environmentObject(PracticeStatus())
    }
}

struct PracticeView: View {
    @EnvironmentObject var practiceStatus: PracticeStatus

    var body: some View {
        VStack {
            if practiceStatus.showResults {
                ResultView()
            } else {
                QuestionView()
            }
        }
    }
}

struct QuestionView: View {
    @EnvironmentObject var practiceStatus: PracticeStatus

    var body: some View {
        VStack {

            Button(action: {
                self.practiceStatus.showResults = true
            }) {
                Text("button")
            }
        }
    }
}

struct ResultView: View {
    @State private var flag = false

    var body: some View {
        Text("RESULTS")
    }
}
