"""My implementation of circle.py. Draws a circle with a given radius. Awesome stuff."""
import sys
import math
import turtle
from turtle import *

arguments = len(sys.argv) - 1


def main():
    """
    Starting point of this script. Takes a number (radius) as command line argument
    """

    if arguments < 1:
        print("Please pass a number as argument")
        return

    if arguments > 1:
        print("Too many arguments! Exiting.")
        return

    try:
        radius = float(sys.argv[1])
    except ValueError:
        print("Please enter a valid number!")
        return

    draw_center(radius)
    setup_colors()
    move_to_start(radius)
    draw_circle(radius)

    done()


def draw_center(radius):
    """
    Draws a dot at the center
    :param radius: the radius of the circle
    """
    original_size = turtle.pensize()
    turtle.pensize(radius / 10)
    turtle.forward(1)
    turtle.back(1)
    turtle.pensize(original_size)


def setup_colors():
    """
    sets the background + turtle colors
    """
    bgcolor("darkgray")
    color('black', 'orange')


def move_to_start(radius):
    """
    moves to the start drawing location
    :param radius: the radius of the circle
    """
    penup()
    forward(radius)
    left(90)
    pendown()
    begin_fill()


def draw_circle(radius):
    """
    draws the circle by alternating moving forward and turning left
    :param radius: the radius of the circle
    """
    moves = 0
    while True:
        forward(2 * math.pi * radius / 360)
        left(1)
        moves += 1

        if moves >= 360:
            break
    end_fill()


if __name__ == "__main__":
    main()
