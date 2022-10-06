import sys
import re
import operator
from typing import Iterable, Tuple

from pyspark.resultiterable import ResultIterable
from pyspark.sql import SparkSession

import time
from ..utils import Logger

def compute_contribs(urls: ResultIterable[str], rank: float) -> Iterable[Tuple[str, float]]:
    num_urls = len(urls)
    for url in urls:
        yield (url, rank / num_urls)

def parse_neighbors(pages):
    neighbors = re.split(r'\s+', pages)
    return neighbors[0], neighbors[1]

def page_rank(input_path, output_path, num_iters, num_partitions):
    start_time = time.time()
    spark = SparkSession \
            .builder \
            .appName("PageRank") \
            .getOrCreate()
    t0 = time.time()
    print("  >> spark session initialized")

    # load input files
    lines = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])
    t1 = time.time()
    print("  >> lines loaded: {}".format(lines))

    # read pages in input files and initialize their neighbors
    links = lines.map(lambda urls: parse_neighbors(urls)).distinct().groupByKey()
    t2 = time.time()
    print("  >> links parsed: {}".format(links))

    # partition links
    links = links.repartition(num_partitions)
    print("  >> links repartition: {}".format(links))
    t3 = time.time()

    # initialize ranks
    ranks = links.map(lambda url_neighbors: (url_neighbors[0], 1.0)).repartition(num_partitions)
    t4 = time.time()
    print("  >> ranks initialized: {}".format(ranks))

    # calculate and update ranks using PageRank algorithm
    for iteration in range(num_iters):
        # calculate contributions to the rank of other pages
        contributions = links.join(ranks).flatMap(lambda url_urls_rank: compute_contribs(
            url_urls_rank[1][0], url_urls_rank[1][1]
            ))
        # re-calculate ranks based on neighbor contributions
        ranks = contributions.reduceByKey(operator.add).mapValues(lambda rank: rank*0.85+0.15).repartition(num_partitions)
    t5 = time.time()

    # write output
    ranks.saveAsTextFile(output_path)
    t6 = time.time()
    spark.stop()


    print("==================== result =======================")
    print("  - input_path       = {}".format(input_path))
    print("  - output_path      = {}".format(output_path))
    print("  - num_iters        = {}".format(num_iters))
    print("  - num_partitions   = {}".format(num_partitions))
    print("---------------------------------------------------")
    print("  total              : {:.2f} sec".format(time.time()-start_time))
    print("  spark session init : {:.2f} sec".format(t0-start_time))
    print("  lines read         : {:.2f} sec".format(t1-t0))
    print("  links parsed       : {:.2f} sec".format(t2-t1))
    print("  links repartition  : {:.2f} sec".format(t3-t2))
    print("  ranks init         : {:.2f} sec".format(t4-t3))
    print("  ranks updated      : {:.2f} sec".format(t5-t4))
    print("  output saved       : {:.2f} sec".format(t6-t5))
    print("===================================================")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: pagerank_partition.py <input> <output> <num_iters> <num_partition>")
        sys.exit(-1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]
    num_iters = int(sys.argv[3])
    num_partitions = int(sys.argv[4])
    print("-------------------- start ------------------------")
    print("  - input_path  = {}".format(input_path))
    print("  - output_path = {}".format(output_path))
    print("  - num_iters   = {}".format(num_iters))
    print("  - num_partitions = {}".format(num_partitions))
    print("---------------------------------------------------")

    page_rank(input_path, output_path, num_iters, num_partitions)
