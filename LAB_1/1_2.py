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


class MapReduceMovieRatings:

    def map(self, ratings):
        movies = {}

        for rating in ratings:
            movie_id = rating["movie_id"]
            movies[movie_id] = []

        return movies

    def reduce(self, ratings, movies):

        for rating in ratings:
            user_id = rating["user_id"]
            movie_id = rating["movie_id"]
            rating = rating["rating"]

            movies[movie_id].append({
                "user_id": user_id,
                "rating": rating,
            })

        return movies

# movies = calc_ratings_for_movie("data.json")


ratings = json.loads(read_file("data.json"))["ratings"]

map_reduce_obj = MapReduceMovieRatings()

movies = map_reduce_obj.map(ratings)

ratings_by_movie = map_reduce_obj.reduce(ratings, movies)

with open("out.json", "w") as f:
    f.write(json.dumps(ratings_by_movie, indent=4))
