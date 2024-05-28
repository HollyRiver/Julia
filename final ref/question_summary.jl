### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 5039d11a-599f-4894-ab0f-7e138c7af504
using PlutoUI

# ╔═╡ 918b8e85-9add-4101-a724-c837773128a0
PlutoUI.TableOfContents()

# ╔═╡ 7db09607-5ebe-41ab-b02a-115f75b0b132
md"""
`-` 예제1: 단위행렬의 고유값과 고유벡터를 찾아라.
"""

# ╔═╡ 9ef1d11d-92cf-4e10-bea9-c5c2e6cfda7e
md"""
`-` 예제2: 0행렬의 고유값과 고유벡터를 찾아라.
"""

# ╔═╡ 632104e9-301e-4dce-9d7b-8b1bfce35144
md"""
`-` 예제3: 대각행렬의 고유값과 고유벡터를 찾아라.
"""

# ╔═╡ f4353cc8-3705-4a42-b65a-b5d5628047bb
md"""
`1`. 단위행렬의 고유값은 1이외에 존재할 수 없다. 
"""

# ╔═╡ 20c5a7b8-414c-4f14-aa8b-a737f90eaa19
md"""
`2`. ${\bf A}={\bf O}$인 경우는 대각화가능하지 않다. 
"""

# ╔═╡ 0d556eca-f7a4-4bb6-84d4-85a71d948f67
md"""
`3`. ${\bf A}$의 고유값행렬이 ${\bf \Lambda}$ 라면 ${\bf A}^2$의 고유값행렬은 ${\bf \Lambda}^2$이 된다. 
"""

# ╔═╡ 821384ee-6912-4c0b-8988-93310d43f833
md"""
`4`. ${\bf A}$의 고유벡터행렬이 ${\bf \Psi}$ 라면 ${\bf A}^2$의 고유벡터행렬도 ${\bf \Psi}$이다. 
"""

# ╔═╡ 74c940b7-44ae-434b-94db-fa0f8d42c01c
md"""
`5`. ${\bf A}$가 대각화가능행렬이라면 ${\bf A}$는 full-rank-matrix 이다. (즉 역행렬이 존재한다.)
"""

# ╔═╡ ca219e57-a1a6-4685-901a-6b61ae861b45
md"""
`6`. ${\bf A}$가 대각화가능행렬이라면 ${\bf A}+2{\bf I}$ 의 고유값은 ${\bf A}$의 고유값에 2를 더한것과 같다. 
"""

# ╔═╡ 6534879a-2731-4aae-9f1d-b9dc182d8aaf
md"""
`7`. ${\bf A}$의 고유벡터행렬이 ${\bf I}$ 라면, ${\bf A}$는 대각행렬이다. 
"""

# ╔═╡ 9f2c2244-a157-4489-8469-a8c8c3b47b2d
md"""
`8`. 대각화가능행렬 ${\bf A}$의 모든 고유값이 0과 1사이라고 하자. 그렇다면 $\lim_{k\to \infty} {\bf A}^k={\bf O}$  이다. 
"""

# ╔═╡ d6632625-2fe9-48fc-a492-d3cdb92bc695
md"""
* 계산 결과 보이기

1)  $\frac{\partial}{\partial \bf x}\bf x^{\top} \bf y = \bf y$

	풀이 1

$$\begin{align}
\frac{\partial}{\partial \bf{x}}\bf{x}^{\top} \bf{y} & = 
\begin{bmatrix}
	\frac{\partial}{\partial x_1}\\
	\dots\\
	\frac{\partial}{\partial x_n}\\
\end{bmatrix}
( x_1y_1 + \cdots + x_ny_n ) \\ 
& =
\begin{bmatrix}
	\frac{\partial x_1 y_1}{\partial x_1} + \cdots + \frac{\partial x_n y_n}{\partial x_1} \\
	\dots\\
	\frac{\partial x_1 y_1}{\partial x_n} + \cdots + \frac{\partial x_n y_n}{\partial x_n} \\
\end{bmatrix} \\
& =
\begin{bmatrix}
	y_1 \\
	\dots \\
	y_n \\
\end{bmatrix}
\end{align}$$

	풀이 2

$$\begin{align}
\frac{\partial}{\partial \bf{x}}\bf{x}^{\top} & = 
\begin{bmatrix}
	\frac{\partial}{\partial x_1}\\
	\dots\\
	\frac{\partial}{\partial x_n}\\
\end{bmatrix} [x_1 ~ \cdots ~ x_n] \\
& =
\begin{bmatrix}
	\frac{\partial x_1}{\partial x_1} ~ \cdots ~ \frac{\partial x_n}{\partial x_1} \\
	\dots\\
	\frac{\partial x_1}{\partial x_n} ~ \cdots ~ \frac{\partial x_n}{\partial x_n} \\
\end{bmatrix} = I_n\\

\therefore & ~ ~ \frac{\partial}{\partial \bf x}\bf x^{\top} \bf y = I_n \bf y = \bf y
\end{align}$$

풀이 2의 경우 미분할 차수가 1이 아닌 경우($\bf \beta^{\top}\beta$ 같은거...) 문제가 생길 수 있음.
"""

