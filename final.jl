### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 0b001a13-eb1f-4583-843a-1324422548dc
using PlutoUI

# ╔═╡ 771b13aa-2bdd-400a-87e3-cc5bae383cfe
md"""
# 15wk-2: 기말고사
"""

# ╔═╡ 2adbe92e-ceea-4e21-9161-27e56bb5a6bf
PlutoUI.TableOfContents()

# ╔═╡ 3a89c770-a071-4d46-bff3-57e54008f6e8
md"""
## 1. SVD
"""

# ╔═╡ 8f8f60db-9082-47a5-8de0-60f11572afcd
md"""
통계학에서 SVD는 어떻게 활용될 수 있는가? 활용분야를 목록화하고 간단히 서술하라. 
"""

# ╔═╡ e4569d07-7366-4df1-8dc5-b7e49fa4099f
md"""

<답>

### 1. 행렬로 이루어진 데이터 자료의 압축

### 2. 주성분분석에서의 활용(다중공선성의 해소)

### 3. 회귀분석에서의 활용

### 4. 사영행렬의 분해
"""

# ╔═╡ aa306e3f-6e9a-413c-8e75-22f49fbc150a
md"""
## 2. 다중공선성
"""

# ╔═╡ 9bf50bb3-350c-4edd-9a9f-a41c0fc865c2
md"""
토익,텝스,학점을 설명변수 ${\bf X}_{n \times 3}$ 로 설정하고 이를 바탕으로 연봉 ${\bf y}_{n\times 1}$를 추정하고자 한다. (이때 학생들의 토익과 텝스점수는 서로 비슷하다고 가정한다. 즉 토익점수가 높은 학생은 대체로 텝스점수도 높으며, 반대의 경우도 그러하다고 가정한다) 다음을 잘 읽고 물음에 답하라. 
"""

# ╔═╡ 51e8f9e3-b7d4-4e78-8b92-a26af54cda8b
md"""
(1) 선형회귀를 사용하여 계수(토익,텝스,학점이 연봉에 미치는 영향)를 추정하고자 한다. 이러한 상황은 그림1에서 무엇과 관련이 있는가? 왜 그렇다고 생각하는가? 
"""

# ╔═╡ 6d14b11f-0f77-470a-9512-63fad98dd79a
md"""
![](https://www.kdnuggets.com/wp-content/uploads/arya_biasvariance_tradeoff_5.png)
ref: <https://www.kdnuggets.com/2022/08/biasvariance-tradeoff.html>
"""

