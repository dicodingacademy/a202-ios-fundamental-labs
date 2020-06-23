//
//  HeroList.swift
//  MyHeroAppWithSwiftUI
//
//  Created by Gilang Ramadhan on 05/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import UIKit

struct HeroList: View {
    var body: some View {
        List(heroes) { hero in
            ZStack{
                HeroRow(hero: hero)
                NavigationLink(destination: HeroDetail(hero: hero)) {
                    EmptyView()
                }
            }
        }.navigationBarTitle(Text("Pahlawan Indonesia"), displayMode: .inline)
    }
}

struct HeroList_Previews: PreviewProvider {
    static var previews: some View {
        HeroList()
    }
}
