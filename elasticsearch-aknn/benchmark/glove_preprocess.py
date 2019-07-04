import json
import sys
import io

assert len(sys.argv) > 1, "Usage: <script.py> path-to-unzipped-glove-vecs.txt"

with io.open(sys.argv[2], 'w+', encoding='utf-8') as fout:
    for i, line in enumerate(io.open(sys.argv[1], encoding='utf-8')):
        tkns = line.split(" ")
        word = tkns[0]
        vector = list(map(lambda x: round(float(x), 5), tkns[1:]))
        doc = {
            "_id": "word_%d" % i,
            "_source": {
                "word": word,
                "_aknn_vector": vector
            }
        }
        fout.write(json.dumps(doc) + '\n')
