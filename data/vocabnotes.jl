
repo = EditingRepository(reporoot, "editions", "dse", "config")
#(Find all URNs in repo if you're not sure)
txturns = texturns(repo)


# Build a corpus for a given urn from a repo:
c = normalizednodes(repo, u) |> CitableCorpus

#Use MS orthography and tokenize corpus:
orth = msGreek()
tkns = map(cn -> tokenize(orth, cn.text), c.corpus) |> Iterators.flatten |> collect

# Select lexical tokens, and extract text content:
lex = filter(t ->  t.tokencategory == LexicalToken(), tkns)
tstrs = map(l -> l.text, lex)