# ╔═╡ 8c82286f-230e-4187-9623-69df2a34af24
md"""
2)  $$\frac{\partial}{\partial {\boldsymbol \beta}}{\boldsymbol \beta}^\top{\bf X}^\top{\bf X}{\boldsymbol \beta}=2{\bf X}^\top{\bf X}{\boldsymbol \beta}$$

> 풀이 1

$$\begin{align}
\frac{\partial}{\partial \beta} (\boldsymbol \beta^{\top} \bf X^{\top}X \boldsymbol \beta) & = \frac{\partial}{\partial \boldsymbol\beta}
\begin{bmatrix}
	\beta_1 x_{11} + \beta_2 x_{12} + \cdots \beta_p x_{1p} \\
	\beta_1 x_{21} + \beta_2 x_{22} + \cdots + \beta_p x_{2p} \\
	\vdots \\
	\beta_1 x_{n1} + \beta_2 x_{n2} + \cdots + \beta_p x_{np}
\end{bmatrix}^{\top}
\begin{bmatrix}
	\beta_1 x_{11} + \beta_2 x_{12} + \cdots \beta_p x_{1p} \\
	\beta_1 x_{21} + \beta_2 x_{22} + \cdots + \beta_p x_{2p} \\
	\vdots \\
	\beta_1 x_{n1} + \beta_2 x_{n2} + \cdots + \beta_p x_{np}
\end{bmatrix} \\
& = \sum_{i = 1}^{n}\bigg(\sum_{j = 1}^{p}\beta_j x_{ij}\bigg)^2 \text{어쩌고...}
\end{align}$$

> 풀이 2

$$\begin{align}
\frac{\partial}{\partial \beta} (\boldsymbol \beta^{\top} \bf X^{\top}X \boldsymbol \beta) & = \Big(\frac{\partial}{\partial \beta} \boldsymbol \beta^{\top} \bf X^{\top}\Big)\bf X \boldsymbol \beta + \Big(\frac{\partial}{\partial \beta} \boldsymbol \beta^{\top} \bf X^{\top}\Big)\bf X \boldsymbol \beta : \text{Product Rule} \\
& = 2 \bf X^{\top}X \boldsymbol \beta
\end{align}$$
"""

# ╔═╡ d0d20dd1-97d1-4b69-8be7-14f80aebe155
md"""
-- 예제3: 아래와 같은 함수를 최소화하는 ${\boldsymbol \beta}$를 구하라. 여기에서 각 벡터 및 매트릭스의 차원은 ${\bf y}_{n\times 1}, {\bf X}_{n\times p}, {\boldsymbol \beta}_{p\times 1}$ 로 가정한다. 

$$loss:=({\bf y}-{\bf X}{\boldsymbol \beta})^\top({\bf y}-{\bf X}{\boldsymbol \beta})$$

$$\begin{align}
\hat{\boldsymbol \beta} & = \text{arg} ~ \underset{\boldsymbol \beta}{\text{min}} ({\bf y}-{\bf X}{\boldsymbol \beta})^\top({\bf y}-{\bf X}{\boldsymbol \beta}) \\
\frac{\partial}{\partial \boldsymbol \beta} \{({\bf y}-{\bf X}{\boldsymbol \beta})^\top({\bf y}-{\bf X}{\boldsymbol \beta})\}& = \bigg(\frac{\partial}{\partial \boldsymbol \beta} \bf(y - X\boldsymbol \beta)^{\top}\bigg)(\bf y - X \boldsymbol \beta) + \bigg(\frac{\partial}{\partial \boldsymbol \beta} \bf(y - X\boldsymbol \beta)^{\top}\bigg)(\bf y - X \boldsymbol \beta) \\
& = - \bf X^{\top}y + \bf X^{\top}X\boldsymbol\beta - \bf X^{\top}y + \bf X^{\top}X\boldsymbol\beta \\
& = -2 \bf X^{\top}y + 2 \bf X^{\top}X\boldsymbol\beta = \bf 0 \\
\Rightarrow \hat{\boldsymbol \beta} & = \bf (X^{\top}X)^{-1}X^{\top}y : \text{Product Rule}
\end{align}$$
"""

