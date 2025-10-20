extends Node

#current_main_scene pour charger la scène
#previous_level garde en mémoire le chemin de la dernière scène (à voir si c'est utile pour nos besoins)
var current_main_scene : PackedScene
var previous_main_scene : String

var can_move := true
var dev_mode := false
