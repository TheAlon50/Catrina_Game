extends Node

var pan = 0

signal pan_change(pan)
func refresh_pan(delta):
	pan+=delta
