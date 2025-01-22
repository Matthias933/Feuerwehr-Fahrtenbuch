export class RideDto {
  id: number;
  carId: number;
  driverId: number;
  commanderId: number;
  rideTypeId: number;
  date: string;
  rideDescription: string;
  kilometerStart: number;
  kilometerEnd: number;
  gasLiter: number;
  usedPowerGenerator: boolean;
  powerGeneratorTankFull: boolean;
  usedRespiratoryProtection: boolean;
  respiratoryProtectionUpgraded: boolean;
  usedCAFS: boolean;
  cafsTankFull: boolean;
  defects: string;
  missingItems: string;
}
