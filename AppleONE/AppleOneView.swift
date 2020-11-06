//
//  AppleOneView.swift
//  AppleONE
//
//  Edited by Akashlal Bathe on 06/11/2020.
//

import SwiftUI

struct AppleOneView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selected = 0
    
    var body: some View {
        ZStack {
            
            if (colorScheme == .dark) {
                Color(.secondarySystemGroupedBackground)
                    .ignoresSafeArea(.all, edges: .all)
            } else {
                Color(.tertiarySystemGroupedBackground)
                    .ignoresSafeArea(.all, edges: .all)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .padding([.trailing])
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                HStack {
                    Image(systemName: "applelogo")
                        .font(.system(size: 30))
                    Text("One")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 4)
                Text("Enjoy millions of songs, over a hundred games, Aple Original shows and movies, and more. And save when you bundle them together.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 32)
                    .padding(.bottom)
                CategoryPanel(selected: $selected, index: 0, planName: "Individual", price: "195")
                    .padding(.bottom, 6)
                CategoryPanel(selected: $selected, index: 1, planName: "Familiar", price: "365")
                Spacer()
                Text("1 month free, then ₹ \(selected == 0 ? "195" : "365")/month")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Button(action: {}) {
                    Text("Start Free Trial")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 64)
                        .padding(.vertical)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
            }
        }
    }
}


struct CategoryPanel: View {
    @Environment(\.colorScheme) var colorScheme
    @Namespace private var animation
    @Binding var selected: Int
    let index: Int
    let planName: String
    let price: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(planName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 4.0)
                Spacer()
                Image(systemName: selected == index ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .center)
                    .foregroundColor(selected == index ? .blue : .gray)
            }
            Text("1 month free, then ₹ \(price)/month")
                .font(.callout)
                .padding(.bottom, 2.0)
            Text("Your existing subscriptions are not eligible for trial.")
                .fixedSize(horizontal: false, vertical: true)
                .font(.footnote)
                .foregroundColor(Color.gray)
            if (index == 0) {
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.blue)
                    Text("RECOMMENDED")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }.padding(.vertical, 2.0).font(.caption)
            }
            if (selected == index) {
                Divider()
                VStack(alignment: .leading) {
                    ServiceLabel(namespace: animation, name: "icloud", description: "\(selected==0 ? "50":"200") GB of iCloud storage")
                    ServiceLabel(namespace: animation, name: "applearcade", description: "Over 100 ad-free games")
                    ServiceLabel(namespace: animation, name: "appletv", description: "Apple Original shows and movies")
                    ServiceLabel(namespace: animation, name: "applemusic", description: "70+ million songs, all ad-free")
                }
            } else {
                HStack {
                    ServiceIcon(namespace: animation, name: "applemusic", size: 32)
                    ServiceIcon(namespace: animation, name: "appletv", size: 32)
                    ServiceIcon(namespace: animation, name: "applearcade", size: 32)
                    ServiceIcon(namespace: animation, name: "icloud", size: 32)
                }
            }
        }
        .padding(12)
        .background(colorScheme == .dark ? Color(.tertiarySystemGroupedBackground) : Color(.white))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(selected == index ? Color.blue : colorScheme == .dark ? Color.clear : Color.white, lineWidth: 2)
        )
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.6 : 0.1), radius: 6, x: 0.0, y: 0.0)
        .onTapGesture {
            withAnimation {
                selected = index
            }
        }
    }
}

struct ServiceIcon: View {
    var namespace: Namespace.ID
    let name: String
    let size: CGFloat
    
    var body: some View {
        Image(name)
            .resizable()
            .frame(width: size, height: size, alignment: .center)
            .cornerRadius(size/4)
            .overlay(
                RoundedRectangle(cornerRadius: size/4)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .matchedGeometryEffect(id: name, in: namespace)
    }
}

struct ServiceLabel: View {
    var namespace: Namespace.ID
    let name: String
    let description: String
    
    var body: some View {
        HStack {
            ServiceIcon(namespace: namespace, name: name, size: 26)
            Text(description)
        }
    }
}


struct AppleOneView_Previews: PreviewProvider {
    static var previews: some View {
        AppleOneView()
            .previewDevice("iPhone 11")
    }
}
