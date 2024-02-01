//
//  Home.swift
//  ScrollableTabView
//
//  Created by Ary Sugiarto on 30/01/24.
//

import SwiftUI

struct Home: View {
    
    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) private var scheme
    
    @State private var tabProgress: CGFloat = 0.5
    var body: some View {
        //view properties
        VStack(spacing: 15){
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.3.horizontal.decrease")
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "bell.badge")
                })
            }
            .font(.title)
            .overlay{
                Text("Pesan")
                    .font(.title3.bold())
            }
            .foregroundColor(.primary)
            .padding(15)
            
            // Custom bar
            CustomTabBar()
            //Paging view using iOS 17 APIs
            ScrollView(.horizontal){
                LazyHStack(spacing:0){
                    SampleView(.purple)
                        .id(Tab.chats)
                        .containerRelativeFrame(.horizontal)
                    
                    SampleView(.red)
                        .id(Tab.calls)
                        .containerRelativeFrame(.horizontal)
                    
                    SampleView(.blue)
                        .id(Tab.settings)
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .scrollClipDisabled()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(.gray.opacity(0.1))
    }
    @ViewBuilder
    func CustomTabBar() -> some View{
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue){ tab in
                HStack(spacing: 10){
                    Image(systemName: tab.systemImage)
                    
                    Text(tab.rawValue)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,10)
                .contentShape(.capsule)
                .onTapGesture {
                    // updateing tab
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                    
                }
            }
            
            //scrollable active tab indicator
            .background{
                GeometryReader{
                    let size =  $0.size
                    
                    let capsulWidth = size.width / CGFloat(Tab.allCases.count)
                    
                    Capsule()
                        .fill(scheme == .dark ? .black : .white)
                        .frame(width:capsulWidth)
                        .offset(x: tabProgress * (size.width - capsulWidth))
                }
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }
    
    // Sample view for demo
    
    @ViewBuilder
    func SampleView(_ color: Color) -> some View {
        ScrollView(.vertical){
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content :{
                ForEach(1...10, id: \.self){_ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(color.gradient)
                        .frame(height: 150)
                        .overlay{
                            VStack(alignment: .leading) {
                                Circle()
                                    .fill(.white.opacity(0.25))
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing:6) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.white.opacity(0.25))
                                        .frame(width: 80, height: 8)
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.white.opacity(0.25))
                                        .frame(width: 60, height: 8)
                                    
                                }
                            }
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    
                }
            })
            .padding(15)
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .mask{
            Rectangle()
                .padding(.bottom, -100)
        }
    }
}

#Preview {
    ContentView()
}
