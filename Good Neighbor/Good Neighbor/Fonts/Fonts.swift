//
//  Fonts.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation
import SwiftUI

struct Fonts {
    static var caption2: Font = Font.caption2.weight(.regular)
    static var caption2Bold: Font = Font.caption2.weight(.semibold)
    static var caption1: Font = Font.caption.weight(.regular)
    static var caption1Bold: Font = Font.caption.weight(.medium)
    static var footnote: Font = Font.footnote.weight(.regular)
    static var footnoteBold: Font = Font.footnote.weight(.semibold)
    static var subheadline: Font = Font.subheadline.weight(.regular)
    static var subheadlineBold: Font = Font.subheadline.weight(.semibold)
    static var callout: Font = Font.callout.weight(.regular)
    static var calloutBold: Font = Font.callout.weight(.semibold)
    static var body: Font = Font.body.weight(.regular)
    static var bodyBold: Font = Font.body.weight(.semibold)
    static var headline: Font = Font.custom("Recoleta-Semibold", size: 17)
    static var headlineBold: Font = Font.custom("Recoleta-Semibold", size: 17)
    static var title3: Font = Font.custom("Recoleta-Regular", size: 20)
    static var title3Bold: Font = Font.custom("Recoleta-SemiBold", size: 20)
    static var title2: Font = Font.custom("Recoleta-Regular", size: 22)
    static var title2Bold: Font = Font.custom("Recoleta-Bold", size: 22)
    static var title1: Font = Font.custom("Recoleta-Regular", size: 28)
    static var title1Bold: Font = Font.custom("Recoleta-Bold", size: 28)
    static var largeTitle: Font = Font.custom("Recoleta-Regular", size: 34)
    static var largeTitleBold: Font = Font.custom("Recoleta-Bold", size: 34)
}
