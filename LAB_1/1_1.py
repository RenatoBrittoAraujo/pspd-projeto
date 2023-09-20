import json


def read_file(file: str):
    with open(file, 'r') as f:
        return f.read()


def calc_ratings_for_movie(file: str):
    ratings = json.loads(read_file(file))["ratings"]

    movies = {}

    for rating in ratings:
        user_id = rating["user_id"]
        movie_id = rating["movie_id"]
        rating = rating["rating"]

        if movie_id not in movies:
            movies[movie_id] = []

        movies[movie_id].append({
            "user_id": user_id,
            "rating": rating,
        })

    return movies


movies = calc_ratings_for_movie("data.json")

with open("out.json", "w") as f:
    f.write(json.dumps(movies, indent=4))
