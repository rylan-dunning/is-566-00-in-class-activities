import random
import pyfiglet


PHRASES = (
    "It's a trap!",
    "Stay on target.",
    "That's no moon.",
    "I have spoken.",
    "Let the wookiee win.",
    "Dagobah.",
    "Let go, Luke!",
    "I know.",
    "My kind of scum.",
    "Sorry about the mess.",
    "All of it.",
    "You'll be dead!",
    "Oh, the uniform.",
    "TK421",
    "Punch it!",
    "There is another",
    "I don't like sand.",
    "He's holding me back!"
)

def star_wars_quote():
    phrase = random.choice(PHRASES)
    ascii_art = pyfiglet.Figlet()
    print(ascii_art.renderText(phrase))

if __name__ == "__main__":
    star_wars_quote()
