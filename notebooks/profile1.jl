### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ def898d9-26b4-4f9e-bbc1-3f0ab9fff6af
begin
	using Pkg
	Pkg.activate(".")
	Pkg.instantiate()
	using EditorsRepo
	using CitableText
	using DataFrames
	using Orthography
	
	# NB-specific packages:
	using PlutoUI
	using Markdown
	Pkg.status()
end

# ╔═╡ 6adb6004-bf8f-11eb-010b-cb3acba176b7
md"# Profile texts in repository"

# ╔═╡ 12df8620-117f-4a47-9b86-657749493c5b
md"Vocabulary"

# ╔═╡ 48e10b0d-f6b7-48e2-abde-e1761ebf8451
md"""

---

---


> ### Data and functions

You don't need to look at the rest of the notebook unless you're curious about how it works.  The following cells define the functions that retreive data from your editing repository, validate it, and format it for visual verification.

"""

# ╔═╡ eafc4907-2fbb-4a06-a8fb-d0892bfaf538
md"> Data sets"

# ╔═╡ 00a730c8-0e13-4f6a-8549-4221fc6d4074
repo = EditingRepository(dirname(pwd()), "editions", "dse", "config")

# ╔═╡ 54d3fa84-fc29-4c65-a2b6-a7a99824d0a1
txturns = texturns(repo)

# ╔═╡ d7347b73-979e-47cf-b02b-10eee7727164
o = orthographyforurn(citation_df(repo), txturns[1])

# ╔═╡ 7dde923a-37b5-4b49-9b06-86ee24b114e6
tokenize(o, "μῆνιν#")

# ╔═╡ 4db604cd-a028-4051-af80-a7333eb8241a
function alltexts(er::EditingRepository)
	
	normalizednodes(repo, urn) |> CitableCorpus
end

# ╔═╡ cc03ac4a-5079-4990-8fb6-f1d37469425a
cat = EditorsRepo.textcatalog_df(repo)

# ╔═╡ 4f2e06cc-e20a-40a4-bf5f-cc812693d1ba
md"Texts in repository: **$(nrow(cat))**"

# ╔═╡ fd760fb1-3b43-4d53-82d1-cb2af38f60a8
md"> Formatting functions"

# ╔═╡ 2ce77cff-44b6-4fce-961f-853064fb8ebd
# Compose markdown for one row in the catalog of texts
function catentrymd(r::DataFrameRow)
	string(r.group, ", *",r.work, "* (", r.version, ")") 
end

# ╔═╡ 8ec8f711-1aca-4329-ba41-f25f6383e1c8
function catentriesmd(df)
	mdrows = []
	rowv = eachrow(df) |> collect
	for r in rowv
		push!(mdrows, string("- ", catentrymd(r)))
	end
	mdrows
end

# ╔═╡ a87161a0-20ec-49fb-b7ba-2d0ece243358
begin
	mdlist = join(catentriesmd(cat), "\n")
	Markdown.parse(string("Cataloged texts: \n\n", mdlist))
end

# ╔═╡ Cell order:
# ╟─def898d9-26b4-4f9e-bbc1-3f0ab9fff6af
# ╟─6adb6004-bf8f-11eb-010b-cb3acba176b7
# ╟─4f2e06cc-e20a-40a4-bf5f-cc812693d1ba
# ╟─a87161a0-20ec-49fb-b7ba-2d0ece243358
# ╟─12df8620-117f-4a47-9b86-657749493c5b
# ╠═54d3fa84-fc29-4c65-a2b6-a7a99824d0a1
# ╠═d7347b73-979e-47cf-b02b-10eee7727164
# ╠═7dde923a-37b5-4b49-9b06-86ee24b114e6
# ╟─48e10b0d-f6b7-48e2-abde-e1761ebf8451
# ╟─eafc4907-2fbb-4a06-a8fb-d0892bfaf538
# ╟─00a730c8-0e13-4f6a-8549-4221fc6d4074
# ╟─4db604cd-a028-4051-af80-a7333eb8241a
# ╟─cc03ac4a-5079-4990-8fb6-f1d37469425a
# ╟─fd760fb1-3b43-4d53-82d1-cb2af38f60a8
# ╟─2ce77cff-44b6-4fce-961f-853064fb8ebd
# ╟─8ec8f711-1aca-4329-ba41-f25f6383e1c8
