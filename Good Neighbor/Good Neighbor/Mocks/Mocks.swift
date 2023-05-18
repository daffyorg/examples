//
//  Mocks.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

struct Mocks {
    static var mockNonProfit = NonProfit(id: 999, name: "Salt Lake City Homeless Shelter", ein: "20392", website: "https://www.wikipedia.org", city: "Salt Lake City", state: "UT")
    static var mockDonation = Donation(id: 999, nonProfit: Mocks.mockNonProfit, amount: 50, createdAt: Date.now)
    static var mockDonationRecommendation = DonationRecommendation(description: "Donate to the Salt Lake City Homeless Shelter to provide essential support, shelter, and resources to those experiencing homelessness. Your contribution helps meet basic needs, promote health and wellness, offer employment and housing assistance, foster community support, and break the cycle of homelessness. Make a lasting impact today.", nonProfit: Mocks.mockNonProfit, donationAmounts: [20, 40, 60])
    
    static var mockNewsArticle1 = NewsArticle(
        title: "Bring the kids to the annual Duckling Day Parade on Boston Common",
        content:
            """
            Duckling Day returns to Boston Common and the Public Garden on Sunday, May 14, celebrating Mother’s Day and Robert McCloskey’s beloved book “Make Way for Ducklings.” For over 30 years, hundreds of children dressed like characters from the book have headed to the Common with their families for a day of children’s activities, parading, and warm weather fun.
            
            Festivities kick off at 10 a.m. on Boston Common near the Parkman Bandstand with “Playtime on the Common.” Children can play interactive circus games with Esh Circus Arts, see a magician, check out the “Make Way for Ducklings” reading station, and visit with the Harvard University Marching Band.
            
            The parade begins at noon, marching from the bandstand through the Common and Public Garden and ending at the “Make Way for Ducklings” statues. Last year’s Duckling Day was the biggest one yet, with thousands attending the sold-out event.
            
            Registration costs $35 per child and includes a goodie back full of Duckling Day-themed gifts. Families are encouraged to bring a picnic lunch to enjoy in the Public Garden after the festivities end.
            """,
        city: "Boston, MA",
        donationRecommendations: [
            DonationRecommendation(
                description:
                """
                The mission of the Friends of the Public Garden is to preserve, protect and enhance Boston's first public parks - the Boston Common, the Public Garden and the Commonwealth Avenue Mall - in partnership with the City of Boston's Parks and Recreation Department.
                """,
                nonProfit: mockNonProfit,
                donationAmounts: [20, 40, 100]
            )
        ]
    )
}
