//
//  Mocks.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

struct Mocks {
    struct Boston {
        static var mockDonation = Donation(id: 999, nonProfit: Mocks.Boston.mockNonProfit, amount: 25, createdAt: Date.now)
        static var mockNonProfit = NonProfit(id: 999, name: "Friends Of The Public Garden", ein: "237451432", website: "https://www.wikipedia.org", city: "Boston", state: "MA")
        static var mockDonationRecommendation = DonationRecommendation(
            description:
            """
            The mission of the Friends of the Public Garden is to preserve, protect and enhance Boston's first public parks - the Boston Common, the Public Garden and the Commonwealth Avenue Mall - in partnership with the City of Boston's Parks and Recreation Department.
            """,
            nonProfitEIN: "237451432",
            donationAmounts: [20, 40, 100]
        )
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
            donationRecommendations: [mockDonationRecommendation]
        )
    }
    
    struct SaltLakeCity {
        static var mockDonation = Donation(id: 999, nonProfit: Mocks.SaltLakeCity.mockNonProfit, amount: 50, createdAt: Date.now)
        static var mockNonProfit = NonProfit(id: 999, name: "Salt Lake City Homeless Shelter", ein: "742548948", website: "https://www.wikipedia.org", city: "Salt Lake City", state: "UT")
        static var mockDonationRecommendation = DonationRecommendation(description: "Donate to the Salt Lake City Homeless Shelter to provide essential support, shelter, and resources to those experiencing homelessness. Your contribution helps meet basic needs, promote health and wellness, offer employment and housing assistance, foster community support, and break the cycle of homelessness. Make a lasting impact today.", nonProfitEIN: "742548948", donationAmounts: [20, 40, 60])
        static var mockNewsArticle1 = NewsArticle(
            title: "Salt Lake City homeless shelter needs your help as freezing temperatures drop",
            content:
                """
                Freezing temperatures are pushing one Salt Lake City homeless shelter to the brink to help get people off the streets and into their warm facility, and now they’re asking the public for help.

                The Rescue Mission of Salt Lake Assistant House Manager Kurtis Ray said the shelter is watching growing numbers of people show up, and they’re struggling to meet the demands of caring for so many people.
                
                Ray said he used to live on the streets of Salt Lake City, and he understands what the people in the shelter are enduring. “There are just no words for what they are going through,” Ray said. “We offer a day room where people can hang out during the day,” Ray said. “While they are here, we offer them three hot meals. They appreciate a hot meal, especially in this cold weather.”
                
                Not only does the Rescue Mission try to bring people inside, but they also go into homeless camps to provide aid, bringing coats, gloves, and tools to people to help them survive the cold. According to the state, more than 3,500 Utahns experience homelessness each night, and nationwide, more than a half million Americans are experiencing some form of homelessness.

                Ray says he is grateful for the Rescue Mission giving him a second chance to help others.
                """,
            city: "Salt Lake City, UT",
            donationRecommendations: [mockDonationRecommendation]
        )
    }
    
    struct SanFrancisco {
        static var mockDonation = Donation(id: 999, nonProfit: Mocks.SanFrancisco.mockNonProfit1, amount: 150, createdAt: Date.now)
        static var mockNonProfit1 = NonProfit(id: 999, name: "Chinatown Community Development Center", ein: "942514053", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockDonationRecommendation1 = DonationRecommendation(
            description:
            """
            Today, the Chinatown Community Development Center is at the forefront of community advocacy, planning, and affordable housing development in the City of San Francisco. Some say Chinatown CDC does the work of many organizations in one. That may have to do with our beginnings as five organizations.
            """,
            nonProfitEIN: "942514053",
            donationAmounts: [20, 40, 100]
        )
        
        static var mockNonProfit2 = NonProfit(id: 999, name: "Japantown Community Benefit District Inc.", ein: "823098216", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockDonationRecommendation2 = DonationRecommendation(
            description:
            """
            The Japantown CBD will focus on providing environmental and economic enhancements to the district; including graffiti removal, pressure washing, marketing, and beautification improvements.
            """,
            nonProfitEIN: "823098216",
            donationAmounts: [20, 40, 100]
        )
        static var mockNewsArticle1 = NewsArticle(
            title: "San Francisco Celebrates Asian American & Pacific Islander Heritage Month",
            content:
                """
                During the month of May, explore Asian American & Pacific Islander culture through films, foods, and books. The APA Heritage Foundation works with our Official Celebration Partners the Asian Art Museum, the Center for Asian American Media (CAAM) and the San Francisco Public Library to compile a Celebration Guide with a list of activities and events in the San Francisco Bay Area taking place in May.

                The APA Heritage Awards is a signature program of San Francisco’s celebration of Asian American & Pacific Islander Heritage Month.  Every year the APA Heritage Celebration Committee honors civic organizations that have achieved significant milestones in serving the community.  Our event is free and open to the public, but registration is required.
                """,
            city: "Boston, MA",
            donationRecommendations: [mockDonationRecommendation1, mockDonationRecommendation2]
        )
    }
}
