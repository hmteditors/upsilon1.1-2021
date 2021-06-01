# Use this script from the `data` directory, or else
# modify the following line to point to the right directory
# for the root of the repository:
reporoot = pwd() |> dirname


using EditorsRepo
# using CitableCorpus # After Thurs!
using CitableText
using ManuscriptOrthography
using Orthography
using FreqTables

repo = EditingRepository(reporoot, "editions", "dse", "config")
scholiaurn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:")
#(Find all URNs in repo if you're not sure)
# txturns = texturns(repo)


# Collect normalized nodes and filter for "comment" nodes
nodes = normalizednodes(repo, scholiaurn) 
comments = filter(cn -> endswith(passagecomponent(cn.urn), "comment"), nodes)


#Use MS orthography and tokenize corpus:
orth = msGreek()
tkns = map(cn -> tokenize(orth, cn.text), comments) |> Iterators.flatten |> collect


# Select lexical tokens, and extract text content:
lex = filter(t ->  t.tokencategory == LexicalToken(), tkns)
avglen = length(lex) ÷ length(comments)
tstrs = map(l -> l.text, lex)
hist = sort(freqtable(tstrs); rev=true)

function writefreqs(histo, outfile)
    output = []
    for n in names(histo)[1]
        push!(output, string(n,"|", hist[n]))
    end
    open(outfile,"w")  do io
        println(io, join(output, "\n"))
    end
end