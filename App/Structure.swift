import UIKit
import Foundation
struct Plant {
    var id:Int
    var name:String
    var description:String
    var waterRequired:String
    var temperatureRequired:String
    var lightRequired:String
    var image:UIImage?
    var isTrending:Bool
    var stages:[Stage]
}


struct Stage: Equatable {
    let Id: Int
    let name: String
    let information: String
    let timeLine: String
    let image: UIImage
    let task: [Week]

    static func == (lhs: Stage, rhs: Stage) -> Bool {
        return lhs.Id == rhs.Id
    }
}

struct Week {
    var weekNumber: String
    var dailyTasks: [TaskForTheDay]
}

struct TaskForTheDay {
    var task: String
    var dayOffset: Int
    var category: String
}


struct UserSection: Codable {
    var userId: Int
    var userName: String
    var email: String
    var location: String
    var userPlants: [Int: PlantData]
    var favouritePlantsId: [Int]
    var recommendedPlantsId: [Int]
    var password: String
}

struct PlantData: Codable {
    var addedDate: Date
    var stageId: Int
}

func getCurrentDayIndex() -> Int {
    let calendar = Calendar.current
    let today = Date()
    let weekday = calendar.component(.weekday, from: today)
    return (weekday - 1) % 7
}

@MainActor
class DataModel {
    static let shared = DataModel()
    
