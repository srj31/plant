import 'package:flutter/material.dart';
import 'package:game_name/game/main_menu.dart';

class GameTutorial extends StatelessWidget {
  const GameTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                      onTap: () => Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainMenu()),
                          ),
                      child: Text("Back"))),
              const SizedBox(
                  height: 100.0,
                  width: 600.0,
                  child: Row(children: [
                    Expanded(
                        child: Text(
                            "Welcome to 'Plant Inc'! In this tutorial, you'll learn the basics of how to save the Earth from environmental destruction. If the health of the earth reaches 0 or the morale of the community you are trying to build falls to 0 you lose. To progress to the next stage build structures, pass laws and invest in research to bring back the health to 100."))
                  ])),
              SizedBox(
                  height: 200.0,
                  width: 600.0,
                  child: Row(children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Infobox(
                              text: """
Health: Earth's overall well-being. If it plummets to zero, it's game over. Keep a close eye on this vital parameter to ensure the planet remains healthy and resilient.

Capital: The lifeblood of your operations. Use it to fund construction projects, policy initiatives, and research endeavors. Manage your capital wisely to maximize your impact.

Carbon Emission: A measure of greenhouse gas emissions. Monitor and control carbon emissions to mitigate climate change, reduce pollution, and safeguard the environment.

Morale: Public sentiment towards environmental initiatives. Higher morale makes it easier to pass policies and implement changes, while low morale can lead to resistance and opposition.

Resources: Essential materials for construction and research. Balance resource usage to ensure sustainable development and avoid depletion of Earth's natural assets.

Energy: The driving force behind civilization. Maintain a stable energy supply to power your structures, support research efforts, and sustain the needs of a growing population.

                              """,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/parameters.png"))
                  ])),
              SizedBox(
                  height: 200.0,
                  width: 600.0,
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/overlay.png")),
                    Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Infobox(text: """
In Plant Inc., you have the power to shape the future of the planet through a variety of actions:
              
Building Structures: Utilize your capital and resources to construct essential infrastructure, such as renewable energy facilities, waste management systems, and eco-friendly transportation networks. Each structure plays a crucial role in promoting sustainability and combating environmental degradation.
                  
Passing Policies: Enact policies to address pressing environmental issues and promote sustainable practices. From carbon pricing mechanisms to biodiversity conservation measures, your policies can have far-reaching impacts on Earth's health and resilience.
                  
Investing in Research: Advance scientific knowledge and technological innovation to tackle complex environmental challenges. Explore new technologies, develop sustainable solutions, and push the boundaries of environmental science to ensure a brighter future for generations to come.
                            """),
                            )))
                  ])),
              SizedBox(
                  height: 100.0,
                  width: 600.0,
                  child: Row(children: [
                    Expanded(flex: 3, child: Infobox(text: """
Stay vigilant for unforeseen events triggered by parameter thresholds:

Natural Disasters: Earthquakes, hurricanes, floods, and other natural disasters can occur if certain parameters fall below critical thresholds. Prepare disaster response plans and invest in infrastructure to mitigate their impact.

Disease Outbreaks: Declining health or resource shortages may trigger disease outbreaks that threaten ecosystems and human populations. Implement measures to prevent the spread of diseases and protect vulnerable species.
                            """)),
                    Expanded(flex: 1, child: Text("Images go here")),
                  ])),
              SizedBox(
                  height: 100.0,
                  width: 600.0,
                  child: Expanded(
                    child: Text("""
As you embark on your journey with Plant Inc., remember that the fate of the planet rests in your hands. Balance parameters, make strategic decisions, and lead Earth towards a sustainable future. Are you ready to take on the challenge and become a champion of the environment? The fate of the planet depends on you!
"""),
                  ))
            ],
          )),
        )));
  }
}

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}
