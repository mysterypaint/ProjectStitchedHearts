function init_portraits() {
	portraits = ds_create("portraits", DS.MAP);

	enum PortInds {
		BLANK,
		BELL_SMIRK,
		BELL_SMILE,
		BELL_ANNOYED,
		BELL_ANGERY,
		BELL_SURPRISED,
		BELL_SHOCKED,
		BELL_UNCERTAIN,
		OCT_NEUTRAL,
		OCT_SWEATDROP,
		THE_BOSS_NEUTRAL,
		THE_BOSS_HAPPY,
		BELL_TICKED_SMILE
	}

	//BellSmirk
	port_eye_pos_x[PortInds.BELL_SMIRK] = 0;
	port_eye_pos_y[PortInds.BELL_SMIRK] = 0;
	port_mouth_pos_x[PortInds.BELL_SMIRK] = 0;
	port_mouth_pos_y[PortInds.BELL_SMIRK] = 0;
	port_mouth_spr[PortInds.BELL_SMIRK] = sprBlank;
	port_eye_spr[PortInds.BELL_SMIRK] = sprBlank;
	port_face_spr[PortInds.BELL_SMIRK] = sprBlank;

	//BellSmile
	port_eye_pos_x[PortInds.BELL_SMILE] = 0;
	port_eye_pos_y[PortInds.BELL_SMILE] = 0;
	port_mouth_pos_x[PortInds.BELL_SMILE] = 0;
	port_mouth_pos_y[PortInds.BELL_SMILE] = 0;
	port_mouth_spr[PortInds.BELL_SMILE] = sprBlank;
	port_eye_spr[PortInds.BELL_SMILE] = sprBlank;
	port_face_spr[PortInds.BELL_SMILE] = sprBlank;

	//BellAnnoyed
	port_eye_pos_x[PortInds.BELL_ANNOYED] = 0;
	port_eye_pos_y[PortInds.BELL_ANNOYED] = 0;
	port_mouth_pos_x[PortInds.BELL_ANNOYED] = 0;
	port_mouth_pos_y[PortInds.BELL_ANNOYED] = 0;
	port_mouth_spr[PortInds.BELL_ANNOYED] = sprBlank;
	port_eye_spr[PortInds.BELL_ANNOYED] = sprBlank;
	port_face_spr[PortInds.BELL_ANNOYED] = sprBlank;

	//BellAngery
	port_eye_pos_x[PortInds.BELL_ANGERY] = 0;
	port_eye_pos_y[PortInds.BELL_ANGERY] = 0;
	port_mouth_pos_x[PortInds.BELL_ANGERY] = 0;
	port_mouth_pos_y[PortInds.BELL_ANGERY] = 0;
	port_mouth_spr[PortInds.BELL_ANGERY] = sprBlank;
	port_eye_spr[PortInds.BELL_ANGERY] = sprBlank;
	port_face_spr[PortInds.BELL_ANGERY] = sprBlank;

	//BellSurprised
	port_eye_pos_x[PortInds.BELL_SURPRISED] = 0;
	port_eye_pos_y[PortInds.BELL_SURPRISED] = 0;
	port_mouth_pos_x[PortInds.BELL_SURPRISED] = 0;
	port_mouth_pos_y[PortInds.BELL_SURPRISED] = 0;
	port_mouth_spr[PortInds.BELL_SURPRISED] = sprBlank;
	port_eye_spr[PortInds.BELL_SURPRISED] = sprBlank;
	port_face_spr[PortInds.BELL_SURPRISED] = sprBlank;

	//BellSurprised
	port_eye_pos_x[PortInds.BELL_SHOCKED] = 0;
	port_eye_pos_y[PortInds.BELL_SHOCKED] = 0;
	port_mouth_pos_x[PortInds.BELL_SHOCKED] = 0;
	port_mouth_pos_y[PortInds.BELL_SHOCKED] = 0;
	port_mouth_spr[PortInds.BELL_SHOCKED] = sprBlank;
	port_eye_spr[PortInds.BELL_SHOCKED] = sprBlank;
	port_face_spr[PortInds.BELL_SHOCKED] = sprBlank;

	//BellUncertain
	port_eye_pos_x[PortInds.BELL_UNCERTAIN] = 0;
	port_eye_pos_y[PortInds.BELL_UNCERTAIN] = 0;
	port_mouth_pos_x[PortInds.BELL_UNCERTAIN] = 0;
	port_mouth_pos_y[PortInds.BELL_UNCERTAIN] = 0;
	port_mouth_spr[PortInds.BELL_UNCERTAIN] = sprBlank;
	port_eye_spr[PortInds.BELL_UNCERTAIN] = sprBlank;
	port_face_spr[PortInds.BELL_UNCERTAIN] = sprBlank;

	//OctNeutral
	port_eye_pos_x[PortInds.OCT_NEUTRAL] = 0;
	port_eye_pos_y[PortInds.OCT_NEUTRAL] = 0;
	port_mouth_pos_x[PortInds.OCT_NEUTRAL] = 0;
	port_mouth_pos_y[PortInds.OCT_NEUTRAL] = 0;
	port_mouth_spr[PortInds.OCT_NEUTRAL] = sprBlank;
	port_eye_spr[PortInds.OCT_NEUTRAL] = sprBlank;
	port_face_spr[PortInds.OCT_NEUTRAL] = sprBlank;


	//OctSweatdrop
	port_eye_pos_x[PortInds.OCT_SWEATDROP] = 0;
	port_eye_pos_y[PortInds.OCT_SWEATDROP] = 0;
	port_mouth_pos_x[PortInds.OCT_SWEATDROP] = 0;
	port_mouth_pos_y[PortInds.OCT_SWEATDROP] = 0;
	port_mouth_spr[PortInds.OCT_SWEATDROP] = sprBlank;
	port_eye_spr[PortInds.OCT_SWEATDROP] = sprBlank;
	port_face_spr[PortInds.OCT_SWEATDROP] = sprBlank;

	//TheBossNeutral
	port_eye_pos_x[PortInds.THE_BOSS_NEUTRAL] = 0;
	port_eye_pos_y[PortInds.THE_BOSS_NEUTRAL] = 0;
	port_mouth_pos_x[PortInds.THE_BOSS_NEUTRAL] = 0;
	port_mouth_pos_y[PortInds.THE_BOSS_NEUTRAL] = 0;
	port_mouth_spr[PortInds.THE_BOSS_NEUTRAL] = sprBlank;
	port_eye_spr[PortInds.THE_BOSS_NEUTRAL] = sprBlank;
	port_face_spr[PortInds.THE_BOSS_NEUTRAL] = sprBlank;

	//TheBossHappy
	port_eye_pos_x[PortInds.THE_BOSS_HAPPY] = 0;
	port_eye_pos_y[PortInds.THE_BOSS_HAPPY] = 0;
	port_mouth_pos_x[PortInds.THE_BOSS_HAPPY] = 0;
	port_mouth_pos_y[PortInds.THE_BOSS_HAPPY] = 0;
	port_mouth_spr[PortInds.THE_BOSS_HAPPY] = sprBlank;
	port_eye_spr[PortInds.THE_BOSS_HAPPY] = sprBlank;
	port_face_spr[PortInds.THE_BOSS_HAPPY] = sprBlank;

	//BellTickedSmile
	port_eye_pos_x[PortInds.BELL_TICKED_SMILE] = 0;
	port_eye_pos_y[PortInds.BELL_TICKED_SMILE] = 0;
	port_mouth_pos_x[PortInds.BELL_TICKED_SMILE] = 0;
	port_mouth_pos_y[PortInds.BELL_TICKED_SMILE] = 0;
	port_mouth_spr[PortInds.BELL_TICKED_SMILE] = sprBlank;
	port_eye_spr[PortInds.BELL_TICKED_SMILE] = sprBlank;
	port_face_spr[PortInds.BELL_TICKED_SMILE] = sprBlank;



}
