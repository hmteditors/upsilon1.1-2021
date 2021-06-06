# Simulate what happens in the Pluto validating notebook.
using EditorsRepo
using CitableText
using CitableObject
using ManuscriptOrthography
using Orthography

reporoot = pwd()
repo = repository(reporoot)

## CATALOGING CHECKS: (works in notebook)
cites = citation_df(repo)
filesmatch(trepo, cites)

# ... document other functions listing discrepancies

## SURFACES FOR MENU (works in notebook)
surfs = surfaces(repo)
surface = surfs[1]


## DSE COMPLETENESS (works in notebook)
sdse = surfaceDse(repo, surface)
# Use citableimage library to craft URLs to ICT2.

## DSE ACCURACY (works in notebook)
row = sdse[1, :]
diplnodetext(repo, row.passage)

## ORTHOGRAPHY (works in notebook)
textconfig = citation_df(repo)

tidy = EditorsRepo.baseurn(row.passage)

# Get the orthography
ortho = orthographyforurn(textconfig, tidy)
chunks = normednodetext(repo, row.passage) |> split

validstring(ortho, chunks[1])
