#!/usr/bin/env zsh

skhd-restart () {
	skhd --stop-service
	skhd --start-service
}