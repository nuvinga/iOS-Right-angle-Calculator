//
//  CalculationView.swift
//  RightTriangleCalculator
//
//  Created by Nuvin Godakanda Arachchi on 2023-03-17.
//

import SwiftUI

enum Edge: String, CaseIterable, Identifiable {
    case Base, Altitude, Hypotenuse
    var id: Self { self }
}

struct CalculationView: View {
    @AppStorage ("altitude") private var altitude: String = ""
    @AppStorage ("base") private var base: String = ""
    @AppStorage ("hypotenuse") private var hypotenuse: String = ""
    @AppStorage ("area") private var area: String = ""
    @AppStorage ("perimeter") private var perimeter: String = ""
    
    @State private var selectedEdge: Edge = .Base
    @State private var errorAlert: Bool = false
    @State private var isCalculated: Bool = false
    @State private var localAltitude: String = ""
    @State private var localBase: String = ""
    @State private var localHypotenuse: String = ""
    @State private var localArea: String = ""
    @State private var localPerimeter: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image("right_triangle")
                
                HStack {
                    Text("Choose the unknown Edge").bold().padding(.leading)
                    Picker("Edge", selection: $selectedEdge) {
                        Text("Base").tag(Edge.Base)
                        Text("Altitude").tag(Edge.Altitude)
                        Text("Hypotenuse").tag(Edge.Hypotenuse)
                    }
                    .onChange(of: selectedEdge, perform: { _ in
                        localAltitude = ""
                        localBase = ""
                        localHypotenuse = ""
                        localArea = ""
                        localPerimeter = ""
                        isCalculated = false
                    })
                    .padding(.trailing)
                    .pickerStyle(.wheel)
                }
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Enter Known Length Values")
                            .bold()
                        if (selectedEdge == .Base) {
                            TextField("Altitude Value", text: $localAltitude)
                                .textFieldStyle(.roundedBorder)
                            TextField("Hypotenuse Value", text: $localHypotenuse)
                                .textFieldStyle(.roundedBorder)
                        } else if (selectedEdge == .Altitude) {
                            TextField("Base Value", text: $localBase)
                                .textFieldStyle(.roundedBorder)
                            TextField("Hypotenuse Value", text: $localHypotenuse)
                                .textFieldStyle(.roundedBorder)
                        } else if (selectedEdge == .Hypotenuse) {
                            TextField("Altitude Value", text: $localAltitude)
                                .textFieldStyle(.roundedBorder)
                            TextField("Base Value", text: $localBase)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button {
                        calculate()
                    } label: {
                        Text("Calculate")
                            .frame(width: 100.0, height: 30.0)
                    }
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .alert(isPresented: $errorAlert){
                        Alert(
                            title: Text("Error Converting Unit"),
                            message: Text("The Unit must be given in Meters to convert!"),
                            dismissButton: .cancel(Text("Okay"))
                        )
                    }
                }
                
                if (isCalculated) {
                    VStack {
                        HStack {
                            if (selectedEdge == .Hypotenuse) {
                                Text("Hypotenuse").bold()
                                Spacer()
                                Text("\(localHypotenuse)")
                            } else if (selectedEdge == .Altitude) {
                                Text("Altitude").bold()
                                Spacer()
                                Text("\(localAltitude)")
                            } else if (selectedEdge == .Base) {
                                Text("Base").bold()
                                Spacer()
                                Text("\(localBase)")
                            }
                        }
                        Spacer()
                        HStack {
                            Text("Area")
                            Spacer()
                            Text("\(localArea)")
                        }
                        Spacer()
                        HStack {
                            Text("Peremeter")
                            Spacer()
                            Text("\(localPerimeter)")
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Triangle Caculator")
        }
    }
    
    func calculate() {
        switch selectedEdge {
        case .Base:
            guard let a = Double(self.localAltitude),
                  let c = Double(self.localHypotenuse)
            else {
                errorAlert = true
                return
            }
            localBase = (String)(round((sqrt((c*c) - (a*a)))*100)/100)
        case .Altitude:
            guard let b = Double(self.localBase),
                  let c = Double(self.localHypotenuse)
            else {
                errorAlert = true
                return
            }
            localAltitude = (String)(round((sqrt((c*c) - (b*b)))*100)/100)
        case .Hypotenuse:
            guard let a = Double(localAltitude),
                  let b = Double(localBase)
            else {
                errorAlert = true
                return
            }
            localHypotenuse = (String)(round((sqrt((a*a) + (b*b)))*100)/100)
        }
        
        guard let a = Double(self.localAltitude),
              let b = Double(self.localBase)
        else {
            errorAlert = true
            return
        }
        localArea = (String)(round(((a*b)/2)*100)/100)
        localPerimeter = (String)(round((a+b+sqrt((a*a)+(b*b)))*100)/100)
        
        altitude = localAltitude
        base = localBase
        hypotenuse = localHypotenuse
        area = localArea
        perimeter = localPerimeter
        
        isCalculated = true
    }
    
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView()
    }
}
