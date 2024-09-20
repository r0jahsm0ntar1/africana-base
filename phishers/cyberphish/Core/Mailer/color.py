red =    "\033[91m"
green =  "\033[92m"
white =  "\033[0m"
blue =   "\033[94m"
yellow = "\033[40m"

start = (green + "[" + white + "+" + green + "]" + white)
alert = (green + "[" + red + "!" + green + "]" + white)
question = (green + "[" + yellow + "?" + green + "]" + white)


def numbering(num):
  return green + "[" + white + str(num) + green + "]"
