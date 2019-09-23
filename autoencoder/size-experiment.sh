#!/bin/bash

LATENT=1
DIM=16
LR=0.001
BS=16
EPOCHS=10
SIZE="4 8 16 32 64 128 256 512 1024"

for size in $SIZE; do
    echo direct $size
    python train.py --rotate --dim $DIM --latent $LATENT --batch-size $BS --train-only --loss direct --epochs $EPOCHS --name polygon-direct-$size --cardinality $size --lr $LR
    echo chamfer $size
    python train.py --rotate --dim $DIM --latent $LATENT --batch-size $BS --train-only --loss chamfer --epochs $EPOCHS --name polygon-chamfer-$size --decoder MLPDecoder --cardinality $size --lr $LR --skip
    echo hungarian $size
    python train.py --rotate --dim $DIM --latent $LATENT --batch-size $BS --train-only --loss hungarian --epochs $EPOCHS --name polygon-hungarian-$size --decoder MLPDecoder --cardinality $size --lr $LR --skip
done