# ╔═╡ 89cc2422-b577-4489-b48e-4d268477d2b6
md"""
<답>

 주어진 자료에 대해서 선형회귀로 계수를 추정하는 것은 세 번째 그림(중심점은 과녁의 중앙이지만, 퍼진 정도가 큰 그림)과 관련이 있다.

 실제로 토익, 텝스, 학점 세 개의 설명변수만이 연봉의 결정에 관여한다고 하자. 이 때, 토익과 텝스점수는 서로 비슷하므로 다중공선성의 문제가 발생하게 된다.

 $\bf y = X\boldsymbol \beta + \boldsymbol\epsilon, ~ \boldsymbol \epsilon \sim N(\bf 0_n, \sigma^2 I_n)$라고 할 때, 최소제곱추정량 $\boldsymbol{\hat \beta} = \bf (X^{\top}X)^{-1}X^{\top}y$의 평균제곱오차 $MSE(\boldsymbol{\hat \beta})$는 다음과 같이 표현할 수 있다.

$$\begin{align}
\text{MSE}(\boldsymbol{\hat \beta}) & = \bf \mathbb{E}[\boldsymbol{\hat \beta - \mathbb{E}(\boldsymbol{\hat\beta})}]^{\top}[\boldsymbol{\hat \beta - \mathbb{E}(\boldsymbol{\hat\beta})}] + \text{Bias}[\mathbb{E}(\boldsymbol{\hat\beta}) - \beta]^{\top}[\mathbb{E}(\boldsymbol{\hat\beta}) - \boldsymbol\beta] \\
& = \text{tr}(\mathbb{V}(\boldsymbol{\hat \beta})) \\
& = \text{tr}(\bf (X^{\top}X)^{-1}\sigma^2)
\end{align}$$

 이 때, $\bf X$를 $\bf X = UDV^{\top}$이고, $\boldsymbol{D} = \text{diag}\{d_1, d_2, \cdots, d_p\}$인 SVD형태로 나타내면 위 수식은 아래와 같이 재표현할 수 있다.

$$\begin{align}
\text{MSE}(\boldsymbol{\hat \beta}) & = \text{tr}(\bf (VDU^{\top}UDV^{\top})^{-1}\sigma^2) \\
& = \text{tr}(\bf VD^{-2}V^{\top}\sigma^2) \\
& = \sigma^2 \text{tr}(\bf D^{-2}V^{\top}V) \\
& = \sigma^2 \sum_{j = 1}^{p}\frac{1}{d_j^2}
\end{align}$$

 설명변수 간 다중공선성이 존재하면 작은 특이값이 $0$에 가까워지게 되는데, 새롭게 나타낸 수식에 이를 대입해보면 분모인 $d_j^2$가 작아져서 평균제곱오차가 커지게 된다. 최소제곱추정량의 평균제곱오차는 분산의 대각합과 같고, 편향은 $\mathbb{E}(\boldsymbol{\hat\beta}) = \boldsymbol \beta$이므로 unbiased estimator이다.

 결론적으로, 선형회귀를 사용하여 계수(토익, 텝스, 학점이 연봉에 미치는 영향)를 추정할 때 각 회귀계수의 분포는 모수를 중심으로 하지만 분산은 상당히 큰 정규분포를 따르게 된다. 이는 과녁에 쏘인 화살을 생각할 때, 맞은 화살들의 중심은 과녁의 중앙이지만 퍼진 정도가 상당히 큰 상황에 비유할 수 있다. 즉, 좌측 아래의 그림과 관련이 있다고 여겨진다.

---
"""

# ╔═╡ e069c354-8ee3-4490-8937-25a665f0ce54
md"""
(2) 능형회귀를 이용하여 계수를 추정한다고 하자. 여기에서 $\lambda$는 어떠한 역할을 하는가? 그림과 연관시켜 설명하라.
"""

