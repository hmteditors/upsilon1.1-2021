using Kanones
using Kanones.FstBuilder
using PolytonicGreek

kroot = dirname(pwd()) * "/Kanones.jl"
lexroot = dirname(pwd()) * "/hmt-lexicon"

coredata = kroot * "/datasets/core/"
scholiadata = lexroot * "/kdata/scholia/"

datasets = [coredata, scholiadata]

kd = Kanones.Dataset(datasets; ortho=literaryGreek())

fstsrc  = kroot * "/fst/"

tgt = kroot * "/parsers/tempparser/"

parser = buildparser(kd,fstsrc, tgt)
