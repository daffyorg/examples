//
//  Mocks.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

struct Mocks {
    struct Boston {
        static var mockDonation = Donation(id: 999, nonProfit: Mocks.Boston.mockNonProfit1, amount: 25, createdAt: Date.now)
        static var mockNonProfit1 = NonProfit(id: 999, name: "Friends Of The Public Garden", ein: "237451432", website: "https://www.wikipedia.org", city: "Boston", state: "MA")
        static var mockNonProfit2 = NonProfit(id: 999, name: "WBUR", ein: "042103547", website: "https://www.wikipedia.org", city: "Boston", state: "MA")
        static var mockNonProfit3 = NonProfit(id: 999, name: "Massachusetts Housing and Shelter Alliance", ein: "223068653", website: "https://www.wikipedia.org", city: "Boston", state: "MA")
        static var mockDonationRecommendations: [DonationRecommendation] = [
            DonationRecommendation(
                description:
                """
                The mission of the Friends of the Public Garden is to preserve, protect and enhance Boston's first public parks - the Boston Common, the Public Garden and the Commonwealth Avenue Mall - in partnership with the City of Boston's Parks and Recreation Department.
                """,
                nonProfit: mockNonProfit1,
                donationAmounts: [20, 40, 100]
            ),
            DonationRecommendation(
                description:
                """
                WBUR is a nonprofit news organization. Our coverage relies on your financial support. If you value articles like the one you're reading right now, give today.
                """,
                nonProfit: mockNonProfit2,
                donationAmounts: [20, 40, 60]
            ),
            DonationRecommendation(
                description:
                """
                The mission of the Massachusetts Housing and Shelter Alliance (MHSA) is to end homelessness in Massachusetts through permanent housing combined with outcome-based service programs.
                """,
                nonProfit: mockNonProfit3,
                donationAmounts: [40, 60, 100]
            )
        ]
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
            nonProfitEINList: ["237451432"]
        )
        static var mockNewsArticle2 = NewsArticle(
            title: "Boston wins federal grant to reduce unsheltered homelessness",
            content:
                """
                Boston has won a $16.5 million federal grant to help reduce unsheltered homelessness.

                The city had to apply and compete for the money from the Department of Housing and Urban Development.
                
                The effort is funded through the American Rescue Plan Act.

                In the city's 2022 homeless census — the most recent count for which data is available — there were 4,439 people found to be homeless in Boston. About one-third of them were unaccompanied adults, and 119 were staying on the streets as opposed to in shelters. There's been a significant increase in homelessness among families in recent months, with more migrant families arriving in Boston.

                The city conducted its most recent homeless census in January, but hasn't yet released the corresponding report.
                """,
            city: "Boston, MA",
            nonProfitEINList: ["042103547", "223068653"]
        )
    }
    
    struct SaltLakeCity {
        static var mockNonProfit1 = NonProfit(id: 999, name: "Salt Lake City Homeless Shelter", ein: "742548948", website: "https://www.wikipedia.org", city: "Salt Lake City", state: "UT")
        static var mockNonProfit2 = NonProfit(id: 999, name: "Ronald McDonald House", ein: "742386043", website: "https://www.wikipedia.org", city: "Salt Lake City", state: "UT")
        static var mockDonationRecommendations: [DonationRecommendation] = [
            DonationRecommendation(description: "Donate to the Salt Lake City Homeless Shelter to provide essential support, shelter, and resources to those experiencing homelessness. Your contribution helps meet basic needs, promote health and wellness, offer employment and housing assistance, foster community support, and break the cycle of homelessness. Make a lasting impact today.", nonProfit: mockNonProfit1, donationAmounts: [20, 40, 60]),
            DonationRecommendation(description: "RMHC of the intermountain area surrounds families with the support they need to be near and care for their seriously ill or injured children-- through our ronald mcdonald house, family rooms and hospitality carts.", nonProfit: mockNonProfit2, donationAmounts: [20, 40, 60])
        ]
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
            nonProfitEINList: ["742548948"]
        )
        static var mockNewsArticle2 = NewsArticle(
            title: "Rolling for Ronald: Utah man rides lawnmower through the state for charity",
            content:
                """
                Turning heads and bringing smiles, Scott Morgan from Santaquin is riding his lawnmower throughout Utah to make a difference. His journey kicked off Monday at the Utah/Idaho border, and now he’s on his way down Highway 89 to go through Kanab to the Utah/Arizona border.

                All of this is for a good cause. Morgan is seeking to raise money for families of children who are hospitalized.
                
                Morgan will be embarking on a 439-mile-long journey, intent on advocating for the fundraiser at 7 miles per hour with his lawnmower. This is his third year riding his lawnmower for charity and his goal for this year is to reach a cumulative total of $200,000 raised over all three years

                He hopes to inspire others to think about how they can give back.

                “Serve others. Everybody has a talent or ability. I had the talent to organize this event or ride a lawnmower. Everybody has a special talent or ability. Use those,” he said. “As we travel along, we try to be helpful to others and try to encourage others to look at themselves and look at what they can do to be more kind, we enjoy the journey and meeting some great Utahns along the way.”
                """,
            city: "Salt Lake City, UT",
            nonProfitEINList: ["742386043"]
        )
    }
    
    struct SanFrancisco {
        static var mockDonation = Donation(id: 999, nonProfit: Mocks.SanFrancisco.mockNonProfit1, amount: 150, createdAt: Date.now)
        static var mockNonProfit1 = NonProfit(id: 999, name: "Chinatown Community Development Center", ein: "942514053", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockNonProfit2 = NonProfit(id: 999, name: "Japantown Community Benefit District Inc.", ein: "823098216", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockNonProfit3 = NonProfit(id: 999, name: "San Francisco Recreation and Parks", ein: "237131784", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockNonProfit4 = NonProfit(id: 999, name: "Committed 2 Community", ein: "205080279", website: "https://www.wikipedia.org", city: "San Francisco", state: "CA")
        static var mockDonationRecommendations: [DonationRecommendation] = [
            DonationRecommendation(
            description:
            """
            Today, the Chinatown Community Development Center is at the forefront of community advocacy, planning, and affordable housing development in the City of San Francisco. Some say Chinatown CDC does the work of many organizations in one. That may have to do with our beginnings as five organizations.
            """,
            nonProfit: mockNonProfit1,
            donationAmounts: [20, 40, 100]
        ),
            DonationRecommendation(
                description:
                """
                The Japantown CBD will focus on providing environmental and economic enhancements to the district; including graffiti removal, pressure washing, marketing, and beautification improvements.
                """,
                nonProfit: mockNonProfit2,
                donationAmounts: [20, 40, 100]
            ),
            DonationRecommendation(
                description:
                """
                Our mission is to champion, transform and activate parks and public spaces throughout the city. We are the only 501c3 citywide nonprofit organization dedicated to parks and public spaces in San Francisco.
                """,
                nonProfit: mockNonProfit3,
                donationAmounts: [20, 40, 100]
            ),
            DonationRecommendation(
                description:
                """
                To support the community by producing participatory events and programs that will raise money for non-profit organizations or by providing needed services and educational programs to the community.
                """,
                nonProfit: mockNonProfit4,
                donationAmounts: [20, 40, 100]
            )
        ]
        static var mockNewsArticle1 = NewsArticle(
            title: "San Francisco Celebrates Asian American & Pacific Islander Heritage Month",
            content:
                """
                During the month of May, explore Asian American & Pacific Islander culture through films, foods, and books. The APA Heritage Foundation works with our Official Celebration Partners the Asian Art Museum, the Center for Asian American Media (CAAM) and the San Francisco Public Library to compile a Celebration Guide with a list of activities and events in the San Francisco Bay Area taking place in May.

                The APA Heritage Awards is a signature program of San Francisco’s celebration of Asian American & Pacific Islander Heritage Month.  Every year the APA Heritage Celebration Committee honors civic organizations that have achieved significant milestones in serving the community.  Our event is free and open to the public, but registration is required.
                """,
            city: "San Fransisco, CA",
            nonProfitEINList: ["942514053", "823098216"]
        )
        static var mockNewsArticle2 = NewsArticle(
            title: "San Francisco Marathon Results 2022: Men's and Women's Top Finishers",
            content:
                """
                Simon Ricci and Brooke Starn were the top performers in the men's and women's events at Sunday's San Francisco Marathon.

                Ricci clocked in at 2:31:42. He did a great job of preserving his stamina for the latter stages of the race. He was averaging 5:25 per mile when he hit the 24-mile mark and 5:33 as he crossed the finish line.
                
                That helped Ricci wrap up well ahead of Sumner Jones, who completed his race in 2:38.48.

                Starn, who ran competitively for Harvard before transferring to UC Davis, averaged 6:18 per mile for a 2:44:38 overall time. Traversing the downtown terrain was probably nothing new for the Danville, California, native.
                
                Cal Calamia, meanwhile, made history as the first-ever non-binary marathon winner (3:00:03). They were also the top performer in the non-binary category in the Bay to Breakers in May.

                The San Francisco full marathon got underway along The Embarcadero near Mission Street. Competitors ran along the San Francisco Bay until crossing the legendary Golden Gate Bridge.

                Upon turning back toward the city, runners traveled through the Presidio and Golden Gate Park before heading east toward the bay and along the coast to the finish.


                """,
            city: "San Fransisco, CA",
            nonProfitEINList: ["237131784", "205080279"]
        )
    }
}