# ╔═╡ f6f6a2c1-ee78-4467-8f7f-3de1476d853c
md"""
<답>

먼저 그림을 위에서 아래 방향으로, 왼쪽에서 오른쪽으로 1, 2, 3, 4라 번호를 매길 때, 능형회귀추정량에서 $\lambda$의 값이 커짐에 따른 양상을 3, 4, 2, 1의 순서로 대응시킬 수 있겠다.

![](https://github.com/HollyRiver/Julia/blob/main/final%20ref/ref_KDnuggets_The%20Bias%20Variance%20Trade%20off.jpg?raw=true)

3번째, 좌측 하단 그림의 경우는 ×표시들의 중심이 과녁의 중심과 비슷하지만 분산이 상당히 크다. 즉, 해당 그림은 $\lambda$의 값이 가장 작은 상황이라고 볼 수 있다. (1)번 문항에서의 최소제곱추정량은 분산은 크지만 불편추정량인 성질을 지니는데, 이는 능형회귀추정량에서 $\lambda = 0$인 것과 동일하다는 점에서 쉽게 이해할 수 있다.

여기서 $\lambda$를 더 키워보자. 능형회귀추정량의 특성 상 $\lambda$가 커짐에 따라 추정량의 분산은 줄어든다. 그러면 4번째 우측 하단 그림처럼 ×표시들의 퍼진 정도가 더 줄어든다고 생각할 수 있다. $\lambda$의 값이 조금만 커졌기 때문에 표시들의 중심점과 과녁의 중심점 간 차이는 눈으로 식별하기 어려울 정도로 거의 비슷할 것이다.

이 상황에서 $\lambda$를 더 키우면 2번째 우측 상단 그림처럼 ×표시들의 퍼진 정도가 상당히 줄어든다. 표시들의 중심점과 과녁이 차이가 있음을 식별할 수 있으나, 퍼진 정도가 줄어들었다는 점에서 이전 그림과 대비하면 더 개선된 상황이라고 볼 수 있다. 이는 MSE가 더 작다는 관점에서 긍정적으로 여겨진다.

해당 그림은 분산이 작고, 편향도 용납할 수 있을 정도라는 점에서 좋다고 여겨진다. 하지만, 여기서 $\lambda$를 더 키운다면 어떻게 될까? 1번째 그림에서는 ×표시들의 퍼진 정도가 확실히 작긴 하지만, 표시들의 중심점과 과녁의 중심이 현저한 차이가 있음을 알아볼 수 있다.

 이러한 사실을 직관적으로 이해하기 위해 $\bf X = UDV^{\top}, $$ ~ \boldsymbol D = \text{diag}\{d_1, d_2, \cdots, d_p\}$라고 하자. 그러면 능형회귀 추정량 $\boldsymbol{\hat\beta}^R$의 MSE는 아래와 같이 나타낼 수 있다.

$$\begin{align}
\text{MSE}(\boldsymbol{\hat\beta}^R) & = \text{tr}\Big(\mathbb{V}(\boldsymbol{\hat \beta}^R)\Big) + \Big(\mathbb{E}(\boldsymbol{\hat\beta}^R) - \boldsymbol\beta \Big)^{\top}\Big(\mathbb{E}(\boldsymbol{\hat\beta}^R) - \boldsymbol\beta \Big) \\
& = \sigma^2\sum_{j = 1}^{p}\frac{d_j^2}{(d_j^2 + \lambda)^2} + \sum_{j = 1}^{p}\frac{\lambda^2}{(d_j^2+\lambda)^2}(\boldsymbol \beta^{\top}V_j)^2
\end{align}$$

즉, 능형회귀를 이용하여 계수를 추정할 때, $\lambda$의 값이 커질수록 추정량의 분산$\text{tr}\Big(\mathbb{V}(\boldsymbol{\hat \beta}^R)\Big)$가 줄어들고, 추정량의 편향$\Big(\mathbb{E}(\boldsymbol{\hat\beta}^R) - \boldsymbol\beta \Big)$은 커지게 된다.


적당한 $\lambda$에 대하여 그 값을 넘어가는 $\lambda$를 택하게 되면 편향이 용인할 수 없을 정도로 커지게 된다. 따라서, 능형회귀추정량에서 분산과 편향을 모두 고려하여 작게 만드는 $\lambda$를 택하는 것이 상당히 중요하다.

---
"""

# ╔═╡ ad99f90c-512f-450e-89e5-3283b6d68a57
md"""
(3) 주성분 회귀 (Principal component regression, PCR)을 이용하여 계수를 추정하고자 한다. 이때 principle componet 수를 작게 설정할때와 크게 설정할때 어떠한 일이 생기는지 설명하라.
"""

# ╔═╡ 5eaba9ea-26a5-4edc-b10e-2a51598c1c03
md"""
주성분 회귀를 통해 추정된 계수를 $\boldsymbol{\hat \beta}^{PCR}$라고 하자. 주성분(Principle Component)의 수가 작게 설정되면
"""

# ╔═╡ 734e8d32-55de-4eaf-8498-10c9e9f2e51f
md"""
(4) 능형회귀에서 $\lambda=0$ 으로 설정하거나 $\lambda = \infty$로 설정하는 것이 어떠한 의미를 가지는 주성분 회귀와 연결시켜 설명하라.
"""

# ╔═╡ 14c22744-c549-4fac-84e0-7f913f1cfa58
md"""
## 3. 면접질문?
"""

# ╔═╡ ddd0c1bd-19fe-45ab-893b-c94242d612c0
md"""
(1) 능형회귀에 대하여 간단히 설명하라. 
"""

# ╔═╡ a329cfda-d89c-49e0-9f0e-59d2cad465d5
md"""
(2) 다중공선성이란 무엇이며 어떤 문제를 일으키는 간단히 서술하라.
"""

