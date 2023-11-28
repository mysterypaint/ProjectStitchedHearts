game_set_speed(60, gamespeed_fps);

enum Fonts {
	DLG,
	DLG_I
}

enum DirInput { // For player movement input
	IDLE,
	DOWN,
	LEFT,
	UP,
	RIGHT,
	DOWN_LEFT,
	UP_LEFT,
	DOWN_RIGHT,
	UP_RIGHT
}

enum Facing {
	DOWN,
	LEFT,
	UP,
	RIGHT
}

enum DS {
	MAP,
	LIST,
	GRID
}