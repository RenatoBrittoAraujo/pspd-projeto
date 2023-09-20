import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class Wordcount {
  public static class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable> {
    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
      StringTokenizer itr = new StringTokenizer(value.toString());
      while (itr.hasMoreTokens()) {
        word.set(itr.nextToken());
        context.write(word, one);
      }


        movies = {}

        for rating in ratings:
            movie_id = rating["movie_id"]
            movies[movie_id] = []

        return movies
    }
  }

  public static class IntSumReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      context.write(key, result);
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "wordcount");
    job.setJarByClass(Wordcount.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}

// import json


// def read_file(file: str):
//     with open(file, 'r') as f:
//         return f.read()


// def calc_ratings_for_movie(file: str):
//     ratings = json.loads(read_file(file))["ratings"]

//     movies = {}

//     for rating in ratings:
//         user_id = rating["user_id"]
//         movie_id = rating["movie_id"]
//         rating = rating["rating"]

//         if movie_id not in movies:
//             movies[movie_id] = []

//         movies[movie_id].append({
//             "user_id": user_id,
//             "rating": rating,
//         })

//     return movies


// class MapReduceMovieRatings:

//     def map(self, ratings):


//     def reduce(self, ratings, movies):

//         for rating in ratings:
//             user_id = rating["user_id"]
//             movie_id = rating["movie_id"]
//             rating = rating["rating"]

//             movies[movie_id].append({
//                 "user_id": user_id,
//                 "rating": rating,
//             })

//         return movies

// # movies = calc_ratings_for_movie("data.json")


// ratings = json.loads(read_file("data.json"))["ratings"]

// map_reduce_obj = MapReduceMovieRatings()

// movies = map_reduce_obj.map(ratings)

// ratings_by_movie = map_reduce_obj.reduce(ratings, movies)

// with open("out.json", "w") as f:
//     f.write(json.dumps(ratings_by_movie, indent=4))