# ╔═╡ 88d2172a-9df3-454d-ae8b-290a069a6d27
md"""
(3) ${\bf X}_{n\times p}$, $p>2$ 일 경우 ${\bf X}$를 시각화하는 방법에 대하여 간단히 서술하라.
"""

# ╔═╡ 5d1a6abd-3075-4b7f-95a8-2a4101a81185
md"""
(4) 직교변환이 가지는 의미를 간단히 서술하라.
"""

# ╔═╡ e775138e-2889-4d3b-b9c8-bade656ebc43
md"""
(5) $\mathbb{V}({\bf X})$의 고유벡터행렬을 활용하는 통계적 처리기법을 있는가? 있다면 서술하라. (하나만 서술해도 무방)
"""

# ╔═╡ 5232382a-6dd6-42e2-9e9b-92da7dbad672
md"""
(6) SVD를 이용하여 이미지를 압축하는 방법을 간단히 서술하라.
"""

# ╔═╡ 65e570f3-3597-449c-8e8e-7fe563cef9b9
md"""
(7) 주성분분석을 하게 되면 얻게되는 이점을 간단히 서술하라.
"""

# ╔═╡ ac002d2e-1064-433e-b695-01702083b6a4
md"""
(8) 선형변환을 SVD를 이용하여 해석하라.
"""

# ╔═╡ 1cd6bfe2-a720-46a3-adfe-bebfc23189ef
md"""
(9) 변환을 의미하는 행렬 ${\bf A}$가 데이터를 의미하는 행렬 ${\bf X}$의 앞에 곱해지는 경우와 뒤에 곱해지는 경우 각각 어떠한 의미를 가지는지 설명하라.
"""

# ╔═╡ 816f1e62-3b24-459a-86fb-bfa6624cbe57
md"""
(10) R(*lm()*)과 Python(*sklearn.linear_model*)에서 더미변수가 포함된 회귀분석을 수행하는 로직이 다르다. 차이점에 대하여 서술하라.
"""

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
# ╟─771b13aa-2bdd-400a-87e3-cc5bae383cfe
# ╠═0b001a13-eb1f-4583-843a-1324422548dc
# ╠═2adbe92e-ceea-4e21-9161-27e56bb5a6bf
# ╟─3a89c770-a071-4d46-bff3-57e54008f6e8
# ╟─8f8f60db-9082-47a5-8de0-60f11572afcd
# ╠═e4569d07-7366-4df1-8dc5-b7e49fa4099f
# ╟─aa306e3f-6e9a-413c-8e75-22f49fbc150a
# ╟─9bf50bb3-350c-4edd-9a9f-a41c0fc865c2
# ╟─51e8f9e3-b7d4-4e78-8b92-a26af54cda8b
# ╟─6d14b11f-0f77-470a-9512-63fad98dd79a
# ╟─89cc2422-b577-4489-b48e-4d268477d2b6
# ╟─e069c354-8ee3-4490-8937-25a665f0ce54
# ╟─f6f6a2c1-ee78-4467-8f7f-3de1476d853c
# ╟─ad99f90c-512f-450e-89e5-3283b6d68a57
# ╠═5eaba9ea-26a5-4edc-b10e-2a51598c1c03
# ╟─734e8d32-55de-4eaf-8498-10c9e9f2e51f
# ╟─14c22744-c549-4fac-84e0-7f913f1cfa58
# ╟─ddd0c1bd-19fe-45ab-893b-c94242d612c0
# ╟─a329cfda-d89c-49e0-9f0e-59d2cad465d5
# ╟─88d2172a-9df3-454d-ae8b-290a069a6d27
# ╟─5d1a6abd-3075-4b7f-95a8-2a4101a81185
# ╟─e775138e-2889-4d3b-b9c8-bade656ebc43
# ╟─5232382a-6dd6-42e2-9e9b-92da7dbad672
# ╟─65e570f3-3597-449c-8e8e-7fe563cef9b9
# ╟─ac002d2e-1064-433e-b695-01702083b6a4
# ╟─1cd6bfe2-a720-46a3-adfe-bebfc23189ef
# ╟─816f1e62-3b24-459a-86fb-bfa6624cbe57
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