    var plants: [Plant] = [
        Plant(
            id: 1,
            name: "Aloe Vera",
            description: "Aloe Vera is a succulent known for its medicinal properties.",
            waterRequired: "1/week",
            temperatureRequired: "18-25°C",
            lightRequired: "Indirect sunlight or partial shade.",
            image: UIImage(named: "aloeVera1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Aloe Vera seeds germinate in moist soil within 2-4 weeks.",
                    timeLine: "4 weeks",
                    image: UIImage(named: "aloegermination3") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Check soil moisture", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Keep the soil moist", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Check temperature", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Monitor seedling growth", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Keep soil moist", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Prepare for transplantation", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Check soil pH", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 2",
                            dailyTasks: [
                                TaskForTheDay(task: "Adjust watering schedule", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Provide indirect sunlight", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Inspect for pests or mold", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Check soil drainage", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Keep the soil moist", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Trim any weak seedlings", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Recheck temperature and humidity", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 3",
                            dailyTasks: [
                                TaskForTheDay(task: "Increase sunlight exposure slightly", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Check seedling root development", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Keep soil moist", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Add a thin layer of mulch", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Inspect seedlings for growth uniformity", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Prepare pots for transplantation", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Reassess soil quality", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 4",
                            dailyTasks: [
                                TaskForTheDay(task: "Begin hardening off seedlings", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Water sparingly to encourage root growth", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Gradually increase sunlight exposure", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Inspect leaves for healthy coloration", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Check for readiness to transplant", dayOffset: 4, category: "Mending")
                            ]
                        )
                    ]
                    
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Small leaves begin to grow.",
                    timeLine: "4 weeks",
                    image: UIImage(named: "aloeSeedling1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 5",
                            dailyTasks: [
                                TaskForTheDay(task: "Check soil moisture", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Keep the soil moist", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Check temperature", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Monitor seedling growth", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Keep soil moist", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Prepare for transplantation", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Check soil pH", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 6",
                            dailyTasks: [
                                TaskForTheDay(task: "Adjust watering schedule", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Provide indirect sunlight", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Inspect for pests or mold", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Check soil drainage", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Keep the soil moist", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Trim any weak seedlings", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Recheck temperature and humidity", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 7",
                            dailyTasks: [
                                TaskForTheDay(task: "Increase sunlight exposure slightly", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Check seedling root development", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Keep soil moist", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Add a thin layer of mulch", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Inspect seedlings for growth uniformity", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Reassess soil quality", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 8",
                            dailyTasks: [
                                TaskForTheDay(task: "Begin hardening off seedlings", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Water sparingly to encourage root growth", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Gradually increase sunlight exposure", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Inspect leaves for healthy coloration", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Check for readiness to transplant", dayOffset: 4, category: "Mending")
                               
                               
                            ]
                        )
                    ]
                    
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "Leaves grow thicker, storing water and nutrients.",
                    timeLine: "6 weeks",
                    image: UIImage(named: "aloeGrowth1") ?? UIImage(),
                    task: [
                        // Week 7
                        Week(
                            weekNumber: "Week 9",
                            dailyTasks: [
                                TaskForTheDay(task: "Ensure the plant receives bright, indirect sunlight", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Water deeply but allow soil to dry completely between waterings", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Check leaves for signs of overwatering or underwatering", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Loosen soil surface for better aeration", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Rotate pots for even light exposure", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Remove dead or yellowing leaves", dayOffset: 6, category: "Pruning")
                            ]
                        ),
                        // Week 8
                        Week(
                            weekNumber: "Week 10",
                            dailyTasks: [
                                TaskForTheDay(task: "Increase sunlight exposure gradually (4-6 hours/day)", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Water sparingly; check soil dryness before watering", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Inspect roots by gently checking the pot base", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Reposition plants to avoid overcrowding", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Remove debris or fallen leaves around the base", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Assess leaf thickness and growth rate", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        // Week 9
                        Week(
                            weekNumber: "Week 11",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply in the morning", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Increase sunlight exposure to 6–8 hours/day", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Check drainage holes to prevent waterlogging", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Clean leaves with a damp cloth to remove dust", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Inspect for new leaf growth", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Review care routine for any adjustments", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        // Week 10
                        Week(
                            weekNumber: "Week 12",
                            dailyTasks: [
                                TaskForTheDay(task: "Reassess watering frequency (reduce if weather cools)", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Inspect the plant base for signs of rot", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Trim any leaves with brown or dry tips", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply organic fertilizer for healthy growth", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure adequate spacing for airflow between plants", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Check leaf color and texture", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Deep water the plant to strengthen roots", dayOffset: 6, category: "Watering")
                            ]
                        ),
                        // Week 11
                        Week(
                            weekNumber: "Week 13",
                            dailyTasks: [
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Water only when soil is completely dry", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Recheck root system health in pots", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Remove weak or crowded leaves", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Clean pots and ensure proper hygiene", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Track leaf growth for signs of maturity", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        // Week 12
                        Week(
                            weekNumber: "Week 14",
                            dailyTasks: [
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Water sparingly; avoid overwatering", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Trim and collect mature leaves for propagation", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Reassess soil nutrient levels", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Evaluate overall health and adjust care plan", dayOffset: 6, category: "Mending")
                            ]
                        )
                    ]
                    
                ),
                Stage(
                    Id: 4,
                    name: "Dormancy",
                    information: "During winters, growth slows down to conserve energy.",
                    timeLine: "6 weeks",
                    image: UIImage(named: "aloeDormancy") ?? UIImage(),
                    task: [
                        // Week 13
                        Week(
                            weekNumber: "Week 15",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering frequency", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Inspect soil for moisture before watering", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Clean leaves with a damp cloth", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Remove dead leaves", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Ensure pots have good drainage", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Minimize disturbance to roots", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        // Week 14
                        Week(
                            weekNumber: "Week 16",
                            dailyTasks: [
                                TaskForTheDay(task: "Check soil dryness before watering", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure environment remains cool and dry", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Check for signs of overwatering or rot", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 3, category: "Mending")
                            ]
                        ),
                        // Week 15
                        Week(
                            weekNumber: "Week 17",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly (if soil is completely dry)", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Dust leaves to maintain photosynthesis", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Inspect roots for signs of rot or stress", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Recheck drainage holes for blockage", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Remove any dried leaf tips", dayOffset: 5, category: "Pruning")
                            ]
                        ),
                        // Week 16
                        Week(
                            weekNumber: "Week 18",
                            dailyTasks: [
                                TaskForTheDay(task: "Water only if soil is bone dry", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove wilted or drooping leaves", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Keep soil surface loose and aerated", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Avoid overwatering even if plant looks dry", dayOffset: 6, category: "Watering")
                            ]
                        ),
                        // Week 17
                        Week(
                            weekNumber: "Week 19",
                            dailyTasks: [
                                TaskForTheDay(task: "Water lightly if soil is completely dry", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Dust leaves gently to improve light absorption", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 4, category: "Mending")
                            ]
                        ),
                        // Week 18
                        Week(
                            weekNumber: "Week 20",
                            dailyTasks: [
                                TaskForTheDay(task: "Water lightly; do not soak soil", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Clean leaves to prepare for active growth", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Inspect soil quality and consider refreshing top layer", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Remove any dried or damaged parts of the plant", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 5, category: "Pruning")
                            ]
                        ),
                    ]
                    
                ) ]),
        
        
        Plant(
            id: 2,
            name: "Marigold",
            description: "Marigolds are annual flowers known for their vibrant, colorful blooms.",
            waterRequired: "2-3 times/week",
            temperatureRequired: "15-25°C",
            lightRequired: "Full sunlight",
            image: UIImage(named: "marigold1") ?? UIImage(),
            isTrending: false,
                stages: [
                    Stage(
                        Id: 1,
                        name: "Germination",
                        information: "Marigold seeds germinate in moist, well-draining soil within 7-10 days.",
                        timeLine: "2 weeks",
                        image: UIImage(named: "marigoldGermination1") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 1",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check soil moisture", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Water seeds lightly in the morning", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Ensure soil stays moist but not soggy", dayOffset: 2, category: "Watering"),
                                    TaskForTheDay(task: "Remove debris or weeds near the seeds", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect soil for pests and address if needed", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Monitor soil pH levels to ensure 6-7 range", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Prepare transplant trays for stronger seedlings", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 2",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water the soil gently to avoid disturbing seedlings", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Maintain consistent soil moisture", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Thin out weaker seedlings for optimal growth", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Remove any weeds growing near seedlings", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Check seedlings for signs of wilting or stress", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Add a diluted, organic fertilizer", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Begin preparing seedlings for transplanting", dayOffset: 6, category: "Mending")
                                ]
                            )
                        ]
                    ),

                        Stage(
                            Id: 2,
                            name: "Seedling",
                            information: "During the seedling stage, marigolds continue to develop strong roots, stems, and leaves. Providing optimal care ensures healthy plants ready for transplanting.",
                            timeLine: "4 weeks",
                            image: UIImage(named: "marigoldSeedling1") ?? UIImage(),
                            task: [
                                Week(
                                    weekNumber: "Week 3",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water lightly every morning to keep the soil moist", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Check drainage to avoid root rot", dayOffset: 1, category: "Mending"),
                                        TaskForTheDay(task: "Thin overcrowded seedlings", dayOffset: 2, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect leaves for signs of pests or discoloration", dayOffset: 3, category: "Mending"),
                                        TaskForTheDay(task: "Rotate trays or pots for even sunlight exposure", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Apply a mild organic fertilizer for steady growth", dayOffset: 5, category: "Fertilizer"),
                                        TaskForTheDay(task: "Remove any weeds in the growing area", dayOffset: 6, category: "Pruning")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 4",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water seedlings lightly to keep soil evenly moist", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Monitor soil temperature to ensure it stays above 18°C", dayOffset: 1, category: "Mending"),
                                        TaskForTheDay(task: "Pinch off leggy seedlings to encourage bushier growth", dayOffset: 2, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect for pest damage.", dayOffset: 3, category: "Mending"),
                                        TaskForTheDay(task: "Add a diluted balanced fertilizer to support growth", dayOffset: 4, category: "Fertilizer"),
                                        TaskForTheDay(task: "Start hardening off seedlings by gradually exposing them to outdoor conditions", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Remove any yellowing leaves or weak plants", dayOffset: 6, category: "Pruning")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 5",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water seedlings early in the morning, ensuring soil remains moist", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Continue hardening off seedlings by extending outdoor exposure", dayOffset: 1, category: "Mending"),
                                        TaskForTheDay(task: "Prune leggy or unhealthy seedlings to prioritize strong growth", dayOffset: 2, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect stems and leaves for signs of fungal infections", dayOffset: 3, category: "Mending"),
                                        TaskForTheDay(task: "Apply a small dose of phosphorus-rich fertilizer for root development", dayOffset: 4, category: "Fertilizer"),
                                        TaskForTheDay(task: "Check pots or trays for root crowding; prepare for transplanting", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Remove weeds or debris around the seedling area", dayOffset: 6, category: "Pruning")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 6",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water seedlings before their outdoor exposure to prevent drying", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Continue to harden off seedlings by increasing outdoor exposure", dayOffset: 1, category: "Mending"),
                                        TaskForTheDay(task: "Inspect seedlings daily for transplant readiness (strong roots, healthy growth)", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Prune any weak or damaged leaves before transplanting", dayOffset: 3, category: "Pruning"),
                                        TaskForTheDay(task: "Apply a mild fertilizer to reduce transplant shock", dayOffset: 4, category: "Fertilizer"),
                                        TaskForTheDay(task: "Finalize outdoor garden beds or pots for transplantation", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Transplant seedlings to their permanent location and water thoroughly", dayOffset: 6, category: "Watering")
                                    ]
                                )
                            ]
                        ),
                        Stage(
                            Id: 3,
                            name: "Vegetative Growth",
                            information: "During the vegetative growth stage, marigolds develop strong stems, leaves, and roots to prepare for flowering. Consistent care ensures healthy plant development.",
                            timeLine: "8 weeks",
                            image: UIImage(named: "marigoldGrowth") ?? UIImage(),
                            task: [
                                Week(
                                    weekNumber: "Week 7",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water thoroughly but allow soil to slightly dry between watering", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Remove small weeds around plants to avoid competition", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Check stems for signs of pests like aphids", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a nitrogen-rich fertilizer to encourage leafy growth", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Inspect soil for proper drainage and aeration", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Pinch back the top leaves to promote bushier growth", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Monitor for signs of overwatering or yellowing leaves", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 8",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water plants in the morning if the topsoil feels dry", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Remove older or damaged leaves to channel growth into healthy foliage", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Check for signs of fungal infections and apply fungicide if needed", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add compost or organic matter around the base for nutrients", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Stake taller plants to prevent them from bending", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Ensure plants get 6-8 hours of sunlight daily", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Remove any weeds or grasses growing near plants", dayOffset: 6, category: "Pruning")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 9",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water evenly to maintain consistent soil moisture", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Prune excess side branches to direct energy to main stems", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect leaves for discoloration and nutrient deficiencies", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a balanced NPK fertilizer for healthy growth", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Loosen soil around the base to improve aeration", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Trim any overly crowded areas for better airflow", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Monitor plants for signs of pest infestations", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 10",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water deeply to reach roots and promote strong growth", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Remove weak side shoots or suckers", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect stems and roots for signs of stress or damage", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add a phosphorus-rich fertilizer to boost root strength", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Stake or tie taller plants for support as they grow", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove any nearby invasive plants to reduce competition", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Check for proper spacing to ensure good airflow", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 11",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water only when the topsoil feels dry to touch", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Prune yellow or wilting leaves to maintain plant health", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect for any signs of pests or diseases", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a potassium-rich fertilizer to prepare for flowering", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Ensure plants are not overcrowded for sunlight access", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Weed the growing area to reduce nutrient competition", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Continue monitoring for pests like aphids and whiteflies", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 12",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water plants in the morning to avoid overnight dampness", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Pinch back excessive growth to encourage compact plants", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect the underside of leaves for pests", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add compost to improve soil structure and nutrients", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Test soil pH and adjust if necessary for optimal growth", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove plants that appear stunted or unhealthy", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Stake any top-heavy plants for stability", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 13",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water evenly, ensuring no dry patches in the soil", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Prune excessive growth to shape the plant", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect for leaf spots or fungal issues", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a final round of balanced fertilizer before flowering", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Ensure no waterlogging in the area", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove any weak or overgrown shoots", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Monitor buds starting to form", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 14",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water consistently to keep soil moist as plants prepare to bloom", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Remove dead or dying leaves", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect developing buds for pest activity", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply potassium-rich fertilizer for vibrant blooms", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Ensure plants have enough spacing for airflow", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Prune weak or overcrowded areas to focus growth on buds", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Prepare for transition to flowering stage", dayOffset: 6, category: "Mending")
                                    ]
                                )
                            ]
                        ),
                        Stage(
                            Id: 4,
                            name: "Budding",
                            information: "During the budding stage, marigolds focus on developing flower buds. Proper care during this stage ensures vibrant and healthy blooms.",
                            timeLine: "4 weeks",
                            image: UIImage(named: "marigoldBudding2") ?? UIImage(),
                            task: [
                                Week(
                                    weekNumber: "Week 15",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water deeply to keep soil moist, especially during hot days", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Pinch off weak or underdeveloped buds to promote larger blooms", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect leaves and buds for early signs of pests like aphids", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a phosphorus-rich fertilizer to support bud formation", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Remove weeds or debris around the base of the plant", dayOffset: 4, category: "Pruning"),
                                        TaskForTheDay(task: "Check for proper airflow around plants to prevent fungal infections", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Monitor buds daily for signs of discoloration or damage", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 16",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water plants early in the morning to maintain soil moisture", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Prune older or yellowing leaves to focus energy on budding", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect buds for signs of pests like budworms", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add a potassium-rich fertilizer for vibrant flower colors", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Check stems for stability and stake if necessary", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove any overcrowded or unhealthy growth", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect nearby plants for potential disease spread", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 17",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water consistently to avoid soil drying out, especially near roots", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Pinch off buds that appear too small or weak to focus on strong buds", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect foliage for signs of leaf spot or mildew", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a light dose of organic fertilizer to maintain nutrient levels", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Loosen soil around the base to improve aeration", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove any weeds that could steal nutrients from budding plants", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Ensure plants receive 6-8 hours of sunlight daily", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 18",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water thoroughly but avoid wetting the buds directly", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Prune dead or damaged leaves to maintain plant health", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect buds for maturity and prepare for blooming phase", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a final dose of potassium-rich fertilizer for bloom enhancement", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Check for pests like spider mites or whiteflies on leaves and buds", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Thin out crowded plants to ensure proper air circulation", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Monitor closely for the first signs of blooming", dayOffset: 6, category: "Mending")
                                    ]
                                )
                            ]
                        ),

                        Stage(
                            Id: 5,
                            name: "Flowering",
                            information: "During the flowering stage, marigolds bloom and display vibrant flowers. Consistent care ensures long-lasting blooms and plant health.",
                            timeLine: "6 weeks",
                            image: UIImage(named: "marigoldFlowering1") ?? UIImage(),
                            task: [
                                Week(
                                    weekNumber: "Week 19",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water deeply, keeping the soil moist but avoiding waterlogging", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Deadhead wilted flowers to encourage new blooms", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect flowers and leaves for pests like aphids or whiteflies", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a balanced fertilizer to maintain flowering energy", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Remove weeds around the base to reduce competition for nutrients", dayOffset: 4, category: "Pruning"),
                                        TaskForTheDay(task: "Ensure plants get 6-8 hours of sunlight daily", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Monitor flowers for discoloration or signs of stress", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 20",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water in the morning to avoid overnight dampness", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Trim overcrowded foliage to improve airflow around flowers", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Check for fungal infections, especially on petals", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add potassium-rich fertilizer for vibrant flower colors", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Remove dead flowers and debris from the base", dayOffset: 4, category: "Pruning"),
                                        TaskForTheDay(task: "Loosen the topsoil to improve aeration around roots", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Inspect neighboring plants for pests that could spread", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 21",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water evenly to maintain consistent soil moisture", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Deadhead old flowers to promote continuous blooming", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect for signs of root rot or overwatering stress", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a light organic fertilizer to maintain plant energy", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Stake taller plants to prevent bending or breaking", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Check for pests like caterpillars and remove manually if found", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Ensure the planting area is free from weeds", dayOffset: 6, category: "Pruning")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 22",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water plants early in the day to prevent fungal growth", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Remove faded or dried flower heads regularly", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect soil for proper drainage and loosen compact areas", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add a potassium-heavy fertilizer for sustained blooming", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Prune weak or damaged stems to focus energy on healthy ones", dayOffset: 4, category: "Pruning"),
                                        TaskForTheDay(task: "Look for leaf curling or discoloration as a sign of stress", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Monitor flowers for pests like thrips or mites", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 23",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water deeply, ensuring moisture reaches the root zone", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Cut back stems that are no longer producing flowers", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Check for powdery mildew or other fungal diseases", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Add compost or organic mulch to boost soil nutrients", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Remove all weeds and check for invasive plants nearby", dayOffset: 4, category: "Pruning"),
                                        TaskForTheDay(task: "Stake top-heavy plants to prevent them from falling over", dayOffset: 5, category: "Mending"),
                                        TaskForTheDay(task: "Ensure even sunlight distribution to all parts of the plant", dayOffset: 6, category: "Mending")
                                    ]
                                ),
                                Week(
                                    weekNumber: "Week 24",
                                    dailyTasks: [
                                        TaskForTheDay(task: "Water as needed based on soil moisture levels", dayOffset: 0, category: "Watering"),
                                        TaskForTheDay(task: "Deadhead spent flowers to encourage fresh blooms", dayOffset: 1, category: "Pruning"),
                                        TaskForTheDay(task: "Inspect flowers for pest activity and treat if necessary", dayOffset: 2, category: "Mending"),
                                        TaskForTheDay(task: "Apply a final round of potassium-rich fertilizer", dayOffset: 3, category: "Fertilizer"),
                                        TaskForTheDay(task: "Check and adjust plant spacing for airflow and light", dayOffset: 4, category: "Mending"),
                                        TaskForTheDay(task: "Remove any weak or unhealthy stems to improve appearance", dayOffset: 5, category: "Pruning"),
                                        TaskForTheDay(task: "Prepare for the next maintenance cycle as blooms mature", dayOffset: 6, category: "Mending")
                                    ]
                                )
                            ]
                        )

                    ]
                ),
            
        
        Plant(
            id: 3,
            name: "Rose",
            description: "Roses are flowering plants known for their beauty and fragrant blooms.",
            waterRequired: "2-3 times/week",
            temperatureRequired: "15-22°C",
            lightRequired: "Full sunlight",
            image: UIImage(named: "rose1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Rose seeds germinate after cold stratification, requiring moist soil and consistent care.",
                    timeLine: "6 weeks",
                    image: UIImage(named: "roseGermination1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Check soil for adequate moisture", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Mist soil surface to avoid drying", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Ensure seeds are at correct depth", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Monitor temperature between 20-24°C", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Inspect for any mold on soil", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Avoid overwatering to prevent rot", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Loosen compact soil gently if needed", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 2",
                            dailyTasks: [
                                TaskForTheDay(task: "Mist soil lightly to keep moist", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Check for early signs of sprouts", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Ensure pot or tray has drainage", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Remove visible debris from soil", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Keep stratified seeds in warm spot", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Inspect for pests or fungal growth", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Maintain indirect sunlight for warmth", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 3",
                            dailyTasks: [
                                TaskForTheDay(task: "Water only when soil starts drying", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Gently wipe away mold if visible", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Check soil depth for emerging sprouts", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Provide slight air circulation indoors", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Remove small weeds from pot surface", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Inspect sprouts for yellowing leaves", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Ensure sunlight is bright but indirect", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 4",
                            dailyTasks: [
                                TaskForTheDay(task: "Check daily for sprout emergence", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Add moisture if topsoil feels dry", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Avoid soggy soil to prevent damping-off", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Provide gentle light for growing sprouts", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Inspect roots for overcrowding in pots", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Gently remove unhealthy or weak sprouts", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Maintain temperature and humidity levels", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 5",
                            dailyTasks: [
                                TaskForTheDay(task: "Water as needed to prevent dryness", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Thin overcrowded sprouts for better growth", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Monitor sprouts for sturdy stem growth", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Loosen soil gently for healthy roots", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Check for leaf discoloration or pests", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Provide consistent light and warmth daily", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Ensure sprouts have sufficient space", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 6",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sprouts sparingly to avoid rot", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Harden off sprouts gradually outdoors", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Inspect soil and sprouts for pests", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Thin weaker sprouts for stronger growth", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Apply light organic feed for nutrients", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure sprouts receive ample sunlight", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Prepare sprouts for transplantation soon", dayOffset: 6, category: "Mending")
                            ]
                        )
                    ]
                ),
            

                    Stage(
                        Id: 2,
                        name: "Seedling",
                        information: "After germination, rose seedlings begin to grow stronger and develop leaves and stems.",
                        timeLine: "6 weeks",
                        image: UIImage(named: "roseSeedling1") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 7",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water seedlings lightly, not soaking", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure seedlings have indirect sunlight", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Thin out crowded seedlings for space", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for any early pest signs", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Maintain temperature between 18-24°C", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Add a small amount of fertilizer", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove dead or damaged leaves", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 8",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when the soil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure seedlings get at least 4-6 hours of light", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Remove any competing weeds or debris", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests like aphids or mites", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Provide support for taller seedlings", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Apply a balanced fertilizer once", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect seedlings for healthy growth", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 9",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water seedlings thoroughly but not soggy", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Thin out weaker seedlings for better growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for yellowing or drooping leaves", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Provide stakes if seedlings are tall", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Check soil moisture regularly", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead leaves and stems", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Apply a diluted, balanced fertilizer", dayOffset: 6, category: "Fertilizer")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 10",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply when the soil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check leaves for early signs of disease", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Remove weak or unhealthy seedlings", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure seedlings are getting 6-8 hours of light", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Inspect for pests like spider mites", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with a potassium-rich blend", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Loosen compact soil around seedlings", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 11",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply but avoid overwatering", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune any excessive growth or stems", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check seedlings for pests or diseases", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Ensure proper spacing between seedlings", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Add organic mulch to retain moisture", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Provide balanced fertilizer every 10 days", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Monitor seedling height and stability", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 12",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly but do not drown", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove any leggy or weak seedlings", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure seedlings get enough sunlight", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Check for yellowing leaves or spots", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Provide stakes for taller seedlings", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Apply a light organic fertilizer", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Prepare seedlings for transplanting soon", dayOffset: 6, category: "Mending")
                                ]
                            )
                        ]
                    ),

                    Stage(
                        Id: 3,
                        name: "Vegetative Growth",
                        information: "Roses develop strong roots, stems, and foliage during this stage, preparing for blooming.",
                        timeLine: "12 weeks",
                        image: UIImage(named: "roseGrowth1") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 13",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply, but avoid soaking", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove dead or yellowing leaves", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests like aphids", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Provide 6-8 hours of sunlight", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced fertilizer", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Ensure good air circulation", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Prune leggy growth for shape", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 14",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently but not excessively", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove weeds around the base", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check leaves for mold or mildew", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Support taller stems with stakes", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with slow-release granules", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect for early pest signs", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Prune any crossing branches", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 15",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water early in the morning", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for pests like thrips", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Remove damaged or broken branches", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure soil is well-draining", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Add mulch around the base", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with nitrogen-rich fertilizer", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect for fungal infections", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 16",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly but avoid waterlogging", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune to improve plant shape", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for any new pest activity", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced nutrients", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Loosen soil around roots gently", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Remove any yellowing or diseased leaves", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Maintain air circulation for health", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 17",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply once soil is dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune suckers from the base", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect soil for pests and diseases", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with high-potassium mix", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Trim dead wood or stems", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Remove competing weeds around base", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure plants get 6+ hours light", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 18",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water early to prevent fungal growth", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune stems to maintain shape", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests, especially aphids", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced formula", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Mulch around base for moisture retention", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Monitor plant height and adjust support", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Inspect leaves for disease spots", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 19",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water regularly but don't saturate", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune excess growth for shape", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for new pest infestations", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with organic matter", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove spent flowers to promote growth", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for root rot or damage", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Ensure plants get proper sunlight", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 20",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune back to maintain size", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests, especially caterpillars", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced liquid feed", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove any yellowing or dead leaves", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Loosen soil to encourage root growth", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Inspect for fungal growth on leaves", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 21",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply, but don’t drown", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead stems for better growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for powdery mildew on leaves", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Apply a high-potassium fertilizer", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove weeds from around plants", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure healthy air circulation around plants", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Inspect plant health regularly", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 22",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently, avoid waterlogging", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune unwanted shoots and stems", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pest damage on leaves", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced nutrients", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Add mulch for moisture retention", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Check for root health regularly", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Ensure proper spacing between plants", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 23",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly and deeply", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune to encourage healthy growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check leaves for spots or damage", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with slow-release formula", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove spent flowers and stems", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor for early signs of disease", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Keep plants in full sunlight", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 24",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply and regularly", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune for better airflow and shape", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check plants for pests or diseases", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced mix", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove dead leaves and spent flowers", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure proper spacing for growth", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Continue pest and disease monitoring", dayOffset: 6, category: "Mending")
                                ]
                            )
                        ]
                    ),
                    Stage(
                        Id: 4,
                        name: "Flowering",
                        information: "Roses produce beautiful blooms during this stage, requiring regular care to ensure healthy flowers.",
                        timeLine: "12 weeks",
                        image: UIImage(named: "roseBlooming") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 25",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply to promote blooms", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove spent flowers to encourage new", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for aphids on flowers", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Provide 6-8 hours of sunlight", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced fertilizer", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Support heavy flower heads with stakes", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Monitor for disease signs", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 26",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply every 2-3 days", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead flowers to promote new", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for powdery mildew on leaves", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Apply anti-fungal treatment if needed", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with high-phosphorus formula", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove damaged flower stems", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for pests like thrips", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 27",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently but avoid overwatering", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune faded flowers to stimulate growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for spider mites on blooms", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Ensure good airflow around plants", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with balanced feed", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect plants for yellowing leaves", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Remove spent blooms regularly", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 28",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply but allow drying", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune for better bloom distribution", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for signs of black spot", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Provide support for tall flowers", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with organic compost", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove weeds around plants", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for pests regularly", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 29",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently but not excessively", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Deadhead flowers to boost growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Look for early pest infestations", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with slow-release granules", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove any damaged flower buds", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Check for rust on leaves", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Keep plants in full sun", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 30",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when soil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune flowers with spent petals", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect flowers for mold or rot", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove any dead or decayed flowers", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Fertilize with high-potassium formula", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Apply fungicide if needed", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Ensure good air circulation", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 31",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water regularly, avoid soggy soil", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune off faded flowers", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for pest damage on flowers", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove any mildew or mold growth", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with a balanced mix", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Trim away spent flowers", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor plant health daily", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 32",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently, avoid waterlogging", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune for improved bloom production", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for new pest signs", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove dead or decaying leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Apply liquid fertilizer as needed", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect for aphids or mealybugs", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Remove faded flowers to promote rebloom", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 33",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly, allow drying", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Deadhead flowers for better blooms", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for pest or disease signs", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune spent blooms to encourage growth", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Fertilize with high-phosphorus fertilizer", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove wilting or yellowing leaves", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure proper sunlight for flowers", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 34",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune any dead flower stems", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check leaves for rust or spots", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with slow-release nutrients", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Monitor for pest infestations", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Remove any faded or diseased flowers", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect plants for proper air circulation", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 35",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly, avoid waterlogging", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune back spent flowers", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect blooms for damage", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Fertilize with nitrogen-rich feed", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Check for any new pests", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Trim back spent blooms for shape", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure healthy leaf growth", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 36",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water consistently, avoid excess moisture", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead flowers to maintain shape", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for late-season pests", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove faded flowers and leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Fertilize with balanced nutrient formula", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Continue pest monitoring regularly", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Maintain healthy sunlight exposure", dayOffset: 6, category: "Mending")
                                ]
                            )
                        ]
                    ),
                
                    Stage(
                        Id: 5,
                        name: "Dormancy",
                        information: "Roses enter dormancy during colder months, slowing down growth, and need minimal care.",
                        timeLine: "12 weeks",
                        image: UIImage(named: "roseDormancy") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 37",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water lightly if soil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for pests in mulch", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Mulch around base for insulation", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead or damaged branches", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure good air circulation", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Protect from frost if needed", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Check for waterlogged soil", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 38",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water only when soil is dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove fallen leaves and debris", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for mold or fungus", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune any broken stems", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure no pests are overwintering", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Cover with burlap for frost protection", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Monitor for soil moisture", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 39",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water sparingly, not excessively", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure roses are not waterlogged", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Prune away any diseased wood", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check root zone for rot", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Protect from strong winds or frost", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Remove any remaining leaves", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Cover with mulch for insulation", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 40",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water lightly if needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Inspect plants for frost damage", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune any broken canes", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check soil moisture levels", dayOffset: 3, category: "Watering"),
                                    TaskForTheDay(task: "Ensure no mold or rot present", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Inspect for early pest signs", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Apply anti-fungal treatment if needed", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 41",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check moisture in root zone", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Protect plants from frost", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Remove old flower heads", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Reapply mulch if needed", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Prune any diseased canes", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure no pests in mulch", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Monitor for fungal growth", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 42",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check soil for excessive dryness", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead growth for spring", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for early disease signs", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Ensure proper air circulation", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Cover roses if heavy frost", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Check root zone for rot", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Replenish mulch if needed", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 43",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water sparingly, only when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for mold on mulch", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Ensure roses are properly covered", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Inspect plant for damage", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Check for early pests", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead flowers and stems", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure mulch is not too thick", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 44",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check soil moisture levels", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Protect roses from frost", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Inspect plants for diseases", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Trim off damaged growth", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Apply fungicide as a precaution", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Replenish mulch if needed", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Ensure no pests hiding in mulch", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 45",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check moisture in root zone", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure plants are frost-free", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune away dead or broken stems", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for early fungal issues", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Remove old mulch and debris", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Apply light mulch around roots", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Ensure good soil drainage", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 46",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water lightly if needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure roses are not frostbitten", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune spent flowers and stems", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for rot around roots", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Remove any disease-prone stems", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor for any pest infestations", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Reapply mulch for insulation", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 47",
                                dailyTasks: [
                                    TaskForTheDay(task: "Check for frost damage on plants", dayOffset: 0, category: "Mending"),
                                    TaskForTheDay(task: "Water sparingly if needed", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Ensure no mold or rot", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune back any damaged growth", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Check mulch for pests", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Remove any weak or damaged canes", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Replenish mulch if necessary", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 48",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water if soil is too dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for early signs of pests", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune any dead or broken canes", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure frost protection for roses", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Check soil moisture and drainage", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Remove fallen leaves and debris", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Reapply mulch for insulation", dayOffset: 6, category: "Mending")
                                ]
                            )
                        ]
                    )

            ]
        ),
        
        Plant(
            id: 4,
            name: "Snake Plant",
            description: "Snake plants are hardy and low-maintenance houseplants known for their upright, sword-like leaves.",
            waterRequired: "Every 2-4 weeks",
            temperatureRequired: "15-30°C",
            lightRequired: "Low to bright indirect light.",
            image: UIImage(named: "snakePlant") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Snake palm seeds germinate in warm, moist conditions.",
                    timeLine: "4 weeks",
                    image: UIImage(named: "snakeGermination") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Soak seeds in warm water", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Check soil moisture daily", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Keep soil moist but not soggy", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Monitor for mold or pests", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 2",
                            dailyTasks: [
                                TaskForTheDay(task: "Mist the soil lightly", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Remove any mold or rot", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Ensure no standing water", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 6, category: "Mending")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 3",
                            dailyTasks: [
                                TaskForTheDay(task: "Mist soil in morning", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Check for pest presence", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Ensure constant soil moisture", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Remove excess water in tray", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 6, category: "Watering")
                            ]
                        ),
                        Week(
                            weekNumber: "Week 4",
                            dailyTasks: [
                                TaskForTheDay(task: "Mist soil regularly", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Gently thin overcrowded seedlings", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Avoid overwatering seedlings", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Continue checking for pests", dayOffset: 6, category: "Mending")
                            ]
                        )
                    ]
                ),
            

                    Stage(
                        Id: 2,
                        name: "Seedling",
                        information: "Seedlings require steady moisture, light, and space.",
                        timeLine: "8 weeks",
                        image: UIImage(named: "snakeRooting2") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 5",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water seedlings lightly", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 2, category: "Watering"),
                                    TaskForTheDay(task: "Monitor seedling for mold", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove any dead foliage", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Check for early pests", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 6",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water as soil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Avoid waterlogging the soil", dayOffset: 2, category: "Watering"),
                                    TaskForTheDay(task: "Increase air circulation gently", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Check soil moisture daily", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Remove weak or yellow leaves", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor for new pests", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 7",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when top soil is dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Check for any root rot", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove dead leaves or stems", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Increase air circulation slightly", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Inspect for pest damage", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 8",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 1, category: "Fertilizer"),
                                    TaskForTheDay(task: "Check for mold or mildew", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Trim any yellowing leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Monitor for pest infestations", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 9",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water seedlings as needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 1, category: "Fertilizer"),
                                    TaskForTheDay(task: "Prune away damaged leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for any root rot", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Ensure no pests are present", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 10",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water seedlings carefully", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Ensure soil is not soggy", dayOffset: 1, category: "Watering"),
                                    TaskForTheDay(task: "Trim any wilting leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests weekly", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Maintain soil moisture level", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 11",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Prune excess growth if needed", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for new pests or diseases", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Trim off any damaged tips", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 12",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly as needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune any yellowing leaves", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for signs of overwatering", dayOffset: 2, category: "Watering"),
                                    TaskForTheDay(task: "Increase air circulation slightly", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Ensure no pests around seedlings", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Maintain stable moisture levels", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 6, category: "Watering")
                                ]
                            )
                        ]
                    ),

                    Stage(
                        Id: 3,
                        name: "Vegetative Growth",
                        information: "Snake palm focuses on leaf and root development.",
                        timeLine: "24 weeks",
                        image: UIImage(named: "snakeGrowth") ?? UIImage(),
                        task: [
                            Week(
                                weekNumber: "Week 13",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Trim dead leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure good air circulation", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Check soil moisture", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 14",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 1, category: "Fertilizer"),
                                    TaskForTheDay(task: "Check for pest damage", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Remove damaged leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Inspect plant for disease", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 15",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when dry to touch", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for yellowing leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Prune dead or damaged leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Check for mold growth", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Check soil moisture level", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 16",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 1, category: "Fertilizer"),
                                    TaskForTheDay(task: "Check for pests on leaves", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune any dead stems", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 17",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for signs of pests", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Trim off any dying leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Replenish soil moisture as needed", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 6, category: "Fertilizer")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 18",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water carefully, avoid flooding", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Prune back any weak growth", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for overwatering signs", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 4, category: "Fertilizer"),
                                    TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 19",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune any damaged leaves", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Check for pests under leaves", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Trim any excess growth", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 20",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply if dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead or unhealthy leaves", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for root rot signs", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect plant for diseases", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Replenish soil moisture when dry", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 21",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water carefully to avoid flooding", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Prune yellowing or brown leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor pest activity", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 6, category: "Fertilizer")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 22",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water as topsoil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for pest infestations", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Trim damaged or dead leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Increase air circulation slightly", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Maintain consistent moisture levels", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 23",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune any excess growth", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Remove any dead leaves", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Check for mold or pests", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 24",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when topsoil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for signs of root rot", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead stems or leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect for pest activity", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Replenish soil moisture when needed", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 6, category: "Fertilizer")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 25",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for pests weekly", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Trim off damaged leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                    TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 26",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Inspect for mold or mildew", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead leaves or stems", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Check for pests under leaves", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 27",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Prune any yellowing leaves", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor for pest damage", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Trim excess growth if necessary", dayOffset: 5, category: "Pruning"),
                                    TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 28",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for overwatering signs", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune damaged leaves or tips", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect for signs of pests", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Replenish soil moisture as needed", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 29",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water deeply if topsoil dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for mold or mildew", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead or damaged leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect plant for pests weekly", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 6, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 30",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly when topsoil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Trim dead or unhealthy growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check soil moisture levels daily", dayOffset: 2, category: "Watering"),
                                    TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect for pests on stems", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 6, category: "Mending")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 31",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water carefully when soil dries", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for pest damage on leaves", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune dead or yellowing leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 3, category: "Pruning"),
                                    TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset:4, category: "Pruning"),
                                    TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 5, category: "Fertilizer"),
                                    TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 6, category: "Fertilizer")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 32",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly as needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for mold or mildew", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Trim back any overgrowth", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                    TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect for new pests", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 5, category: "Watering")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 33",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water carefully when soil is dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune dead leaves or stems", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Inspect plant for any damage", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 4, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pests on leaves", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 34",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Prune any excess growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 2, category: "Mending"),
                                    TaskForTheDay(task: "Monitor plant for pests daily", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 3, category: "Fertilizer"),
                                    TaskForTheDay(task: "Inspect for pest damage", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 4, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 35",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water thoroughly as needed", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Check for signs of pests", dayOffset: 1, category: "Mending"),
                                    TaskForTheDay(task: "Prune unhealthy or dying leaves", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                    TaskForTheDay(task: "Inspect plant for mold", dayOffset: 5, category: "Mending"),
                                    TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 6, category: "Pruning")
                                ]
                            ),
                            Week(
                                weekNumber: "Week 36",
                                dailyTasks: [
                                    TaskForTheDay(task: "Water when soil is dry", dayOffset: 0, category: "Watering"),
                                    TaskForTheDay(task: "Trim back any dead growth", dayOffset: 1, category: "Pruning"),
                                    TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 2, category: "Pruning"),
                                    TaskForTheDay(task: "Check for pest infestations", dayOffset: 3, category: "Mending"),
                                    TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 4, category: "Mending"),
                                    TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 5, category: "Watering"),
                                    TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 6, category: "Pruning")
                                    ]
                                )

                        ]
                    ),
                

                Stage(
                    Id: 4,
                    name: "Maturity",
                    information: "The plant reaches its mature size and can propagate via rhizomes or offsets.",
                    timeLine: "30 weeks",
                    image: UIImage(named: "snakeMature1") ?? UIImage(),
                    task: [
                        Week(
                                       weekNumber: "Week 37",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Trim dead or yellow leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests weekly", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 5, category: "Fertilizer"),
                                           TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 38",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Prune any damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Inspect for pests and diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 6, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 39",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil is dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Check for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Trim any yellowing leaves", dayOffset: 3, category: "Pruning"),
                                           TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 4, category: "Fertilizer"),
                                           TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 6, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 40",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when topsoil dries", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead leaves and stems", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for mold or mildew", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 4, category: "Fertilizer"),
                                           TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest infestations", dayOffset: 6, category: "Mending")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 41",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Prune dead or damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 3, category: "Fertilizer"),
                                           TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 6, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 42",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check plant for pests weekly", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune yellow or brown leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 3, category: "Fertilizer"),
                                           TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 4, category: "Watering"),
                                           TaskForTheDay(task: "Monitor plant for signs of disease", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 6, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 43",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead or overgrown leaves", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Monitor for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Check for mold or mildew", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 44",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune unhealthy or dead foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 4, category: "Watering"),
                                           TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 6, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 45",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune excess growth", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Inspect plant for diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure consistent watering schedule", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 46",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Inspect for pests under leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune dead or yellowing foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 4, category: "Pruning"),
                                           TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest or mold", dayOffset: 6, category: "Mending")
                                       ]
                                   ),
                              Week(
                                       weekNumber: "Week 47",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Trim dead or yellow leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests weekly", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 5, category: "Fertilizer"),
                                           TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 48",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Prune any damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Inspect for pests and diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 5, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 49",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil is dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Check for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Trim any yellowing leaves", dayOffset: 3, category: "Pruning"),
                                           TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 0, category: "Fertilizer"),
                                           TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 2, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 50",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when topsoil dries", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead leaves and stems", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for mold or mildew", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 4, category: "Fertilizer"),
                                           TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest infestations", dayOffset: 6, category: "Mending")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 51",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Prune dead or damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 0, category: "Fertilizer"),
                                           TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 2, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 52",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check plant for pests weekly", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune yellow or brown leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 3, category: "Fertilizer"),
                                           TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 4, category: "Watering"),
                                           TaskForTheDay(task: "Monitor plant for signs of disease", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 5, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 53",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead or overgrown leaves", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Monitor for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 6, category: "Watering"),
                                           TaskForTheDay(task: "Check for mold or mildew", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 0, category: "Mending"),
                                           TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 1, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 54",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune unhealthy or dead foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 2, category: "Watering"),
                                           TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 5, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 55",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune excess growth", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 0, category: "Mending"),
                                           TaskForTheDay(task: "Inspect plant for diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure consistent watering schedule", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 56",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Inspect for pests under leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune dead or yellowing foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 3, category: "Pruning"),
                                           TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 4, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest or mold", dayOffset: 6, category: "Mending")
                                   
                               ]
                           ),
                                Week(
                                       weekNumber: "Week 57",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Trim dead or yellow leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 6, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests weekly", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 0, category: "Fertilizer"),
                                           TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 1, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 58",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Prune any damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Inspect for pests and diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 5, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 59",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil is dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Check for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Trim any yellowing leaves", dayOffset: 3, category: "Pruning"),
                                           TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 0, category: "Fertilizer"),
                                           TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 2, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 60",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when topsoil dries", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead leaves and stems", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for mold or mildew", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 3, category: "Mending"),
                                           TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 4, category: "Fertilizer"),
                                           TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 5, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest infestations", dayOffset: 6, category: "Mending")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 61",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Prune dead or damaged leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 0, category: "Fertilizer"),
                                           TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 2, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 62",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when soil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check plant for pests weekly", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune yellow or brown leaves", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 3, category: "Fertilizer"),
                                           TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 4, category: "Watering"),
                                           TaskForTheDay(task: "Monitor plant for signs of disease", dayOffset: 5, category: "Mending"),
                                           TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 5, category: "Pruning")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 63",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water deeply when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Trim dead or overgrown leaves", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Monitor for pest damage", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 6, category: "Watering"),
                                           TaskForTheDay(task: "Check for mold or mildew", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 0, category: "Mending"),
                                           TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 1, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 64",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Check for pests on leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune unhealthy or dead foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 2, category: "Watering"),
                                           TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 3, category: "Watering"),
                                           TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 5, category: "Fertilizer")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 65",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water when topsoil feels dry", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Prune excess growth", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 6, category: "Pruning"),
                                           TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 0, category: "Mending"),
                                           TaskForTheDay(task: "Inspect plant for diseases", dayOffset: 4, category: "Mending"),
                                           TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 1, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure consistent watering schedule", dayOffset: 6, category: "Watering")
                                       ]
                                   ),
                                   Week(
                                       weekNumber: "Week 66",
                                       dailyTasks: [
                                           TaskForTheDay(task: "Water thoroughly when needed", dayOffset: 0, category: "Watering"),
                                           TaskForTheDay(task: "Inspect for pests under leaves", dayOffset: 1, category: "Mending"),
                                           TaskForTheDay(task: "Prune dead or yellowing foliage", dayOffset: 2, category: "Pruning"),
                                           TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 2, category: "Mending"),
                                           TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 3, category: "Pruning"),
                                           TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 4, category: "Pruning"),
                                           TaskForTheDay(task: "Inspect for pest or mold", dayOffset: 6, category: "Mending")
                                       ]
                                   ),
                           ]
                       ),
                       
                Stage(
                    Id: 5,
                    name: "Propagation",
                    information: "The plant produces rhizomes or offsets, which can be separated and planted.",
                    timeLine: "Ongoing after maturity",
                    image: UIImage(named: "snakePropagation1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 67",
                            dailyTasks: [
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Gently separate offsets with roots intact.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Avoid overwatering young propagated plants.", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 5,
            name: "Spider Plant",
            description: "Spider plants are hardy houseplants known for their arching leaves and spider-like plantlets.",
            waterRequired: "1-2/week",
            temperatureRequired: "18-24°C",
            lightRequired: "Bright, indirect light.",
            image: UIImage(named: "spiderPlant") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Spider plant seeds germinate within 1 to 3 weeks in moist, well-draining soil.",
                    timeLine: "1-3 weeks",
                    image: UIImage(named: "spiderGermination") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Water lightly to keep the soil moist.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Check soil moisture daily.", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Avoid overwatering to prevent seed rot.", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Seedlings emerge with small green leaves, beginning to establish their root systems.",
                    timeLine: "3-6 weeks",
                    image: UIImage(named: "spiderSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water when the top inch of soil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Do not fertilize during this stage.", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 4, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops more leaves and begins forming its characteristic arching shape.",
                    timeLine: "6-12 weeks",
                    image: UIImage(named: "spiderJuvenile1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply but allow soil to dry between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Apply a diluted balanced fertilizer every two weeks.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove any yellowing or damaged leaves.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 1, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature",
                    information: "The plant reaches full size and produces plantlets on long stolons.",
                    timeLine: "3-12 months",
                    image: UIImage(named: "spiderMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water thoroughly, allowing the soil to dry slightly between watering.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Feed monthly with a balanced fertilizer.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune excess plantlets if not propagating.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 5, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Propagation",
                    information: "Plantlets can be removed and rooted to create new spider plants.",
                    timeLine: "After 1 year",
                    image: UIImage(named: "spiderPropagation") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Cut plantlets using sharp scissors and plant in new pots.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Water lightly to help new roots establish.", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Avoid overwatering to prevent root rot in new plants.", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 6,
            name: "Lily",
            description: "Lilies are elegant flowering plants known for their large, fragrant blooms.",
            waterRequired: "2-3 times/week",
            temperatureRequired: "15-22°C",
            lightRequired: "Full sunlight to partial shade.",
            image: UIImage(named: "lily1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Lily bulbs sprout into shoots within 2-4 weeks after planting.",
                    timeLine: "2-4 weeks",
                    image: UIImage(named: "lilyGermination1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Water thoroughly after planting.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Check soil moisture daily; water as needed.", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 0, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Shoots emerge from the soil and grow steadily.",
                    timeLine: "4-6 weeks",
                    image: UIImage(named: "lilySprouting") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water when the top layer of soil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Apply a balanced fertilizer once a week.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Stake the shoots if they appear unstable.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Keep the soil moist but not soggy.", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops strong stems and leaves, preparing for flowering.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "lilyVegetative1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply and regularly.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Fertilize every two weeks with a balanced fertilizer.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Prune damaged or yellow leaves.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 0, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "The plant blooms with beautiful flowers, lasting several weeks.",
                    timeLine: "Spring to summer",
                    image: UIImage(named: "lilyFlowering1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Deadhead spent blooms to promote continuous flowering.", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Water consistently to keep the soil moist.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Apply a phosphorus-rich fertilizer to encourage blooming.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Cut back on watering slightly as flowers fade.", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 3, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "After flowering, the plant goes dormant to conserve energy for the next season.",
                    timeLine: "Autumn/Winter",
                    image: UIImage(named: "lilyDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Cut back dead foliage after it has yellowed.", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Reduce watering significantly to prevent rot.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 0, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 7,
            name: "Cactus",
            description: "Cacti are drought-tolerant plants known for their spiny stems and ability to store water.",
            waterRequired: "Once every 2-3 weeks",
            temperatureRequired: "18-30°C",
            lightRequired: "Bright, direct sunlight.",
            image: UIImage(named: "cactus1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Cactus seeds germinate in warm, moist conditions within 2-4 weeks.",
                    timeLine: "2-4 weeks",
                    image: UIImage(named: "cactusGermination") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Mist the soil to keep it slightly moist.", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Tiny cactus seedlings appear and develop their first spines.",
                    timeLine: "1-3 months",
                    image: UIImage(named: "cactusSeedling1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly to avoid overwatering.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 5, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The cactus begins to grow larger and more defined spines.",
                    timeLine: "3-6 months",
                    image: UIImage(named: "cactusJuvenile1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply once every 2-3 weeks.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Fertilize once a month with a cactus-specific fertilizer.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 3, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature",
                    information: "The cactus reaches its full size and may produce flowers under ideal conditions.",
                    timeLine: "1-2 years",
                    image: UIImage(named: "cactusMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water only when the soil is completely dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Fertilize every 2-3 months during the growing season.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune dead or damaged parts carefully.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 0, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "During winter, the cactus enters dormancy, conserving energy for the next growth phase.",
                    timeLine: "Winter months",
                    image: UIImage(named: "cactusDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering to once a month or less.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 5, category: "Pruning")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 8,
            name: "Bougainvillea",
            description: "Bougainvillea is a tropical, woody vine known for its vibrant, papery bracts that resemble flowers.",
            waterRequired: "Once every 7-10 days",
            temperatureRequired: "20-35°C",
            lightRequired: "Full sunlight for 6-8 hours daily.",
            image: UIImage(named: "bougainvillea1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Bougainvillea seeds germinate best in warm, moist conditions within 2-3 weeks.",
                    timeLine: "2-3 weeks",
                    image: UIImage(named: "bougainvilleaGermination2") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Mist the soil lightly to maintain moisture.", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 4, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Seedlings develop their first true leaves and begin steady growth.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "bougainvilleaSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly, allowing the soil to dry between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Thin out weaker seedlings to encourage strong growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Begin feeding with diluted liquid fertilizer once a month.", dayOffset: 6, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops vigorous stems and foliage, preparing for flowering.",
                    timeLine: "3-6 months",
                    image: UIImage(named: "bougainvilleaGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply once the soil has dried out completely.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Prune to shape and encourage branching.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply a balanced fertilizer every 2-4 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Trim excess growth to avoid overcrowding.", dayOffset: 6, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "Bougainvillea produces colorful bracts and small, inconspicuous flowers.",
                    timeLine: "Spring to autumn",
                    image: UIImage(named: "bougainvilleaFlowering2") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water only when the soil is completely dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Add a phosphorus-rich fertilizer to boost flowering.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Deadhead faded bracts to promote continuous blooming.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain the desired shape.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 0, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Bougainvillea enters a resting phase, reducing growth activity during winter.",
                    timeLine: "Winter months",
                    image: UIImage(named: "bougainvilleaDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering frequency significantly.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during the dormancy period.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune dead or damaged branches to prepare for spring growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 4, category: "Pruning")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 9,
            name: "Petunia",
            description: "Petunia is a popular flowering annual known for its trumpet-shaped blooms in a wide array of vibrant colors.",
            waterRequired: "When dry",
            temperatureRequired: "18-30°C",
            lightRequired: "Full sunlight for 5-6 hours daily.",
            image: UIImage(named: "petunia") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Petunia seeds germinate best under warm and moist conditions, typically within 7-10 days.",
                    timeLine: "1-2 weeks",
                    image: UIImage(named: "petuniaGermination.") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Lightly mist the soil to maintain consistent moisture.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 3, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Petunia seedlings develop their first true leaves and begin steady growth.",
                    timeLine: "2-4 weeks",
                    image: UIImage(named: "petuniaSeedling1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly, keeping the soil moist but not waterlogged.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Thin out overcrowded seedlings to prevent competition.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Start feeding with a diluted liquid fertilizer every 10-14 days.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 0, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops robust stems and foliage, preparing for flowering.",
                    timeLine: "4-8 weeks",
                    image: UIImage(named: "petuniaGrowth1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply once the top inch of soil is dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Pinch back the growing tips to encourage bushier growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Fertilize with a balanced fertilizer every 2 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Trim any leggy stems to maintain a compact shape.", dayOffset: 6, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "Petunia blooms profusely, displaying colorful, trumpet-shaped flowers.",
                    timeLine: "Spring to autumn",
                    image: UIImage(named: "petuniaFlowering") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water consistently, avoiding wetting the flowers.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Add a bloom-boosting fertilizer every 2-3 weeks.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Deadhead spent blooms to encourage more flowers.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Prune leggy stems to maintain a compact, bushy shape.", dayOffset: 6, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Petunia enters dormancy as growth slows, usually in colder months.",
                    timeLine: "Winter months",
                    image: UIImage(named: "petuniaDormancy1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering significantly as growth slows.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during the dormant period.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Cut back leggy stems to prepare for spring growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 3, category: "Watering")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 10,
            name: "Money Plant",
            description: "The Money Plant, also known as Pothos, is a hardy, fast-growing vine loved for its attractive, heart-shaped leaves and low maintenance.",
            waterRequired: "When dry ",
            temperatureRequired: "15-30°C",
            lightRequired: "Bright, indirect sunlight; tolerates low light.",
            image: UIImage(named: "moneyPlant") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Money plants are typically propagated through cuttings that root in water or soil within 2-4 weeks.",
                    timeLine: "2-4 weeks",
                    image: UIImage(named: "moneyPlantPropagation1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Place the cutting in a jar of clean water, ensuring nodes are submerged.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Mist the cutting lightly to prevent dehydration.", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 1, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "The cutting establishes roots and starts developing new growth.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "moneyPlantEstablishment") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Water thoroughly after planting, allowing excess water to drain.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Maintain consistent moisture but avoid soggy soil.", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 6, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant grows rapidly, developing lush foliage and trailing vines.",
                    timeLine: "2-6 months",
                    image: UIImage(named: "moneyPlantGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the top 1-2 inches of soil are dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Fertilize with a balanced liquid fertilizer once a month.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune any leggy or yellowing stems to encourage bushier growth.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 3, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature",
                    information: "The plant reaches its full potential, with vigorous trailing or climbing growth.",
                    timeLine: "6+ months",
                    image: UIImage(named: "moneyPlantMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water when the topsoil feels dry to the touch.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Fertilize with a nitrogen-rich fertilizer every 6-8 weeks.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune excess growth to maintain a tidy appearance.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Mist leaves during dry weather to increase humidity.", dayOffset: 6, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Growth slows during cooler months, requiring minimal care.",
                    timeLine: "Winter months",
                    image: UIImage(named: "moneyPlantDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering, allowing soil to dry out more between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Prune dead or yellow leaves to maintain plant health.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 3, category: "Watering")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 11,
            name: "Hibiscus",
            description: "Hibiscus is a tropical flowering plant known for its large, showy blooms that come in a variety of colors.",
            waterRequired: "Every 2-3 days",
            temperatureRequired: "18-35°C",
            lightRequired: "Full sunlight for 6-8 hours daily.",
            image: UIImage(named: "hibiscus") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Hibiscus seeds germinate best in warm, moist conditions, usually within 1-2 weeks.",
                    timeLine: "1-2 weeks",
                    image: UIImage(named: "hibiscusGermination") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Water lightly to keep the soil moist but not waterlogged.", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 0, category: "Mending"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 2, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "The seedlings develop their first set of true leaves and begin steady growth.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "hibiscusSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water when the top inch of soil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Thin out weaker seedlings to encourage healthy growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Feed with a diluted liquid fertilizer every 2 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Monitor growth and remove any dead or damaged leaves.", dayOffset: 6, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops vigorous stems and lush foliage, preparing for flowering.",
                    timeLine: "2-6 months",
                    image: UIImage(named: "hibiscusGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the soil surface begins to dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Prune tips of stems to encourage branching.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply a balanced fertilizer every 2-4 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 2, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "Hibiscus blooms with large, vibrant flowers that typically last 1-2 days each.",
                    timeLine: "Spring to autumn",
                    image: UIImage(named: "hibiscusFlowering1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water consistently, ensuring the soil stays moist.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Feed with a phosphorus-rich fertilizer to enhance blooming.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Deadhead spent flowers to encourage more blooms.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Prune excess branches to maintain plant shape.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 5, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Growth slows during cooler months, and the plant may drop leaves.",
                    timeLine: "Winter months",
                    image: UIImage(named: "hibiscusDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering frequency but avoid letting the soil dry completely.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune dead or weak branches to prepare for spring growth.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 2, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 12,
            name: "Mosses-in-Cradle",
            description: "Mosses-in-Cradle, also called Boat Lily, is a low-maintenance, tropical plant known for its rosette-shaped foliage and small white flowers nestled in boat-shaped bracts.",
            waterRequired: "Once the soil feels dry",
            temperatureRequired: "18-30°C",
            lightRequired: "Bright, indirect sunlight; tolerates partial shade.",
            image: UIImage(named: "mossesInCradle") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Mosses-in-Cradle can be propagated via stem cuttings or offsets, which root easily in soil or water.",
                    timeLine: "2-4 weeks",
                    image: UIImage(named: "mossesCradlePropagation") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Mist daily to maintain moisture if using soil.", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 1, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "The plant establishes roots and starts producing new foliage.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "mossesCradleEstablishment") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Water thoroughly and allow excess water to drain.", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Feed with a diluted balanced fertilizer every 2 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Keep soil consistently moist but not waterlogged.", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Remove any yellowing or dead leaves.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 4, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant grows vigorously, producing dense, colorful foliage.",
                    timeLine: "2-6 months",
                    image: UIImage(named: "mossesCradleGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the topsoil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Fertilize monthly with a balanced liquid fertilizer.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Trim leggy growth to encourage bushier foliage.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 1, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "Small white flowers bloom within boat-shaped purple bracts, adding charm to the plant.",
                    timeLine: "Spring to autumn",
                    image: UIImage(named: "mossesCradleFlowering") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water regularly to keep the soil slightly moist.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Feed with a phosphorus-rich fertilizer to encourage blooming.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Deadhead spent flowers to promote continuous blooming.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Remove overgrown stems to maintain a tidy appearance.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 4, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Growth slows during cooler months, with reduced watering and maintenance needs.",
                    timeLine: "Winter months",
                    image: UIImage(named: "mossesCradleDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly, allowing the soil to dry more between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during the dormancy period.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Prune dead or damaged leaves and stems.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 1, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 13,
            name: "Lady Palm",
            description: "Lady Palm, or Rhapis excelsa, is a slow-growing, elegant palm known for its fan-shaped leaves and adaptability to indoor and outdoor environments.",
            waterRequired: "Once soil feels dry",
            temperatureRequired: "16-27°C",
            lightRequired: "Bright, indirect sunlight; tolerates low light.",
            image: UIImage(named: "ladyPalm") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Lady Palm seeds germinate slowly under warm and moist conditions, requiring patience and care.",
                    timeLine: "2-3 months",
                    image: UIImage(named: "ladyPalmGermination1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Keep the soil consistently moist but not waterlogged.", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 0, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Once germinated, seedlings develop their first set of leaves and slowly establish a root system.",
                    timeLine: "3-6 months",
                    image: UIImage(named: "ladyPalmSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly, ensuring the soil remains slightly moist.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Apply a diluted balanced liquid fertilizer monthly.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Remove any yellowing or dead leaves.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 4, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops more leaves and begins forming its characteristic fan-like foliage.",
                    timeLine: "1-3 years",
                    image: UIImage(named: "ladyPalmGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the top 1-2 inches of soil feel dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 5, category: "Mending"),
                                TaskForTheDay(task: "Feed with a slow-release palm fertilizer every 3-4 months.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Prune dead or damaged fronds to maintain aesthetics.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 1, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature",
                    information: "The plant reaches its mature size with dense clusters of fan-shaped leaves, adding elegance to its surroundings.",
                    timeLine: "3+ years",
                    image: UIImage(named: "ladyPalmMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the topsoil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Feed with a balanced fertilizer twice a year during the growing season.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Trim older fronds that turn brown or yellow.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 5, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "During cooler months, the plant’s growth slows, requiring less water and maintenance.",
                    timeLine: "Winter months",
                    image: UIImage(named: "ladyPalmDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering to once every 2-3 weeks.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 0, category: "Pruning"),
                                TaskForTheDay(task: "Prune dead or yellowing fronds to prepare for the growing season.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 2, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        
        Plant(
            id: 14,
            name: "Jade Plant",
            description: "The Jade Plant, or Crassula ovata, is a popular succulent known for its thick, glossy, oval-shaped leaves and easy maintenance.",
            waterRequired: "Every 2-3 weeks",
            temperatureRequired: "18-24°C",
            lightRequired: "Bright, indirect sunlight; tolerates partial sunlight.",
            image: UIImage(named: "jadePlant") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Jade plants can be propagated using leaf or stem cuttings in well-draining soil.",
                    timeLine: "2-6 weeks",
                    image: UIImage(named: "jadePlantPropagation1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Water lightly, ensuring the soil is not soggy.", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 1, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Cuttings develop roots and begin forming new leaves, slowly establishing in the soil.",
                    timeLine: "2-3 months",
                    image: UIImage(named: "jadePlantSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water only when the soil is completely dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing at this stage to prevent overfeeding.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 6, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant grows steadily, producing thick stems and fleshy, oval-shaped leaves.",
                    timeLine: "6-12 months",
                    image: UIImage(named: "jadePlantGrowth1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply but only when the soil is dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Feed with a succulent-specific fertilizer every 4-6 weeks.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune leggy or overcrowded stems to encourage branching.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 1, category: "Watering"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 3, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature Plant",
                    information: "The plant achieves its mature size, displaying dense, bushy growth with thick stems and glossy leaves.",
                    timeLine: "1-3 years",
                    image: UIImage(named: "jadePlantMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply and infrequently; avoid overwatering.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Fertilize every 2-3 months with a succulent fertilizer.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Trim dead or unhealthy leaves to maintain appearance.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 6, category: "Mending"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 0, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "Growth slows during the cooler months, and the plant requires minimal care.",
                    timeLine: "Winter months",
                    image: UIImage(named: "jadePlantDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering to once every 3-4 weeks.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during the dormancy period.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Prune dead or damaged stems in preparation for spring growth.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 4, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 15,
            name: "Lemon Plant",
            description: "The Lemon Plant, a young citrus plant, is known for its aromatic leaves and potential to bear tangy, vibrant yellow fruits.",
            waterRequired: "Deeply once a week",
            temperatureRequired: "15-30°C",
            lightRequired: "Full sunlight for 6-8 hours daily.",
            image: UIImage(named: "lemonPlant") ?? UIImage(),
            isTrending: true,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Lemon seeds germinate best in warm, moist conditions, sprouting tiny shoots within 2-3 weeks.",
                    timeLine: "2-3 weeks",
                    image: UIImage(named: "lemonPlantGermination2") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Mist soil lightly to keep it consistently moist.", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 3, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "The plant develops its first set of true leaves and starts steady growth.",
                    timeLine: "1-3 months",
                    image: UIImage(named: "lemonPlantSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water when the top inch of soil is dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Thin out weaker seedlings if multiple have sprouted.", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Start using a balanced fertilizer once a month.", dayOffset: 4, category: "Fertilizer"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 6, category: "Fertilizer"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 0, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The lemon plant grows vigorously, producing dense foliage and preparing for future flowering.",
                    timeLine: "3-12 months",
                    image: UIImage(named: "lemonPlantGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply but allow soil to dry slightly between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 1, category: "Mending"),
                                TaskForTheDay(task: "Prune to remove dead or overcrowded branches.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply a citrus-specific fertilizer every 4-6 weeks.", dayOffset: 3, category: "Fertilizer"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 4, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "The plant produces fragrant blossoms, signaling the start of fruit development.",
                    timeLine: "Spring to early summer",
                    image: UIImage(named: "lemonPlantFlowering1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply when the soil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Fertilize with a phosphorus-rich citrus fertilizer.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Use rainwater or filtered water for better absorption", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Feed plant with nitrogen-rich fertilizer", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Deadhead faded flowers to encourage continuous blooming.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Add slow-release fertilizer to the soil", dayOffset: 1, category: "Fertilizer")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Fruiting",
                    information: "Lemons begin to form, growing and ripening over several months.",
                    timeLine: "6-9 months",
                    image: UIImage(named: "lemonPlantFruiting1") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply to support fruit development.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Apply potassium-rich fertilizer to boost fruit quality.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Remove smaller or deformed fruits to channel energy to healthy ones.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Water in the early morning for maximum absorption", dayOffset: 4, category: "Watering"),
                                TaskForTheDay(task: "Monitor soil dryness to adjust watering schedule", dayOffset: 5, category: "Watering")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 6,
                    name: "Dormancy",
                    information: "The lemon plant rests during cooler months with minimal growth activity.",
                    timeLine: "Winter months",
                    image: UIImage(named: "lemonPlantDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering to once every 2-3 weeks.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing during dormancy.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune any dead or damaged branches.", dayOffset: 2, category: "Pruning"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Check soil pH before fertilizing", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Avoid over-fertilization to prevent burns", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 2, category: "Pruning")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        Plant(
            id: 16,
            name: "Tomato Plant",
            description: "A popular fruiting plant known for its bright red, juicy tomatoes. It grows best in warm climates with plenty of sunlight.",
            waterRequired: "3-4/week",
            temperatureRequired: "18-25°C",
            lightRequired: "Full sunlight",
            image: UIImage(named: "tomatoPlant") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Tomato seeds typically sprout in 5-10 days when kept in warm, moist conditions.",
                    timeLine: "5-10 days",
                    image: UIImage(named: "tomatoPlantGermination") ?? UIImage(),
                    task: []
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Small seedlings with the first true leaves begin to appear. The plant starts to develop roots.",
                    timeLine: "2-3 weeks",
                    image: UIImage(named: "tomatoPlantSeedling") ?? UIImage(),
                    task: []
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The tomato plant grows larger with more leaves and begins to form stems. The plant becomes bushier as it establishes itself.",
                    timeLine: "4-6 weeks",
                    image: UIImage(named: "tomatoPlantGrowth1") ?? UIImage(),
                    task: []
                ),
                Stage(
                    Id: 4,
                    name: "Flowering",
                    information: "Small yellow flowers appear, signaling the beginning of the fruiting process.",
                    timeLine: "6-8 weeks",
                    image: UIImage(named: "tomatoPlantFlowering1") ?? UIImage(),
                    task: []
                ),
                Stage(
                    Id: 5,
                    name: "Fruiting",
                    information: "Tomato plants begin to produce small green tomatoes, which gradually ripen into bright red fruits.",
                    timeLine: "8-12 weeks",
                    image: UIImage(named: "tomatoPlantFruiting1") ?? UIImage(),
                    task: []
                ),
                Stage(
                    Id: 6,
                    name: "Mature",
                    information: "The tomato plant reaches full size with fully ripe fruits ready for harvest. It continues to produce tomatoes for several months.",
                    timeLine: "2-3 months",
                    image: UIImage(named: "tomatoPlantMature2") ?? UIImage(),
                    task: []
                )
            ]
        ),
        
        Plant(
            id: 17,
            name: "Chinese Evergreen",
            description: "The Chinese Evergreen is a hardy, low-maintenance plant known for its vibrant foliage and adaptability to low light conditions.",
            waterRequired: "Once the soil feel dry",
            temperatureRequired: "18-27°C",
            lightRequired: "Bright, indirect sunlight or low light; avoid direct sunlight.",
            image: UIImage(named: "chineseEvergreen_1") ?? UIImage(),
            isTrending: false,
            stages: [
                Stage(
                    Id: 1,
                    name: "Germination",
                    information: "Chinese Evergreen seeds germinate in moist, warm conditions and can take 4-6 weeks to sprout.",
                    timeLine: "4-6 weeks",
                    image: UIImage(named: "chineseEvergreenGermination") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering if leaves show signs of overwatering", dayOffset: 3, category: "Watering"),
                                TaskForTheDay(task: "Ensure plant gets enough airflow to prevent mold", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Keep the soil moist but not soggy.", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Trim overgrown branches to maintain shape", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Deep water the plant to prevent dehydration", dayOffset: 6, category: "Watering"),
                                TaskForTheDay(task: "Check daily for moisture and mist if the soil surface dries out.", dayOffset: 5, category: "Watering"),
                                TaskForTheDay(task: "Look for any pest infestations and remove them", dayOffset: 0, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 2,
                    name: "Seedling",
                    information: "Seedlings develop their first true leaves and grow steadily with proper care.",
                    timeLine: "1-2 months",
                    image: UIImage(named: "chineseEvergreenSeedling") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water sparingly, allowing the soil to dry slightly between waterings.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove dead leaves to encourage new growth", dayOffset: 1, category: "Pruning"),
                                TaskForTheDay(task: "Fertilize with a diluted liquid fertilizer every two weeks.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Adjust watering based on weather conditions", dayOffset: 2, category: "Watering"),
                                TaskForTheDay(task: "Gently clean leaves to remove dust and debris", dayOffset: 3, category: "Mending"),
                                TaskForTheDay(task: "Thin weaker seedlings to allow stronger ones to thrive.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Thin out dense foliage for better light penetration", dayOffset: 4, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 3,
                    name: "Vegetative Growth",
                    information: "The plant develops a robust root system and new foliage.",
                    timeLine: "3-6 months",
                    image: UIImage(named: "chineseEvergreenGrowth") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water deeply once the top inch of soil feels dry.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Use liquid fertilizer for quick absorption", dayOffset: 5, category: "Fertilizer"),
                                TaskForTheDay(task: "Feed monthly with a balanced fertilizer.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Use clean scissors to avoid infections", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Ensure soil is moist but not waterlogged", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Prune yellowing or damaged leaves.", dayOffset: 5, category: "Pruning"),
                                TaskForTheDay(task: "Prune weak stems to strengthen plant structure", dayOffset: 1, category: "Pruning")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 4,
                    name: "Mature",
                    information: "The Chinese Evergreen reaches its full size, producing lush, patterned leaves.",
                    timeLine: "6-12 months",
                    image: UIImage(named: "chineseEvergreenMature") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Water once the soil becomes dry to the touch.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Remove dead or decaying plant material", dayOffset: 2, category: "Mending"),
                                TaskForTheDay(task: "Feed with a balanced fertilizer every 6-8 weeks.", dayOffset: 2, category: "Fertilizer"),
                                TaskForTheDay(task: "Cut off damaged parts to promote healthier growth", dayOffset: 3, category: "Pruning"),
                                TaskForTheDay(task: "Prune older leaves to encourage new growth.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Inspect leaves for any signs of disease", dayOffset: 4, category: "Mending"),
                                TaskForTheDay(task: "Support weak stems with plant ties", dayOffset: 5, category: "Mending")
                            ]
                        )
                    ]
                ),
                Stage(
                    Id: 5,
                    name: "Dormancy",
                    information: "The plant slows its growth during colder months, requiring less water and fertilizer.",
                    timeLine: "Winter months",
                    image: UIImage(named: "chineseEvergreenDormancy") ?? UIImage(),
                    task: [
                        Week(
                            weekNumber: "Week 1",
                            dailyTasks: [
                                TaskForTheDay(task: "Reduce watering to prevent waterlogging during dormancy.", dayOffset: 0, category: "Watering"),
                                TaskForTheDay(task: "Avoid fertilizing until the growing season resumes.", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Shape the plant to prevent overcrowding", dayOffset: 6, category: "Pruning"),
                                TaskForTheDay(task: "Apply balanced fertilizer for steady growth", dayOffset: 0, category: "Fertilizer"),
                                TaskForTheDay(task: "Prune any yellow or dying leaves.", dayOffset: 4, category: "Pruning"),
                                TaskForTheDay(task: "Use organic compost for soil enrichment", dayOffset: 1, category: "Fertilizer"),
                                TaskForTheDay(task: "Check for root rot and adjust drainage if needed", dayOffset: 2, category: "Mending")
                            ]
                        )
                    ]
                )
            ]
        )
        
    ]
    
    
    
    
    
    
    
    var users: [UserSection] = [
        UserSection(
            userId: 1,
            userName: "Diana",
            email: "diana@example.com",
            location: "Chandigarh",
            userPlants: [
                1: PlantData(addedDate: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, stageId: 1),  // Plant 1 added today, in stage 1
                2: PlantData(addedDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, stageId: 2)   // Plant 2 added today, in stage 2
            ],
            favouritePlantsId: [2, 7],
            recommendedPlantsId: [11, 6, 3],
            password: "123456"
        ),
        UserSection(
            userId: 2,
            userName: "Raj Patel",
            email: "raj.patel@example.com",
            location: "Patiala",
            userPlants: [
                3: PlantData(addedDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, stageId: 1)
            ],
            favouritePlantsId: [2],
            recommendedPlantsId: [2],
            password: "sdbwhunxjs344"
        ),
        UserSection(
            userId: 3,
            userName: "Priya Iyer",
            email: "priya.iyer@example.com",
            location: "Noida, UP",
            userPlants: [
                3: PlantData(addedDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, stageId: 1)   // Plant 3 added today, in stage 1
            ],
            favouritePlantsId: [2],
            recommendedPlantsId: [1],
            password: "smnx bdsh322"
        )
    ]
    private var loggedInUser: UserSection?
    private init() {}
    
    //search screen
    func getAllPlants()->[Plant]{
        return plants
    }
    func getPlantData(id: Int) -> Plant? {
        plants.first { $0.id == id }
    }
    func trendingPlant(from plants: [Plant]) -> [Plant] {
        return plants.filter { $0.isTrending }
    }
    func getAllUsers()->[UserSection]{
        return users
    }
    func plantsInFavourite(userId: Int) -> [Plant]? {
        guard let user = users.first(where: { $0.userId == userId }) else {
            print("User with ID \(userId) not found.")
            return nil
        }
        return plants.filter { user.favouritePlantsId.contains($0.id) }
    }
    func getUser()-> UserSection{
        return loggedInUser!
    }
    
    func userExist(email: String) -> Bool{
        return users.contains(where: { $0.email == email })
    }
    func validateUser(email: String, password: String) -> UserSection? {
        if(userExist(email: email)){
            loggedInUser = users.first{ $0.email == email && $0.password == password }
            return users.first{ $0.email == email && $0.password == password }
        }
        return nil
    }
    
    func updateUser(_ updatedUser: UserSection) {
        // Find the index of the user to update
        if let index = users.firstIndex(where: { $0.userId == updatedUser.userId }) {
            users[index] = updatedUser
            print("User data updated in the data model: \(updatedUser.userName)")
            loggedInUser = users[index]
        } else {
            print("User not found in the data model.")
        }
    }
    
    
    func saveUsersToDefaults() {
        if let encodedUsers = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedUsers, forKey: "users")
        }
    }
    
    func loadUsersFromDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "users"),
           let decodedUsers = try? JSONDecoder().decode([UserSection].self, from: savedData) {
            users = decodedUsers
        }
    }
    func getRecommendation(userId: Int) -> [Plant]? {
        guard let user = users.first(where: { $0.userId == userId }) else {
            print("User with ID \(userId) not found.")
            return nil
        }
        return plants.filter { user.recommendedPlantsId.contains($0.id) }
    }
    
    func plantsInMyPlant(userId: Int) -> [Plant]? {
        guard let user = users.first(where: { $0.userId == userId }) else {
            print("User with ID \(userId) not found.")
            return nil
        }
        return plants.filter { user.userPlants.keys.contains($0.id) }
    }
    func updateUserDetails(userId: Int, newName: String?, newEmail: String?, newLocation: String?) {
        if let index = users.firstIndex(where: { $0.userId == userId }) {
            if let name = newName {
                users[index].userName = name
            }
            if let email = newEmail {
                users[index].email = email
            }
            if let location = newLocation {
                users[index].location = location
            }
            
            print("User details updated: \(users[index])")
            
            // Update logged-in user if it's the same user
            if loggedInUser?.userId == userId {
                loggedInUser = users[index]
            }
        } else {
            print("User with ID \(userId) not found.")
        }
    }


    
    
    
    func calculateNewDate(from currentDate: Date, for task: TaskForTheDay) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: task.dayOffset, to: currentDate)
    }
   
    
//    func addPlantToFavourite(plantId: Int, userId: Int) {
//        guard let plant = plants.first(where: { $0.id == plantId }),
//              var user = users.first(where: { $0.userId == userId }) else {
//            print("Plant or User not found.")
//            return
//        }
//        if !user.favouritePlantsId.contains(plantId) {
//            user.favouritePlantsId.append(plantId)
//            if let userIndex = users.firstIndex(where: { $0.userId == userId }) {
//                users[userIndex] = user
//            }
//            print("\(plant.name) added to \(user.userName)'s favourite plants.")
//        } else {
//            print("\(plant.name) is already in \(user.userName)'s favourite plants.")
//        }
//    }
    
    //    func addPlantToMyPlants(plantId: Int, userId: Int) {
    //        guard let plant = plants.first(where: { $0.id == plantId }),
    //              var user = users.first(where: { $0.userId == userId }) else {
    //            print("Plant or User not found.")
    //            return
    //        }
    //
    //        if !user.userPlants.keys.contains(plantId) {
    //            let currentDate = Date()
    //            let someIntegerValue = 0
    //
    //            user.userPlants[plantId] = (currentDate, someIntegerValue)
    //
    //            if let userIndex = users.firstIndex(where: { $0.userId == userId }) {
    //                users[userIndex] = user
    //            }
    //
    //            print("\(plant.name) added to \(user.userName)'s plants.")
    //        } else {
    //            print("\(plant.name) is already in \(user.userName)'s plants.")
    //        }
    //    }
    //
    //
    
    
    //Home screen
   
    
    //    func getPlantTasksByCategory(
    //        userId: Int,
    //        category: String,
    //        date: Date
    //   ) -> [(plantName: String, plantImage: UIImage?, tasks: [TaskForTheDay])] {
    //        guard let userSection = users.first(where: { $0.userId == userId }) else {
    //            print("User with ID \(userId) not found.")
    //            return []
    //        }
    //        var result: [(plantName: String, plantImage: UIImage?, tasks: [TaskForTheDay])] = []
    //        for (userPlantId, userPlantData) in userSection.userPlants {
    //            guard let plant = plants.first(where: { $0.id == userPlantId }),
    //                  let currentStage = plant.stages.first(where: { $0.Id == userPlantData.1 }) else {
    //                continue
    //            }
    //            let plantTasks = currentStage.task.flatMap { $0.dailyTasks.filter { $0.category == category } }
    //            if !plantTasks.isEmpty {
    //                result.append((plantName: plant.name, plantImage: plant.image, tasks: plantTasks))
    //            }
    //        }
    //        return result
    //    }
    
    
    //    func removePlantFromUser(userId: String, plantId: String) {
    //        // Logic to remove the plant from the user's data (e.g., remove it from userPlants dictionary)
    //        if var user = users.first(where: { $0.userId == userId }) {
    //            user.userPlants.removeValue(forKey: plantId)
    //        }
    //    }
    
    //    func getTasksForWeekAndDate(plantId: Int, weekNumber: String, currentDate: Date) -> [(task: String, date: Date)]? {
    //        guard let plant = plants.first(where: { $0.id == plantId }) else {
    //            print("Plant with ID \(plantId) not found.")
    //            return nil
    //        }
    //
    //        guard let user = users.first(where: { $0.userPlants.keys.contains(plantId) }),
    //              let currentStageId = user.userPlants[plantId]?.1 else {
    //            print("No user found with this plant in My Plants.")
    //            return nil
    //        }
    //
    //        guard let currentStage = plant.stages.first(where: { $0.Id == currentStageId }) else {
    //            print("Current stage for Plant ID \(plantId) not found.")
    //            return nil
    //        }
    //
    //        var tasksForWeekAndDate: [(task: String, date: Date)] = []
    //        if let week = currentStage.task.first(where: { $0.weekNumber == weekNumber }) {
    //            for dailyTask in week.dailyTasks {
    //                if let newDate = calculateNewDate(from: currentDate, for: dailyTask) {
    //                    tasksForWeekAndDate.append((task: dailyTask.task, date: newDate))
    //                }
    //            }
    //        }
    //
    //        return tasksForWeekAndDate.isEmpty ? nil : tasksForWeekAndDate
    //    }
}
