import sys, os
import datetime
import time
import re
import operator
from typing import Iterable, Tuple

from pyspark.resultiterable import ResultIterable
from pyspark.sql import SparkSession

import time

# code reference: https://github.com/apache/spark/blob/master/examples/src/main/python/pagerank.py

class Logger():
    def __init__(self, save_path):
        self.save_path = save_path
        self.time0 = None
        if os.path.exists(save_path):
            os.remove(save_path)

    def timestamp(self):
        now = datetime.datetime.now()
        timestamp = "{}-{:02}-{:02} {:02}:{:02}:{:02}s".format(now.year, now.month, now.day, now.hour, now.minute, now.second)
        return timestamp

    def print(self, msg: str):
        timestamp = self.timestamp()
        print("[{}] {}".format(timestamp, msg)) # print the message
        with open(self.save_path, "a") as log_file:
            log_file.write('[{}] {}\n'.format(timestamp, msg)) # log the message

    def format_seconds(self, sec):
        m, s = divmod(sec, 60)
        h, m = divmod(m, 60)
        return h, m, s


def compute_contribs(urls: ResultIterable[str], rank: float) -> Iterable[Tuple[str, float]]:
    num_urls = len(urls)
    for url in urls:
        yield (url, rank / num_urls)

def parse_neighbors(pages):
    neighbors = re.split(r'\s+', pages)
    return neighbors[0], neighbors[1]

def page_rank(input_path, output_path, num_iters, num_partitions, cache):
    logger = Logger("log/log_{}_{}.txt".format(num_partitions, cache))

    start_time = time.time()
    spark = SparkSession \
            .builder \
            .appName("PageRank") \
            .getOrCreate()
    t0 = time.time()
    #logger.print("  >> spark session initialized")

    # load input files
    lines = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])
    t1 = time.time()
    #logger.print("  >> lines loaded: {}".format(lines))

    # read pages in input files and initialize their neighbors
    links = lines.map(lambda urls: parse_neighbors(urls)).distinct().groupByKey()
    if cache:
        links = links.cache()

    t2 = time.time()
    #logger.print("  >> links parsed: {}".format(links))

    # partition links
    if num_partitions > 1:
        links = links.repartition(num_partitions)
    #logger.print("  >> links repartition: {}".format(links))
    t3 = time.time()

    # initialize ranks
    ranks = links.map(lambda url_neighbors: (url_neighbors[0], 1.0))
    if num_partitions > 1:
        ranks = ranks.repartition(num_partitions)
    t4 = time.time()
    #logger.print("  >> ranks initialized: {}".format(ranks))

    # calculate and update ranks using PageRank algorithm
    for iteration in range(num_iters):
        # calculate contributions to the rank of other pages
        contributions = links.join(ranks).flatMap(lambda url_urls_rank: compute_contribs(
            url_urls_rank[1][0], url_urls_rank[1][1]
            ))
        # re-calculate ranks based on neighbor contributions
        ranks = contributions.reduceByKey(operator.add).mapValues(lambda rank: rank*0.85+0.15)
        if num_partitions > 1:
            ranks = ranks.repartition(num_partitions)
    t5 = time.time()

    # write output
    ranks.saveAsTextFile(output_path)
    t6 = time.time()
    spark.stop()

    logger.print("input_path {}".format(input_path))
    logger.print("output_path {}".format(output_path))
    logger.print("num_iters {}".format(num_iters))
    logger.print("num_partitions {}".format(num_partitions))
    logger.print("cache {}".format(cache))
    logger.print("total {:.4f}".format(time.time()-start_time))
    logger.print("spark_session_init {:.4f}".format(t0-start_time))
    logger.print("lines_read {:.4f}".format(t1-t0))
    logger.print("links_parsed {:.4f}".format(t2-t1))
    logger.print("links_repartition {:.4f}".format(t3-t2))
    logger.print("ranks_init {:.4f}".format(t4-t3))
    logger.print("ranks_updated {:.4f}".format(t5-t4))
    logger.print("output_saved {:.4f}".format(t6-t5))

if __name__ == "__main__":
    if len(sys.argv) < 5:
        print("Usage: pagerank_partition.py <input> <output> <num_iters> <num_partition> <cache>")
        sys.exit(-1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]
    num_iters = int(sys.argv[3])
    num_partitions = int(sys.argv[4])
    cache = sys.argv[5]
    print("-------------------- start ------------------------")
    print("  - input_path  = {}".format(input_path))
    print("  - output_path = {}".format(output_path))
    print("  - num_iters   = {}".format(num_iters))
    print("  - num_partitions = {}".format(num_partitions))
    print("---------------------------------------------------")

    page_rank(input_path, output_path, num_iters, num_partitions, cache)
