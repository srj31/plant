class ParamDelta {
  final double deltaHealth;
  final double deltaMorale;
  final double deltaCarbon;
  final double deltaResources;
  final double deltaEnergy;
  final double deltaCapital;

  ParamDelta(
      {required this.deltaHealth,
      required this.deltaMorale,
      required this.deltaCarbon,
      required this.deltaResources,
      required this.deltaEnergy,
      required this.deltaCapital});

  ParamDelta.zero()
      : deltaHealth = 0,
        deltaMorale = 0,
        deltaCarbon = 0,
        deltaResources = 0,
        deltaEnergy = 0,
        deltaCapital = 0;

  ParamDelta operator +(ParamDelta other) {
    return ParamDelta(
        deltaHealth: deltaHealth + other.deltaHealth,
        deltaMorale: deltaMorale + other.deltaMorale,
        deltaCarbon: deltaCarbon + other.deltaCarbon,
        deltaResources: deltaResources + other.deltaResources,
        deltaEnergy: deltaEnergy + other.deltaEnergy,
        deltaCapital: deltaCapital + other.deltaCapital);
  }

  ParamDelta operator -(ParamDelta other) {
    return ParamDelta(
        deltaHealth: deltaHealth - other.deltaHealth,
        deltaMorale: deltaMorale - other.deltaMorale,
        deltaCarbon: deltaCarbon - other.deltaCarbon,
        deltaResources: deltaResources - other.deltaResources,
        deltaEnergy: deltaEnergy - other.deltaEnergy,
        deltaCapital: deltaCapital - other.deltaCapital);
  }

  ParamDelta operator *(double other) {
    return ParamDelta(
        deltaHealth: deltaHealth * other,
        deltaMorale: deltaMorale * other,
        deltaCarbon: deltaCarbon * other,
        deltaResources: deltaResources * other,
        deltaEnergy: deltaEnergy * other,
        deltaCapital: deltaCapital * other);
  }

  @override
  String toString() {
    return 'ParamDelta( health: $deltaHealth, morale: $deltaMorale, carbon: $deltaCarbon, resources: $deltaResources, energy: $deltaEnergy, capital: $deltaCapital)';
  }
}
