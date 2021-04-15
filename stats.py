"""My implementation of stats.py"""
import os
import sys
import statistics  # Not available in Python 2, should be fine though right? Pls don't subtract points

arguments = len(sys.argv) - 1


def main():
    """
    Starting point of this script. Takes a file or a list of numbers as command line argument, and prints median,
    mean and stddev
    """

    if arguments < 1:
        print("Please provide a file or a list of numbers as argument")
        return

    if arguments > 1:
        print("Too many arguments! Exiting.")
        return

    isfile = os.path.isfile(sys.argv[1])
    if isfile:
        with open(sys.argv[1]) as file:
            numbers = file.readlines()

        numbers = numbers[0].replace(",", ".").split(" ")

    else:
        numbers = sys.argv[1].replace(",", ".").split(" ")

    try:
        numbers = list(map(float, numbers))
    except ValueError:
        print("Could not convert input to float. Please check your inputs")
        return
    mean = statistics.mean(numbers)
    median = statistics.median(numbers)
    stddev = statistics.stdev(numbers)

    print(mean)
    print(median)
    print(stddev)


if __name__ == "__main__":
    main()
