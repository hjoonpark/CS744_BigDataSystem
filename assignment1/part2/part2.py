from pyspark.sql import SparkSession
import sys

def simple_spark_app(input_path, output_path):
    # initialize spark sql instance
    print("STARTING-----------------------------------------------------")
    spark = (SparkSession
            .builder
            .appName("part2")
            .getOrCreate())

    # load input data
    df = spark.read.option("header", True).csv(input_path)

    # sort the input data firstly by country code and then by timetstamp
    df_sorted = df.sort(['cca2', 'timestamp'], ascending=[True, True])

    # write output
    df_sorted.coalesce(1).write.mode('overwrite').option('header','true').csv(output_path)
    print(">> output_path:", output_path)

if __name__ == "__main__":
    print("Arguments", sys.argv)
    input_path = sys.argv[1]
    output_path = sys.argv[2]
    simple_spark_app(input_path, output_path)
