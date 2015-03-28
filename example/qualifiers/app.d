import poodinis.dependency;

import std.stdio;

interface Engine {
	public void engage();
}

class FuelEngine : Engine {
	public void engage() {
		writeln("VROOOOOOM!");
	}
}

class ElectricEngine : Engine {
	public void engage() {
		writeln("hummmmmmmm....");
	}
}

class HybridCar {
	alias KilometersPerHour = int;

	@Autowire!FuelEngine
	public Engine fuelEngine;

	@Autowire!ElectricEngine
	public Engine electricEngine;

	public void moveAtSpeed(KilometersPerHour speed) {
		if (speed <= 45) {
			electricEngine.engage();
		} else {
			fuelEngine.engage();
		}
	}
}

void main() {
	auto dependencies = DependencyContainer.getInstance();

	dependencies.register!HybridCar;
	dependencies.register!(Engine, FuelEngine);
	dependencies.register!(Engine, ElectricEngine);

	auto car = dependencies.resolve!HybridCar;

	car.moveAtSpeed(10); // Should print "hummmmmmmm...."
	car.moveAtSpeed(50); // Should print "VROOOOOOM!"
}