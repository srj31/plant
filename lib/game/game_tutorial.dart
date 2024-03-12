import 'package:flutter/material.dart';
import 'package:game_name/game/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTutorial extends StatelessWidget {
  const GameTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SingleChildScrollView(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade900,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.0, 0.0),
                                    ),
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Back"),
                              )))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: width * 0.7,
                        child: Flex(direction: Axis.horizontal, children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.green.shade600, width: 5.0),
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Infobox(
                                widget: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily:
                                                GoogleFonts.play().fontFamily),
                                        text:
                                            "Welcome to 'Plant'! In this tutorial, you'll learn the basics of how to save the Earth from environmental destruction. If the health of the earth reaches 0 or the morale of the community you are trying to build falls to 0 you lose. To progress to the next stage build structures, pass laws and invest in research to bring back the health to 100.")),
                              ),
                            ),
                          ))
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * 0.7,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green.shade600, width: 5.0),
                                  color: Colors.green.shade900,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Infobox(
                                      widget: RichText(
                                    text: TextSpan(
                                        text:
                                            "The main gameplay revolves around the various resources and parameters as described below\n\n",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily:
                                                GoogleFonts.play().fontFamily),
                                        children: const [
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Health",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": Earth's overall well-being. If it plummets to zero, it's game over. Keep a close eye on this vital parameter to ensure the planet remains healthy and resilient.\n\n")
                                          ]),
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Capital",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": The lifeblood of your operations. Use it to fund construction projects, policy initiatives, and research endeavors. Manage your capital wisely to maximize your impact.\n\n")
                                          ]),
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Carbon Emission",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": A measure of greenhouse gas emissions. Monitor and control carbon emissions to mitigate climate change, reduce pollution, and safeguard the environment.\n\n")
                                          ]),
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Morale",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": Public sentiment towards environmental initiatives. Higher morale makes it easier to pass policies and implement changes, while low morale can lead to resistance and opposition.\n\n")
                                          ]),
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Resources",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": Essential materials for construction and research. Balance resource usage to ensure sustainable development and avoid depletion of Earth's natural assets.\n\n")
                                          ]),
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Energy",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    ": The driving force behind civilization. Maintain a stable energy supply to power your structures, support research efforts, and sustain the needs of a growing population.")
                                          ]),
                                        ]),
                                  )),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Image.asset("assets/images/parameters.png",
                                  fit: BoxFit.cover))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * 0.7,
                      child: Flex(direction: Axis.horizontal, children: [
                        Expanded(
                            flex: 1,
                            child: Image.asset(
                              "assets/images/overlay.png",
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green.shade600, width: 5.0),
                                  color: Colors.green.shade900,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Infobox(
                                      widget: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts.play()
                                                      .fontFamily),
                                              text:
                                                  "In Plant, you have the power to shape the future of the planet through a variety of actions:\n\n",
                                              children: const [
                                        TextSpan(children: [
                                          TextSpan(
                                              text: "Building Structures",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ": Utilize your capital and resources to construct essential infrastructure, such as renewable energy facilities, waste management systems, and eco-friendly transportation networks. Each structure plays a crucial role in promoting sustainability and combating environmental degradation. There are non-green alternatives which provide short term benenfits but could lead to trouble in the future.\n\n"),
                                        ]),
                                        TextSpan(children: [
                                          TextSpan(
                                              text: "Passing Policies",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ": Enact policies to address pressing environmental issues and promote sustainable practices. From carbon pricing mechanisms to biodiversity conservation measures, your policies can have far-reaching impacts on Earth's health and resilience. Policies provide significant boost to the parameter increase.\n\n"),
                                        ]),
                                        TextSpan(children: [
                                          TextSpan(
                                              text: "Invest in Research",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ": Explore new technologies, develop sustainable solutions, and push the boundaries of environmental science to ensure a brighter future for generations to come. Each research would improve the parameters for each of the built structures making them more effective."),
                                        ]),
                                      ]))),
                                )))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * 0.7,
                      child: Flex(direction: Axis.horizontal, children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green.shade600, width: 5.0),
                                color: Colors.green.shade900,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Infobox(
                                    widget: RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts.play()
                                                    .fontFamily),
                                            text:
                                                "Stay vigilant for unforeseen events triggered by parameter thresholds:\n\n",
                                            children: const [
                                      TextSpan(children: [
                                        TextSpan(children: [
                                          TextSpan(
                                              text: "Natural Disasters",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ": Earthquakes, hurricanes, floods, and other natural disasters can occur if certain parameters fall below critical thresholds. Prepare disaster response plans and invest in infrastructure to mitigate their impact.\n\n")
                                        ]),
                                        TextSpan(
                                            text: "Disease Outbreaks",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ": Declining health or resource shortages may trigger disease outbreaks that threaten ecosystems and human populations. Implement measures to prevent the spread of diseases and protect vulnerable species. ")
                                      ]),
                                    ]))),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Image.asset("assets/images/disasters.png",
                                fit: BoxFit.cover)),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: width * 0.7,
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.green.shade600, width: 5.0),
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Infobox(
                                widget: Text(
                                  """
As you embark on your journey with Plant, remember that the fate of the planet rests in your hands. Balance parameters, make strategic decisions, and lead Earth towards a sustainable future. Are you ready to take on the challenge and become a champion of the environment? The fate of the planet depends on you!
                  """,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily:
                                          GoogleFonts.play().fontFamily),
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          )),
        )));
  }
}

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget,
      ),
    );
  }
}
