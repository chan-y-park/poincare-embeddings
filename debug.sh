#!/bin/sh

# Get number of threads from environment or set to default
if [ -z "$NTHREADS" ]; then
   #NTHREADS=2
   NTHREADS=0
fi

echo "Using $NTHREADS threads"

# make sure OpenMP doesn't interfere with pytorch.multiprocessing
export OMP_NUM_THREADS=1

# python3 \
#        -m cProfile \
#        -o poincare-embedding.pstats \
#        embed.py \
python3 embed.py \
       -dim 5 \
       -lr 0.1 \
       -epochs 10 \
       -negs 10 \
       -burnin 1 \
       -nproc "${NTHREADS}" \
       -ndproc 0 \
       -distfn poincare \
       -dset wordnet/mammal_closure.tsv \
       -fout mammals.pth \
       -batchsize 50 \
       -eval_each 1 \
