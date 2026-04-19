extends Node

const MAX_DAYS: int = 2

const HORF_DICT: Dictionary = {
	0: {
		"odds_to_one": 1,
		"low_speed": 15,
		"high_speed": 30,
		"lock_in_likelihood": 0.45,
	},
	1: {
		"odds_to_one": 2,
		"low_speed": 14,
		"high_speed": 30,
		"lock_in_likelihood": 0.4,
	},
	2: {
		"odds_to_one": 4,
		"low_speed": 13,
		"high_speed": 27.5,
		"lock_in_likelihood": 0.4,
	},
	3: {
		"odds_to_one": 8,
		"low_speed": 12,
		"high_speed": 25,
		"lock_in_likelihood": 0.35,
	},
	4: {
		"odds_to_one": 16,
		"low_speed": 10,
		"high_speed": 23,
		"lock_in_likelihood": 0.3,
	},
	5: {
		"odds_to_one": 24,
		"low_speed": 8,
		"high_speed": 22,
		"lock_in_likelihood": 0.2,
	},
	6: {
		"odds_to_one": 32,
		"low_speed": 5,
		"high_speed": 20,
		"lock_in_likelihood": 0.2,
	},
	7: {
		"odds_to_one": 64,
		"low_speed": 4,
		"high_speed": 18,
		"lock_in_likelihood": 0.1,
	},
}

const HORF_FIRST_NAME_ARRAY: Array = [
	"Rice And",
	"Beans On",
	"My Little",
	"Sour",
	"Monday's",
	"Princess",
	"Horny",
	"I Hate",
	"Monstrous",
	"Shotgun",
	"Copyright",
	"Robot",
	"Angry",
	"Punk-Rock",
	"Absolutely Not A",
	"Alcoholic",
	"Left-Handed",
	"Outside There Is",
	"Four Legs Of",
	"Big Dog",
	"Professional",
	"Meme-Named",
	"Milkshake",
	"Ludum",
	"Smooth-brained",
	"Artificial",
	"Disaster",
	"Unemployed",
	"Sir",
	"The Incomparable",
	"Bobby",
	"The Undrowned",
	"Pillar Of",
	"Clever",
]

const HORF_LAST_NAME_ARRAY: Array = [
	"Beans",
	"Toast",
	"Horfy",
	"Lasagna",
	"Dumptruck",
	"Toad",
	"Wellington III",
	"Shotglass",
	"Axolotl",
	"Candy",
	"Wedding",
	"Sandwich",
	"Infringement",
	"Godot",
	"Duck",
	"Dog",
	"Dare",
	"Engineer",
	"Clanker",
	"Battery Eater",
	"Snowball Tosser",
	"Bisexual",
	"Nothing",
	"ERROR",
	"Twitch Streamer",
	"Salt",
	"Necrobinder",
	"Girl",
	"Winner",
]


@onready var current_money: int = 5000
@onready var current_day: int = 1

@onready var main_volume: float = 0.8
@onready var sfx_volume: float = 0.8
@onready var music_volume: float = 0.8


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
