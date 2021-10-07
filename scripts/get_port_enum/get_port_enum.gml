/// @description Returns the proper PortInds enum value, based on the input string
/// @param in_string
function get_port_enum(argument0) {
	var _in_str = argument0;

	switch(_in_str) {
		case "BellSmirk":
			return PortInds.BELL_SMIRK;
		case "BellSmile":
			return PortInds.BELL_SMILE;
		case "BellAnnoyed":
			return PortInds.BELL_ANNOYED;
		case "BellAngery":
			return PortInds.BELL_ANGERY;
		case "BellSurprised":
			return PortInds.BELL_SURPRISED;
		case "BellShocked":
			return PortInds.BELL_SHOCKED;
		case "BellUncertain":
			return PortInds.BELL_UNCERTAIN;
		case "OctNeutral":
			return PortInds.OCT_NEUTRAL;
		case "OctSweatdrop":
			return PortInds.OCT_SWEATDROP;
		case "TheBossNeutral":
			return PortInds.THE_BOSS_NEUTRAL;
		case "TheBossHappy":
			return PortInds.THE_BOSS_HAPPY;
		case "BellTickedSmile":
			return PortInds.BELL_TICKED_SMILE;
		default:
			return PortInds.BLANK;
	}


}
