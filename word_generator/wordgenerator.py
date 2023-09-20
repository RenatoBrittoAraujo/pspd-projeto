from lorem.text import TextLorem

FILE_SIZE = 150000000
print("starting file generation")
lorem = TextLorem()

with open("large_lorem.txt", "w", encoding="utf-8") as file:
    while file.tell() < FILE_SIZE:
        text = lorem.paragraph()
        file.write(text)
print("file generation complete")
