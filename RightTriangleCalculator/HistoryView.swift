//
//  HistoryView.swift
//  RightTriangleCalculator
//
//  Created by Nuvin Godakanda Arachchi on 2023-03-17.
//

import SwiftUI

struct HistoryView: View {
    
    @AppStorage ("altitude") private var altitude: String = ""
    @AppStorage ("base") private var base: String = ""
    @AppStorage ("hypotenuse") private var hypotenuse: String = ""
    @AppStorage ("area") private var area: String = ""
    @AppStorage ("perimeter") private var perimeter: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Altitude").bold()
                    Spacer()
                    Text("\(altitude)")
                }
                .padding(.bottom)
                HStack {
                    Text("Base").bold()
                    Spacer()
                    Text("\(base)")
                }
                .padding(.bottom)
                HStack {
                    Text("Hypotenuse").bold()
                    Spacer()
                    Text("\(hypotenuse)")
                }
                .padding(.bottom)
                HStack {
                    Text("Area").bold()
                    Spacer()
                    Text("\(area)")
                }
                .padding(.bottom)
                HStack {
                    Text("Peremeter").bold()
                    Spacer()
                    Text("\(perimeter)")
                }
            }
            .padding()
            Spacer()
            .navigationTitle("Last Calulation")
        }
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