# ╔═╡ 03fc718a-0312-4bf6-a754-1e66b355c21b
md"""
-- 예제4: 아래와 같은 함수를 최소화하는 ${\boldsymbol \beta}$를 구하라. 여기에서 각 벡터 및 매트릭스의 차원은 ${\bf y}_{n\times 1}, {\bf X}_{n\times p}, {\boldsymbol \beta}_{p\times 1}$ 로 가정하고 $\lambda >0$ 을 가정한다. 

$$loss:=({\bf y}-{\bf X}{\boldsymbol \beta})^\top({\bf y}-{\bf X}{\boldsymbol \beta})+\lambda{\boldsymbol \beta}^\top{\boldsymbol \beta}$$

> Check: 추가로 $\lambda >0$ 의 조건에서 $({\bf X}^\top{\bf X}+\lambda {\bf I})^{-1}$는 항상존재함을 보여보자. 

$$\begin{align}
\frac{\partial}{\partial \boldsymbol \beta} \{({\bf y}-{\bf X}{\boldsymbol \beta})^\top({\bf y}-{\bf X}{\boldsymbol \beta})\} & = -2 \bf X^{\top}y + 2 \bf X^{\top}X\boldsymbol\beta + \frac{\partial}{\partial \boldsymbol \beta}\lambda \boldsymbol \beta^{\top}\boldsymbol \beta \\
& = -2 \bf X^{\top}y + 2 \bf X^{\top}X\boldsymbol\beta + 2\lambda \boldsymbol \beta \\
& = -2 \bf X^{\top}y + 2 \bf (X^{\top}X\boldsymbol + \lambda I_p)\boldsymbol\beta = 0 \\
\Rightarrow \hat{\boldsymbol \beta} & = \bf(X^{\top}X + \lambda I_p)^{-1}X^{\top}y
\end{align}$$

이 때, $\lambda > 0$이므로, $\bf(X^{\top}X + \lambda I_p)$의 역행렬은 항상 존재한다. (스펙트럼 정리 + 양반정치행렬)
"""

# ╔═╡ 78aaf641-4b80-4f8a-8539-df10ac394309
md"""
-- 예제5: 예제3과 같은 함수를 아래와 같이 재표현하자. 

- ``{\boldsymbol u} = {\bf X}{\boldsymbol \beta}``
- ``{\boldsymbol v} = {\bf y}-{\boldsymbol u}``
- ``loss = {\boldsymbol v}^\top {\boldsymbol v}``

아래와 같이 주장할 수 있는가?

$$\frac{\partial}{\partial \boldsymbol \beta} loss =\bigg(\frac{\partial}{\partial \boldsymbol \beta}{\boldsymbol u}^\top\bigg)\bigg(\frac{\partial}{\partial \boldsymbol u}{\boldsymbol v}^\top\bigg)\bigg(\frac{\partial}{\partial \boldsymbol v}loss\bigg)$$

> Chain Rule이 벡터 미분에서도 성립
"""

# ╔═╡ 8b9a2348-921b-41b9-8d9a-a88c8898919d


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "6e7bcec4be6e95d1f85627422d78f10c0391f199"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═5039d11a-599f-4894-ab0f-7e138c7af504
# ╠═918b8e85-9add-4101-a724-c837773128a0
# ╟─7db09607-5ebe-41ab-b02a-115f75b0b132
# ╟─9ef1d11d-92cf-4e10-bea9-c5c2e6cfda7e
# ╟─632104e9-301e-4dce-9d7b-8b1bfce35144
# ╟─f4353cc8-3705-4a42-b65a-b5d5628047bb
# ╟─20c5a7b8-414c-4f14-aa8b-a737f90eaa19
# ╟─0d556eca-f7a4-4bb6-84d4-85a71d948f67
# ╟─821384ee-6912-4c0b-8988-93310d43f833
# ╟─74c940b7-44ae-434b-94db-fa0f8d42c01c
# ╟─ca219e57-a1a6-4685-901a-6b61ae861b45
# ╟─6534879a-2731-4aae-9f1d-b9dc182d8aaf
# ╟─9f2c2244-a157-4489-8469-a8c8c3b47b2d
# ╟─d6632625-2fe9-48fc-a492-d3cdb92bc695
# ╟─8c82286f-230e-4187-9623-69df2a34af24
# ╟─d0d20dd1-97d1-4b69-8be7-14f80aebe155
# ╟─03fc718a-0312-4bf6-a754-1e66b355c21b
# ╟─78aaf641-4b80-4f8a-8539-df10ac394309
# ╠═8b9a2348-921b-41b9-8d9a-a88c8898919d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
