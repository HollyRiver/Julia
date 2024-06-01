### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ e7c0312a-a5b9-495a-a44b-6ae292313ea9
using PlutoUI, Plots, Images, Statistics, Distributions, LinearAlgebra, RDatasets, HTTP, CSV, Random

# ╔═╡ 56d6b120-11b8-11ef-0a96-813d616625a0
md"""
### **Imports**
"""

# ╔═╡ 6e4727f6-d505-433e-94d4-b1efd44c1fc4
Plots.plotly()

# ╔═╡ 503e9e0a-a5f7-4b19-94cc-3adaf673a79b
PlutoUI.TableOfContents()

# ╔═╡ 73efddba-46cc-4739-bbfc-c0ee3414ac5d
md"""
## 1. 행렬을 보는 여러 관점
---
"""

# ╔═╡ 6ed39091-a9ef-4795-b59f-bfaab857df2d
md"""
### **A. 합과 평균**

`-` $j = [1 1 \cdots 1]'$는 합계를 구하는 연산을 의미한다.
"""

# ╔═╡ f50cda22-0b85-4580-81da-43aa5d5d304b
j = ones(100)  ## (100, 1) column vector

# ╔═╡ 5a1894d8-a894-4732-bdc6-90ed4f01519c
X1 = randn(100); j'*X1, sum(X1)

# ╔═╡ ebaa72f5-7e6b-4284-ae3f-97915f67a348
md"""
`-` $\frac1n j$는 평균 연산을 의미한다.
"""

# ╔═╡ d435fbf9-ae40-40b8-9abf-fdcdcd0a86c7
(1/100)*j'*X1, mean(X1)

# ╔═╡ 20f8579d-ae50-41fa-83b2-937a9e8d6a8f
md"""
### **B. 사영**
"""

# ╔═╡ 71920666-d590-479b-90b0-37a1af7566fc
let
	ϵ = randn(100)
	y = 2*X1 .+ 3 + ϵ
	scatter(X1, y, label = "(X1, y)")
	X = [j X1]
	H = X*inv(X'X)*X'  ## 변환을 의미하는 행렬, 사영행렬
	scatter!(H*X1, H*y, label = "(HX1, Hy)")
	scatter!(X1, H*y, label = "(X1, Hy)")  ## HX = X이니까 당연함.
end

# ╔═╡ 07fb05d1-0d3f-4783-895a-98bcb5c70489
md"""
### **C. 이미지 자료**
"""

# ╔═╡ 0834ec62-d79d-4139-ab33-2c3ca2fe34b6
[RGB(1, 0, 0) RGB(0, 1, 0) RGB(0, 0, 1)]  ## matrix, not list.

# ╔═╡ 302a0283-ee3b-4fbb-831e-008202775c71
begin
	Greece = load(download("https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/1200px-Flag_of_Greece.svg.png?20160309091801"))
	Greece = imresize(Greece, (9, 13))
end

# ╔═╡ c676dce2-0045-48f0-a5ec-1a42b4619c7e
md"""
> 텐서 구조로 되어있음.
"""

# ╔═╡ 1234f31e-55bb-4e65-910f-28d8e64b5295
md"""
`-` `channelview`와 `colorview`
"""

# ╔═╡ d29d4e1a-a704-4704-84f4-c6eae3c36d86
let
	## image를 tensor로 변환
	channelview(Greece)[1, :, :]  ## R
	channelview(Greece)[2, :, :]  ## G
	channelview(Greece)[3, :, :]  ## B
end

# ╔═╡ f4b76421-5d76-4b30-ba5d-db754afda812
## tensor를 image로 변환
colorview(RGB, reshape(rand(3*4*4), (3, 4, 4)))

# ╔═╡ b6eb066a-56a6-482e-8eba-1100575bee30
md"""
### **D. 컨볼루션(합성곱)**
"""

# ╔═╡ 427ad2af-beb5-413e-aeb8-37affae10eb1
md"""
`-` 평균을 의미하는 커널 $\bar J_n$
"""

# ╔═╡ 76323502-a963-4d1c-9fb3-fd66d74a9cd3
M = reshape(ones(9)/9, (3, 3))

# ╔═╡ f2ff16e3-3e58-4315-90a2-d1bb01a599bb
let
	X0 = zeros(10, 5)
	X1 = ones(10, 5)*3
	X = [X0 X1]  ## 절반은 0, 절반은 5인 행렬
	X[3, 3] = 27  ## 3행 3열의 원소가 27인 상황
	X, imfilter(X, M)  ## X에 M이라는 행렬로 필터를 씌운다. 각 원소에 적용합니다.
end

# ╔═╡ 5c4c3c0a-4d34-4b60-90e8-2948b1a29cd2
Greece, imfilter(Greece, M)

# ╔═╡ fa18aded-5de3-4c88-ab2a-48ac6635d7e4
md"""
`-` 가우시안(정규) 커널
"""

# ╔═╡ d58e9cda-3dd8-4764-8bc7-b7ed185ba123
G = Kernel.gaussian(1)

# ╔═╡ 4e1e9b4c-7ae7-450e-a648-163d317170c1
Greece, imfilter(Greece, G)

# ╔═╡ d3ce8d58-f187-43dc-95be-7154567e9480
md"""
> 스무딩하는 커널.
"""

# ╔═╡ 189800ad-2d41-4f0f-b987-e39db32f6782
md"""
* 행렬을 이용한 이미지 변환
"""

# ╔═╡ 3c1126c0-ae6d-4052-8042-2bc89f629f8a
hani = load(download("https://github.com/guebin/SC2022/blob/main/hani.jpeg?raw=true"))

# ╔═╡ 27f3a1b4-b447-4f65-98e7-4eb7a6b68f3e
size(hani)  ## 3024 × 4032 matrix

# ╔═╡ 63b30063-4142-4212-82ee-75010416a771
md"""
`-` many method for convert image
"""

# ╔═╡ 30609c65-8ad8-4343-b7b3-e66c9c4bb92a
@bind method Radio(["transpose", "submatrix", "sqrt each ele", "deep dark", "smoothing(gaussian)", "sharp"])

# ╔═╡ 037713f9-1703-48fc-a4c8-2244f74749f0
let
	if method == "transpose"
		hani'  ## transpose
	elseif method == "submatrix"
		hani[1650:1850, 1300:1500]
	elseif method == "sqrt each ele"
		(channelview(hani) .|> (x -> sqrt(x)) |> colorview(RGB))'
	elseif method == "deep dark"
		(channelview(hani) .|> (x -> x^4*(x<0.25) + x^2*(x>=0.25 && x<0.75) + x*(x>=0.75)) |> colorview(RGB))'
	elseif method == "smoothing(gaussian)"
		imfilter(hani, Kernel.gaussian(10))'
	elseif method == "sharp"
		(hani*2 - imfilter(hani, Kernel.gaussian(10)))'  ## 행렬의 값을 두배한 것에서 스무딩한 것을 뺌 → 뚜렷한 이미지 두배?
	end
end

# ╔═╡ 4be1e972-85f9-472c-b457-65ed679a1342
md"""
## 2. SVD

---

어떠한 이미지를 표현하기 위해 꼭 n×m×3의 숫자가 필요한 것은 아니다.
"""

# ╔═╡ 62715ee9-c512-404e-9411-b9c624a7da00
let
	## 프랑스 국기
	B = RGB(0, 0, 1)
	W = RGB(1, 1, 1)
	R = RGB(1, 0, 0)
	France = [
		B B W W R R 
		B B W W R R 
		B B W W R R 
		B B W W R R 
	]  ## 4×6 matrix, 4×6×3's number
end

# ╔═╡ 8824eb80-3f0f-4a57-9f6a-f9f72003dc3f
let
	j = ones(4)
	r = [0 0 1 1 1 1]
	g = [0 0 1 1 0 0]
	b = [1 1 1 1 0 0]
	## colorview(RGB, j*r, j*g, j*b)
	colorview(RGB, stack([j*r, j*g, j*b], dims = 1))  ## 앞에 추가
end

# ╔═╡ cddd92fc-a75a-415b-9885-ea856d67e8a0
md"""
### **A. 두 행렬의 곱**
"""

# ╔═╡ a88e3113-2676-405a-a7d6-1be574456f69
md"""
!!! info "두 행렬의 곱"
	임의의 두 행렬 ${\bf A}_{n\times m}$와 ${\bf B}_{m\times k}$의 곱은 항상아래와 같이 표현할 수 있다. 

	${\bf A}_{n\times m}{\bf B}_{m \times k}=\begin{bmatrix} A_1 & A_2 & \dots & A_m\end{bmatrix}\begin{bmatrix} B'_1 \\ B'_2 \\ \dots \\ B'_m \end{bmatrix}=\sum_{i=1}^{m} A_i B_i'$

	이때 ``A_i`` 는 ${\bf A}$의 $i$-th column을 의미하고, ``B_i'`` 는 ${\bf B}$의 $i$-th row를 의미한다. 

	또한 임의의 두 행렬 ${\bf A}_{n\times m}$와 ${\bf B}_{m\times k}$의 곱을 아래와 같이 표현할 수 있다. 

	${\bf A}_{n\times m}{\bf B}_{m \times k}=\begin{bmatrix} {\bf A}_1 & {\bf A}_2\end{bmatrix}\begin{bmatrix} {\bf B}_1 \\ {\bf B}_2 \end{bmatrix}={\bf A}_1 {\bf B}_1 + {\bf A}_2 {\bf B}_2$

	> 차원만 맞게 잘 쪼개면, 아무렇게나 매트릭스를 쪼개도 직관적인 곱셈이 모두 잘 성립한다.
"""

# ╔═╡ cb290f74-1dc9-432c-91bb-6a4614a66b68
md"""
### **B. 특이값 분해(Singular Value Decomposition)**
"""

# ╔═╡ a756bf85-38f8-460d-bd5f-95059b51c1bc
md"""
!!! info "특잇값 분해 (Singular Value Decomposition, SVD)"
	"임의의" 매트릭스 ``{\bf X}_{n\times p}``는 "항상" 아래와 같이 분해가능하다. 
	
	${\bf X}={\bf U}{\bf D}{\bf V}^\top$

	이때 ``{\bf D}``는 대각행렬이며, ${\bf U}$와 ${\bf V}$는 직교행렬 (혹은 그 비슷한 것) 이다. 이때 ``{\bf U}, {\bf D}, {\bf V}``의 차원은 ``{\bf X}``의 모양에 따라 다르다. 아래와 같이 

	$m:=\min(n,p)$

	이라고 할때 ``{\bf U}, {\bf D}, {\bf V}``의 특징을 좀 더 세밀하게 정리하면 아래와 같다. 
	
	(1) ``{\bf D}``는 대각행렬이며 차원은 $m \times m$ 이다. 
	

	(2) ``{\bf U}``와 ``{\bf V}``의 차원은 ``{\bf X}``와 ``{\bf D}``의 차원을 바탕으로 적당히 결정된다. 예를들어 ``n>p`` 이면 
	- ``{\bf X}_{n\times p} = {\bf U}_{n\times p}{\bf D}_{p\times p} {\bf V}^\top_{p \times p}`` 
	와 같이 분해된다. 
	
	(3) ``{\bf U}``와 ``{\bf V}``는 중 정사각형 모양인 행렬은 직교행렬이고, 직사각형 모양의 행렬은 거의 직교행렬이다. 즉 1. ``{\bf U}^\top {\bf U}``, 2. ``{\bf U} {\bf U}^\top``, 3. ``{\bf V}^\top {\bf V}``, 4. ``{\bf V}{\bf V}^\top``
	의 계산중에서 차원이 (m,m)으로 나오는 것은 모두 단위행렬이 된다. 

	${\bf X}={\bf U}{\bf D}{\bf V}^\top$

	위는 아래와 같이 분해하여 표현가능하다.

	* 특이값 분해의 벡터화 표현(PCA와 연관)

	${\bf X}=U_1 d_1 V_1^\top + U_2 d_2 V_2^\top + \dots + U_m d_m V_m^\top$

	여기에서 $m=\min(n,p)$ 이며 $d_i$는 ${\bf D}$의 $i$-th 대각원소, $U_i, V_i$는 각각 ${\bf U}, {\bf V}$의 $i$-th column을 의미한다. 

	* 특이값 분해의 block-matrix 표현

	${\bf X}={\bf U}_1 {\bf D}_1 {\bf V}_1^\top + {\bf U}_2 {\bf D}_2 {\bf V}_2^\top$

	이때 ${\bf U}_i, {\bf D}_i, {\bf V}_i$ 는 각각 ${\bf U} = \begin{bmatrix} {\bf U}_1 & {\bf U}_2\end{bmatrix}$, ${\bf D} = \begin{bmatrix} {\bf D}_1 & {\bf 0}  \\ {\bf 0} & {\bf D_2}\end{bmatrix}$, ${\bf V} = \begin{bmatrix} {\bf V}_1 & {\bf V}_2\end{bmatrix}$ 를 만족하는 적당한 행렬이다. 
"""

# ╔═╡ 15ea5b7d-5fbc-4f06-8eba-80fae726d43e
md"""
> 이때, D의 대각원소들의 크기는 정보량을 의미하므로, 앞의 몇 개의 대각원소만을 사용하여 큰 행렬을 효율적으로 저장할 수 있음.
"""

# ╔═╡ da8c6f35-ce43-4aa1-86d1-ad221f6214ca
md"k = $(@bind k Slider(1:3024, show_value = true, default = 50))"

# ╔═╡ 5b345e21-a675-46ee-9133-453cb1512f14
let
	(Ur, dr, Vr), (Ug, dg, Vg), (Ub, db, Vb) = eachslice(channelview(hani), dims = 1) .|> svd  ## 채널뷰의 가장 외곽 차원에서 슬라이스한 것을 각각 svd함.
	R = Ur[:, 1:k] * Diagonal(dr[1:k]) * Vr[:, 1:k]'
	G = Ug[:, 1:k] * Diagonal(dg[1:k]) * Vg[:, 1:k]'
	B = Ub[:, 1:k] * Diagonal(db[1:k]) * Vb[:, 1:k]'
	println("ratio = $((4032*k + k + k*3024) / (4032*3024))")  ## U의 k열까지, V의 k행까지, k개의 특이값까지 사용.
	hani2 = colorview(RGB, R, G, B)
	[hani' hani2']
end

# ╔═╡ 757acf58-11bb-4abd-9444-15cb9bb310fd
md"""
### **C. SVD의 응용 : 주성분 분석(Principal Component Analysis)**

차원축소, 혹은 다중공선성의 해결을 위해 이용되는 기법
"""

# ╔═╡ 0e804e95-56b9-4f13-b37a-7f5bb15ce879
md"""
`-` PCA의 목적

$$\bf X_{n \times p}, ~ n > p$$

(1) $\bf X$가 가지고 있는 정보는 거의 유지하면서 (2) 저장비용은 좀 더 저렴한 매트릭스 $\bf Z$를 만들고 싶다.

>  $\bf Z$의 차원이 $(n, q), ~ q < p$이며, $\bf Z$에서 적당한 변환 $\bf B$를 하면 언제든지 $\bf X$와 비슷한 매트릭스로 복원(reconstruction)할 수 있다. 즉, $$\bf ZB \approx \bf X$$를 만족하는 적당한 $\bf B$가 존재한다.

`-` SVD → Z

임의의 매트릭스 $\bf X_{n\times p}$의 SVD를 이용하면 적당히 아래를 만족하는 매트릭스틀을 찾을 수 있다.

*  $\bf X = \bf UDV^{\top} = \bf U_1D_1V_1^{\top} + \bf U_2D_2V_2^{\top}$
*  $\bf X \approx \bf U_1D_1V_1^{\top}$

여기에서 $\bf U_1, D_1$의 경우 차원이 $(n, q)$이고, 이에 $\bf V_1^{top}$를 곱하면 $\bf X$를 비슷하게 만들 수 있다. 즉, $\bf Z := \bf U_1D_1, ~ \bf B := \bf V^{\top}$으로 정의할 수 있다.
"""

# ╔═╡ 916827a4-2a9f-4b9a-93ee-1eeeb50461ab
md"""
!!! info "주성분 분석"
	임의의 $(n,p)$ matrix ${\bf X}$ 에 대한 SVD가 아래와 같다고 하자. $(n \geq p)$.
	
	${\bf X} = {\bf U}{\bf D}{\bf V}^\top$

	이때 ${\bf Z}={\bf U}{\bf D}={\bf X}{\bf V}$ 의 each-column 을 주성분 (principle componet) 라고 한다. 구체적으로 
	- PC1 = first column of ${\bf Z}$. 
	- PC2 = second column of ${\bf Z}$. 
	- ``\dots``
	- PCp = $p$-th column of ${\bf Z}$. 
	와 같이 부른다. 또한 ${\bf Z}$ 의 각 원소를 principal component 라고 부른다. 따라서 ${\bf Z}_{n \times p}$ 에는 $np$ 개의 principal component score 가 있다. 그리고 ${\bf V}$ 는 rotation matrix 혹은 loading matrix 라고 부른다. 마지막으로 원래의 자료 ${\bf X}$를 그대로 분석하것이 아니라, ${\bf X}$를 ${\bf Z}$로 바꾼뒤에 분석하는 일련의 기법 (즉 ${\bf X}$의 주성분을 분석하는 기법)을 통칭하여 주성분분석이라고 한다. 
"""

# ╔═╡ 870b0a9f-2661-4db9-a0fa-1481c9b771cf
md"""
ex) iris data
"""

# ╔═╡ f754cdd2-4aeb-4529-b119-20da8306a2f6
begin
	iris = dataset("datasets", "iris")
	X, y = Array(iris[:, 1:4]), iris[:, 5]  ## features, target
end

# ╔═╡ 9a80b3c5-b2b0-4467-9fe9-6e0c9f55f3a6
let
	U, d, V = svd(X)  ## rank(X) = 4, dataframe은 svd 불가
	U1, U2 = U[:, 1:2], U[:, 3:4]
	D1, D2 = Diagonal(d[1:2]), Diagonal(d[3:4])
	V1, V2 = V[:, 1:2], V[:, 3:4]
	Z = U1*D1  ## (150, 2)

	[X Z*V1']
end

# ╔═╡ c3bee2ec-474f-40cc-a4f8-cfca65d2150a
md"""
> 복원하였을 때 거의 흡사한 것을 확인할 수 있음.
"""

# ╔═╡ 2987a979-dd5a-485f-aafa-e0e8b4d83487
md"""
`-` 주성분을 활용한 시각화
"""

# ╔═╡ c926ad48-e020-43f6-b141-36803c8caccf
let
	U,d,V = svd(X) # (150,4)
	U1,U2,U3,U4 = eachcol(U)
	d1,d2,d3,d4 = d
	V1,V2,V3,V4 = eachcol(V)
	#Z1,Z2 = U1*d1, U2*d2
	PC1,PC2 = U1*d1, U2*d2  ## 두 개의 주성분을 사용하여 시각화
	@show unique(y)
	scatter(PC1[y .== "setosa"],PC2[y .== "setosa"],label="setosa")
	scatter!(PC1[y .== "versicolor"],PC2[y .== "versicolor"],label="versicolor")
	scatter!(PC1[y .== "virginica"],PC2[y .== "virginica"],label="virginica")
end 

# ╔═╡ 3bf43063-c6aa-48b2-9b3c-abf218ae40b0
md"""
`-` PCA에 대한 자잘이

1. 주성분 분석 시 보통 scaling을 선행한다.(열별로 표준화)
2. PC score는 observation별로 분석하고 싶을 때 사용한다.
3. $\bf X_{n×p}$에서 주성분은 최대 $p$개 존재한다. $\bf X$의 (처음) 3개 주성분만 고려하면 → 3개 특이값을 사용한다는 의미.
"""

# ╔═╡ 749ebb52-000a-4299-9520-ed3b3c0fd8af
let 
	X1,X2,X3,X4 = eachcol(X)
	X1 = (X1 .- mean(X1))/std(X1)
	X2 = (X2 .- mean(X2))/std(X2)
	X3 = (X3 .- mean(X3))/std(X3)
	X4 = (X4 .- mean(X4))/std(X4)
	X = [X1 X2 X3 X4] # 보통 이걸 X라고 생각하고 분석함

	U, d, V = svd(X)
	Z = U*Diagonal(d)
	Z[1,:]  ## PC scores of first observation

	U,d,V = svd(X) # X: (n,p)
	Z = U[:,1:3]*Diagonal(d[1:3]) # Z: (n,3)  ## X의 3개 주성분만 고려
end 

# ╔═╡ a474a3ae-2518-462a-99b4-2cac97c0d811
md"""
`-` 주성분 Z를 계산하는 방법
"""

# ╔═╡ 953b27bb-e397-47d0-8219-2dbfcaebdb25
let
	U, d, V = svd(X)
	## svd의 기본 정의에서 도출되는 것
	Z = U*Diagonal(d)
	Z = X*V
	## svd(X'X)의 양쪽 행렬이 V, V'라는 것을 이용
	U2, d2, V2 = svd(X'X)
	Z = X*V2  ## X*U2
	## X'X가 양반정치행렬이고, 이때 고유벡터들은 직교함을 이용(스펙트럼 정리)
	λ, Ψ = eigen(X'X, sortby = -)  ## descending
	Z = X*Ψ
end

# ╔═╡ 10ec58d9-79bf-44c8-8d19-40a8db982642
md"""
### **D. 고유값분해와 특이값분해의 일치 조건**
"""

# ╔═╡ 6908a2d0-4ef1-46a2-af96-de32647cd3c3
md"""
!!! info "이론: 스펙트럼 정리 (Spectral Theorem)" 

	* 실수 버전 : ``{\bf A}`` 가 실대칭행렬 $\Leftrightarrow$ ${\bf A}$는 (1) 모든 고유값이 실수이고 (2) 고유벡터가 직교행렬

	여기에서 $\Rightarrow$ 방향을 스펙트럼정리라고 한다. (반대방향은 당연해서..)

	* 복소수 버전 : ``{\bf A}`` 가 에르미트행렬 $\Leftrightarrow$ ${\bf A}$는 (1) 모든 고유값이 실수이고 (2) 고유벡터가 유니터리 행렬임. 
"""

# ╔═╡ 9fc34bdc-4092-4eba-9ed0-8d7ae4925b88
md"""
!!! tip "스펙트럼 정리의 기억방법" 
	대충 아래와 같이 기억하면 된다. 
	- ``{\bf A}`` 가 실대칭행렬 $\Leftrightarrow$ ${\bf A} = {\bf \Psi}{\bf \Lambda}{\bf \Psi}^\top$ 와 같이 쓸 수 있음. 이때 모든 행렬은 실수임. 
	- ``{\bf A}`` 가 에르미트행렬 $\Leftrightarrow$ ${\bf A} = {\bf \Psi}{\bf \Lambda}{\bf \Psi}^H$ 와 같이 쓸 수 있음. 이때 ${\bf \Lambda}$만 실수임. 
"""

# ╔═╡ 20394eaa-6969-46f9-a77d-e0f4aece0934
let 
	# 대칭행렬X, 에르미트행렬O, 스펙트럼정리 만족 (고유값실수 + ΨΛΨ'=A 만족)
	A = [1 -im
		 im  1]
	λ,Ψ = eigen(A)
	@show λ # 모든고유값실수O
	@show Ψ'Ψ ≈ Ψ*Ψ' ≈ I # 고유벡터행렬은 유니터리O
	@show Ψ*Diagonal(λ)*Ψ' ≈ A	
end 

# ╔═╡ dfbe0d7a-e5f8-4c5b-a2ad-f58eb0e10698
md"""
!!! info "정의 : PD/PSD, ND/NSD" 
	임의의 non-zero ${\bf y} \in \mathbb{R}^n$ (non-zero ${\bf y}\in \mathbb{C}^n$ ) 에 대하여 아래를 만족하는 실대칭행렬 (혹은 에르미트행렬) ${\bf A}_{n \times n}$를 positive definite matrix 라고 한다. 

	${\bf y}^\top {\bf A} {\bf y} > 0 \quad \quad ({\text or}\quad {\bf y}^H {\bf A} {\bf y} > 0)$

	이외에도 $\geq, < ,\leq$ 에 따라 postive semi-definite, negative definite, negative semi-definite matrix를 정의할 수 있다. 
"""

# ╔═╡ cdfdee60-c095-4ac6-8231-7bce8b879549
md"""
`-` 정리
"""

# ╔═╡ b94452af-1ec6-4cc3-ae8c-0d53c70c57a1
md"""
| 예시 | (1)``{\bf A}{\bf \Psi}= {\bf \Psi}{\bf \Lambda}`` | (2)``{\bf A}={\bf \Psi}{\bf \Lambda}{\bf \Psi}^{-1}`` | (3)``{\bf A}={\bf \Psi}{\bf \Lambda}{\bf \Psi}^H`` | (4)``\forall \lambda_i \in \mathbb{R}`` | (5)``\forall\lambda_i  >0`` | (6)``{\bf y}^H {\bf A}{\bf y}>0`` |
|:---------:|:---------:|:---------:|:---------:|:--------:|:---------:|:---------:|
|``\begin{bmatrix} i & i \\ 0 & i \end{bmatrix}`` |  O   | X  | X   | X  | NA | X |
|``\begin{bmatrix} -1 & -1 \\ 0 & -1 \end{bmatrix}`` |  O   | X  | X   | O | X | X |
|``\begin{bmatrix} 1 & 2 \\ 0 & -3 \end{bmatrix}`` |  O   | O  | X   | O  | X | X |
|``\begin{bmatrix} 0 & 1 & 0 \\ 0 & 0 & 1 \\ 1 & 0 & 0 \end{bmatrix}`` |  O   | O  | O |  X  | NA | X |
|``\begin{bmatrix} 1 & 3 \\ 3 & 2 \end{bmatrix}`` |  O   | O  | O  | O  | X | X |
|``\begin{bmatrix} 1 & i \\ -i & -3 \end{bmatrix}`` |  O   | O  | O  | O  | X | X |
|``\begin{bmatrix} 1 & 0.5 \\ 0.5 & 1 \end{bmatrix}`` |  O   | O  | O  | O  | O | O|
|``\begin{bmatrix} 2 & i \\ -i & 2 \end{bmatrix}`` |  O   | O  | O  | O  | O | O|
|``\begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}`` |  O   | O  | O  | X  | NA | O|
|``\begin{bmatrix} 1 & 1 \\ 0 & 2 \end{bmatrix}`` |  O   | O  | X  | O  | O | O|
"""

# ╔═╡ 94ebb3ad-d3c7-4c00-ba64-200e8276deae
md"""
* (1)은 정사각행렬이기만 해도 성립
* (2)는 고유벡터로 이루어진 행렬이 full-rank일 경우 성립 : 모든 고유값이 서로 다르면 무조건 성립
* (3)이 성립 ⇒ (2)가 성립
* (1)~(3)이 성립해도, (4)가 성립하지 않을 수 있다.
* 에르미트행렬이면 (1)~(4)가 무조건 성립한다. (스펙트럼 정리)
* (3),(4)가 성립하면 에르미트행렬이다. (스펙트럼 정리의 역)
* 에르미트행렬이면 (5), (6)은 동치 조건이다.
* (6)이 성립해도 고유값이 양수가 아닐 수 있다.
* (5), (6)이 동시에 성립해도 고유벡터가 직교하지 않을 수 있다.
* 상기 모든 조건(양정치행렬)에서 고유값분해 = 특이값분해이다.
"""

# ╔═╡ 30bec97b-262a-4c97-98b4-d8ab04892621
md"""
!!! info "정리: 특이값분해 = 고유값분해" 
	행렬 ``{\bf A}`` 가 PSD-행렬이라면 특이값분해와 고유값분해가 일치하도록 만들 수 있다. 즉 아래를 만족하는 직교행렬 ``{\bf U}={\bf V}={\bf \Psi}`` 와 대각원소가 비음인 대각행렬 ``{\bf D}={\bf \Lambda}`` 가 존재한다.

	$${\bf A} = {\bf U}{\bf D}{\bf V}^\top = {\bf \Psi}{\bf \Lambda}{\bf \Psi}^\top$$

	이때 ``{\bf U}={\bf V}={\bf \Psi}``는 ${\bf A}$의 고유벡터행렬이면서 동시에 ${\bf A}^\top{\bf A}$, ${\bf A}{\bf A}^\top$ 의 고유벡터행렬이 된다. 그리고 ${\bf D}={\bf \Lambda}$는 ${\bf A}$의 고유값행렬이면서 동시에 ${\bf A}^\top{\bf A}$, ${\bf A}{\bf A}^\top$ 의 고유값행렬의 $\sqrt{}$ 가 된다.
"""

# ╔═╡ e4575f44-454c-40e8-9864-6c02054ada2f
md"""
## 3. 대각화가능행렬

---
"""

# ╔═╡ 9b5948f5-bbd4-4518-9833-73bf37f0ec51
md"""
### **A. 고유값과 고유벡터**
"""

# ╔═╡ 487ba976-6b51-494e-99d9-101063d734df
md"""
사실 특이값분해는 고유값 분해(eigen value decomposition)에서 유도된 것임.

!!! info "고유값과 고유벡터의 정의"
	임의의 정사각행렬 ${\bf A}_{n\times n}$에 대하여 어떠한 벡터 ${\boldsymbol \psi}_{n\times 1}\neq 0$ 가 적당한한 값 $\lambda$에 대하여 

	${\bf A}{\boldsymbol \psi} = \lambda {\boldsymbol \psi}$

	를 만족하면 $\boldsymbol\psi$를 $\lambda$의 고유벡터라고 하고 $\lambda$는 $\boldsymbol\psi$에 대응하는 고유값이라고 한다.

	임의의 정사각행렬 ${\bf A}$의 고유값은 항상 아래를 만족하는 $\lambda$를 풀어서 찾을 수 있다. 
	
	$\det({\bf A}-\lambda {\bf I})=0$

	하나의 고유값이 정해지면 그 이후에는 아래의 식을 풀어서 $\psi$를 찾을 수 있다. 

	${\bf A}{\boldsymbol\psi} = \lambda {\boldsymbol \psi}$
"""

# ╔═╡ f6801e17-2bea-41fa-bb9f-505e10a3ff14
md"""
!!! info "고유값과 고유벡터의 정의 -- 매트릭스 버전"
	임의의 정사각행렬 ${\bf A}_{n\times n}$에 대한 고유값들을 $\lambda_1,\dots,\lambda_n$ 이라고 하고 그것에 대응하는 고유벡터들을 ${\boldsymbol \psi}_1\dots {\boldsymbol \psi}_n$ 이라고 하자. 그리고 
	- ``{\boldsymbol \Psi} = \begin{bmatrix} {\boldsymbol \psi}_1 & {\boldsymbol \psi}_2 & \dots& {\boldsymbol \psi}_n \end{bmatrix}``
	- ``{\boldsymbol \Lambda} = \text{diag}(\lambda_1, \dots,\lambda_n)``
	와 같은 매트릭스를 정의하자. 그렇다면 아래의 식이 만족한다. 

	${\bf A}{\boldsymbol \Psi} = {\boldsymbol \Psi}{\boldsymbol \Lambda}$

	이러한 표현은 임의의 정사각행렬 ${\bf A}$에 대하여 언제나 가능함을 기억하자. 그리고 앞으로는 편의를 위하여 ``{\boldsymbol \Lambda}``를 고유값 행렬이라고 하고 ${\boldsymbol \Psi}$ 를 고유벡터행렬이라고 부르자.
"""

# ╔═╡ 0129cd06-2230-4219-a231-657bdc23ca7a
md"""
### **B. 고유값과 고유벡터의 성질**
"""

# ╔═╡ 38673ecb-b4a5-416d-a1ad-f78cfd9f9a6c
md"""
!!! warning "고유값은 항상 존재 + 고유값은 중복될 수 있음 + 고유값이 실수라는 보장없음"
	임의의 $2\times 2$ 행렬 ${\bf A}$ 를 고려하자. 

	$\det({\bf A}-\lambda {\bf I})=0$

	는 $\lambda$에 대한 이차방정식의 형태일 것이다. 아래의 사실을 쉽게 유추할 수 있다. 

	1. 이차방정식의 근은 항상 존재하므로 ${\bf A}$의 고유값은 항상 존재한다. (그리고 고유값/고유벡터의 정의에 따라서 ${\bf A}$에 대응하는 고유벡터도 항상 존재한다) 
	2. 이차방정식은 중근을 가질 수 있으므로 ${\bf A}$가 서로다른 두개의 고유값을 가진다는 보장은 없다. 
	3. 또한 이차방정식은 허근을 가질 수 있으므로 ${\bf A}$의 고유값이 실수라는 보장 역시 없다. 

	이러한 논의는 임의의 $n \times n$ 행렬 ${\bf A}$ 에 대하여도 확장된다. 즉 아래가 성립한다. 

	1. ``{\bf A}``의 고유값과 고유벡터는 항상 존재한다. (대수학의 기본정리) --> 좋은데?
	2. ``{\bf A}``가 서로 다른 $n$개의 고유값을 가진다는 보장은 없다. --> rank???
	3. ``{\bf A}``의 고유값이 실수라는 보장은 없다. --> 허수같은건 생각하기 싫은걸??

	게다가 고유벡터는 항상 유일하지 않음. ψ가 고유벡터의 정의를 만족한다면, -ψ도 정의를 만족. 표준화 하면 두 개체만 존재한다.
"""

# ╔═╡ 808e59f6-a615-45e6-9dc7-9863da1fb781
md"""
### **C. 귀류법과 대응하는 고유벡터**
"""

# ╔═╡ 7d0b49e7-a6ab-499a-ad4c-a63a10853fc1
md"""
!!! caution "특성방정식의 근에 대응하는 고유벡터"
	특성방정식의 근 $\lambda$에 대응하는 고유벡터가 반드시 하나는 존재한다. 
	
	(proof) 귀류법을 쓰자. 즉 "고정된 $\lambda^*$에 대응하는 고유벡터가 없다"고 가정하자. 편의상 특성방정식을 만족하는 하나의 근 $\lambda^*$를 fix할 때, $\lambda^*$에 대응하는 고유벡터가 없다는 의미는 

	$$\forall {\boldsymbol \psi}\neq0:~{\bf A}{\boldsymbol \psi} \neq \lambda{\boldsymbol \psi}$$

	라는 의미고 이는 다시 아래의 의미이다. 

	$$\forall {\boldsymbol \psi}\neq0:~({\bf A}-\lambda^*{\bf I}){\boldsymbol \psi} \neq {\bf 0}$$

	따라서 $({\bf A}-\lambda^*{\bf I})$ 는 선형독립이다. 그런데 이는 사실이 아니다. 왜냐하면 $({\bf A}-\lambda^*{\bf I})$ 가 선형독립일 경우는 역행렬이 존재해야하는데, $\lambda^*$는 

	$$\det({\bf A}-\lambda^*{\bf I})=0$$

	를 만족하는 근이므로 행렬 ${\bf A}-\lambda^*{\bf I}$는 역행렬이 없는 행렬이 되기 때문이다. (모순)
"""

# ╔═╡ c0ea6990-d3a4-4c64-8494-aa09c8d8c027
md"""
### **D. 대각화 가능 행렬**
"""

# ╔═╡ f9e7de90-c06f-4529-994b-b3d1f8fd2404
md"""
!!! info "대각화가능 (고유벡터행렬의 full-rank matrix 일때)"
	임의의 정사각행렬 ${\bf A}_{n\times n}$에 대한 아래를 만족하는 고유값행렬과 고유벡터행렬은 항상 존재한다. 
	
	${\bf A}{\boldsymbol \Psi} = {\boldsymbol \Psi}{\boldsymbol \Lambda}$

	만약에 ${\boldsymbol \Psi}$가 full-rank-matrix 라면 (= ${\boldsymbol \Psi}^{-1}$ 이 존재한다면) 아래와 같은 표현이 가능하다. 

	${\bf A} = {\boldsymbol \Psi}{\boldsymbol \Lambda}{\boldsymbol \Psi}^{-1}$

	그리고 이때 ${\bf A}$는 **"대각화가능"**행렬이라고 부른다. (수식 ${\bf \Lambda} = {\boldsymbol \Psi}^{-1}{\bf A}{\boldsymbol \Psi}$ 를 관찰해보시면 대각화가능행렬이라는 이름이 생긴 이유를 알 수 있습니다!~) 
"""

# ╔═╡ 6568552c-c7ff-4f3f-a891-be9a801861ba
let
	A = [1 0;0 1]
	B = [1 1;0 1]
	@show eigen(A)
	@show eigen(B)
end

# ╔═╡ 07bcaec5-f414-476f-a403-7feecf5b956f
md"""
> 둘 다 고유값이 중근 1을 가지고 있으나, 고유벡터는 다름 → 가질 수 있는 고유벡터 조합의 범위 : Rank
"""

# ╔═╡ 1a0cbbc6-5f5b-4e15-90d5-7d1613405c25
md""" 
!!! warning "대각화가능행렬 = 고유분해 표현이 존재하는 행렬"
	아래의 수식
	
	${\bf A} = {\boldsymbol \Psi}{\boldsymbol \Lambda}{\boldsymbol \Psi}^{-1}$
	
	를 ${\bf A}$의 고유분해 (eigendecomposition) 라고 표현한다. 따라서 아래의 용어들은 문맥상 같은 말이다. 

	- ``{\bf A}`` 가 대각화가능하다. 
	- ``{\bf A}`` 의 고유분해표현이 존재한다. 
	- ``{\bf A}`` 를 고유분해할 수 있다. 

	대각화가능 여부 체크

	1. 모든 고유값이 서로 다르다면 대각화가능하다.
	2. 중복된 고유값이 있을 때, 중복된 고유값들에 대응하는 고유벡터로 이뤄진 행렬이 Full-rank이면 대각화가능하다.
"""

# ╔═╡ 8d92734b-6b76-4eae-b44d-d36fbc9932f2
md"""
## 4. 회귀분석
---
"""

# ╔═╡ 1abb20ed-28f6-4ddb-9881-f576ea3793e6
ic1 = DataFrame(CSV.File(HTTP.get("https://raw.githubusercontent.com/guebin/SC2024/main/ic1.csv").body))

# ╔═╡ 4febe3b0-b6bb-4c80-a815-fbdc7d0a9efe
md"""
### **A. 회귀분석(SVD 활용)**
"""

# ╔═╡ ff4500cb-02b8-48e2-9514-8420bb1f5bd3
md"""
!!! info "SVD를 활용한 회귀계수 구하기"
	회귀분석에서 $\hat{\boldsymbol \beta}$은 아래와 같이 구해진다. 

	$\hat{\boldsymbol \beta} = ({\bf X}^\top {\bf X})^{-1}{\bf X}^\top {\bf y}$

	그런데 ${\bf X}={\bf U}{\bf D}{\bf V}^\top$의 표현을 이용하면, 

	$\hat{\boldsymbol \beta} = {\bf V}{\bf D}^{-1}{\bf U}^\top {\bf y}$

	로 정리할 수 있다. 
"""

# ╔═╡ edc34495-5bb4-4c56-a580-ee4a6ee8469e
md"""
> X가 full-rank가 아니여도(범주형 자료 처리에서 하나를 드롭하지 않아도) 동일하게 분석된다. 회귀계수의 해석만 조금 바뀐다.
"""

# ╔═╡ d316a617-2f59-45f7-90d9-1b243165b5af
md"""
*--sklearn 에서의 로직 대충 요약--*
1. ``{\bf X} := \begin{bmatrix}{\boldsymbol X}_1 & {\boldsymbol X}_2 & \dots & {\boldsymbol X}_p \end{bmatrix}`` 를 centering 하여 ``{\bf Z}``를 만든다. 
2. `svd(Z)`를 이용하여 $X_j$ 에 대응하는 coef 계산. (이것이 $\hat{\beta}_1,\dots,\hat{\beta}_p$가 된다.)
3. 2를 이용하여 $\hat{\bf y}$을 구하고 $\text{mean}\big({\bf y}-\hat{\bf y}\big)$을 계산하여 bias-term ($=\hat{\beta}_0$) 을 맞춘다.($\text{mean}(y - ŷ)$이 0이 되도록)
"""

# ╔═╡ 15875303-0a13-49ae-b0d2-e70625315a1b
md"""
### **B. 다중공선성**
"""

# ╔═╡ f5589ea2-d055-4b8b-8575-f60f5d821745
df = DataFrame(CSV.File(HTTP.get("https://raw.githubusercontent.com/guebin/SC2024/main/toeic.csv").body))

# ╔═╡ 5a4cf8cd-f2da-482c-9a66-c911e8a01a82
md"""
> toeic ≈ teps인 상황이다.
"""

# ╔═╡ 08d81543-3a3e-4f3a-99ed-e8c5586c8353
let
	n = 5000
	X1,X2,X3 = eachcol(df)
	X = [X1 X2 X3] 
	for i in 1:10
		y = 600*X1 + 5*X2 + 300*randn(n)
		β̂ = inv(X'X)X'y 
		_,β̂2,β̂3 = β̂
		@show β̂
		@show β̂2+β̂3 # 지 나름대로의 규칙은 있었음 
		println("--")
	end
end

# ╔═╡ 03eb6cb3-4b6c-4179-bdde-f4510d277b31
md"""
> 다중공선성이 있는 설명변수의 계수는 불안정하나(분산이 엄청 크다.), 둘의 합은 5 근처에서 안정적이다.
"""

# ╔═╡ 24fb1cb7-2c64-4fac-a76f-a6a1c2a43023
md"""
`-` 다중공선성의 문제점

1. 해석 불가능한 (혹은 해석이 매우 어려운) 계수값을 모형이 추정한다.
*  $X_2, X_3$가 서로 종속되어 있으면, $\hat\beta_2, \hat\beta_3$의 추정치도 서로 종속되어 있어 계수값 해석에는 이러한 종속관계를 이해하여 해석해야 함.

2. 추정값의 분산이 매우 크다.
*  $\hat\beta_1$은 잘 추정되는 편이나, $\hat\beta_2, \hat\beta_3$의 값은 뭐가 나올지 전혀 예측할 수 없다.
*  $\hat\beta_2 + \hat\beta_3 \approx 5$라는 규칙만 있다면 대충 어떤 값을 찍어도 사실상 "수학적으로는 참모형"이다.
* 관측치가 조금만 바뀌어도 (새로운 데이터가 몇개 추가되기만 해도) 기존에 추정했던 계수값이 다 깨짐.
"""

# ╔═╡ fdab6d81-ba42-4625-ac2f-b1ac8ed4a88c
let 
	n = 5000
	N = 10000
	X1,X2,X3 = eachcol(df)
	X = [X1 X2 X3] 
	E = 300*randn(n,N)
	Y = (600*X1 + 5*X2) .+ E
	B̂ = inv(X'X)X'Y
	β̂1s,β̂2s,β̂3s = eachrow(B̂)
	p1 = histogram(β̂1s,alpha=0.5,label="β̂1")
	p2 = histogram(β̂2s,alpha=0.5,label="β̂2")
	p3 = histogram(β̂3s,alpha=0.5,label="β̂3")
	plot(p1,p2,p3)
end

# ╔═╡ ea6409f1-dd41-4310-bd0a-dbe070dfa58a
md"""
> 분포의 분산이 엄청나게 큰 것을 시뮬레이션으로 확인할 수 있음.

상상실험: 주어진 train에서 계수값을 추정한 결과, 토익을 1점 올리면 연봉이 5005만원 상승하고, 텝스를 1점 올리면 연봉이 5000만원 감소하는 법칙을 발견했다고 가정하자.

이제 test에서 아래와 세명의 학생을 만났다고 가정하자.

* 학생1: 토익 805, 텝스 805

* 학생2: 토익 800, 텝스 810

* 학생3: 토익 810, 텝스 800

토익,텝스점수만으로 결정한 학생1,2,3 의 연봉은 아래와 같다.

* 학생1의 연봉 = 4025

* 학생2의 연봉 = -46000

* 학생3의 연봉 = 54050

상상실험의 결론: train 에서는 수학적으로 토익1점당 연봉이 5005 상승, 텝스1점당 연봉 5000 감소와 같이 모형이 적합되었다고 해도, test 에서 그 모형은 완전히 설득력을 잃을 수도 있다.
"""

# ╔═╡ c0ee5dee-6b1a-4199-9085-d9355d618381
md"""
> 다중공선성의 해결방안은 전통적으로 PCA나 손실함수에 벌점함수를 추가하는 방법(Ridge, Lasso)이 있다. (회귀분석에서는 변수선택, 능형회귀추정량, 주성분분석을 추천하고 있다.)
"""

# ╔═╡ ae3531fb-1f81-49fb-9fcf-8dd5cc823094
md"""
### **C. 다중공선성의 해결 : 능형회귀**
"""

# ╔═╡ e625a1f5-d1f2-4082-b238-9644084d2591
md"""
 $\bf y = X\boldsymbol \beta + \boldsymbol\epsilon, ~ \boldsymbol \epsilon \overset{i.i.d}{\sim} N(0, \sigma^2)$라고 할 때, 오차제곱합을 최소로 하는 선형회귀분석에서의 회귀계수 추정량 $\boldsymbol{\hat \beta} = \bf (X^{\top}X)^{-1}X^{\top}y$의 평균제곱합 $MSE(\boldsymbol{\hat \beta})$는 다음과 같다.

$$\begin{align}
MSE(\boldsymbol{\hat \beta}) & = \bf E[\boldsymbol{\hat \beta - E(\boldsymbol{\hat\beta})}]^{\top}[\boldsymbol{\hat \beta - E(\boldsymbol{\hat\beta})}] + \text{Bias}[E(\boldsymbol{\hat\beta}) - \beta]^{\top}[E(\boldsymbol{\hat\beta}) - \beta] \\
& = tr(Var(\boldsymbol{\hat \beta})) \\
& = tr((X^{\top}X)^{-1}\sigma^2)
\end{align}$$

이 때, $\bf X$를 특이값 분해(SVD) 형태로 나타내면 $\bf X = UDV^{\top}$이고, 위 수식은 아래와 같이 나타낼 수 있다.

$$\begin{align}
MSE(\boldsymbol{\hat \beta}) & = tr(\bf (VDU^{\top}UDV^{\top})^{-1}\sigma^2) \\
& = tr(\bf VD^{-2}V^{\top}\sigma^2) \\
& = \sigma^2 tr(\bf D^{-2}V^{\top}V) \\
& = \sigma^2 \sum_{j = 1}^{p}\frac{1}{d_j^2}
\end{align}$$
"""

# ╔═╡ be2737cf-17bd-423f-a0c9-a774b072c22a
md"""
설명변수 간 다중공선성이 존재하면 작은 특이값이 0에 가까워지게 되는데, 이에 따라 회귀계수의 분산이 커지게 된다. 따라서 이러한 문제를 해결하고자 $\boldsymbol{\hat\beta}$에 대한 L2 패널티 항을 아래와 같이 기존 손실함수에 추가한다.

$loss_{\text{L}^2} := \big({\bf y}-{\bf X}{\boldsymbol \beta} \big)^\top \big({\bf y}-{\bf X}{\boldsymbol \beta}  \big) + \lambda {\boldsymbol \beta}^\top{\boldsymbol \beta}$

이 손실함수를 최소화하는 추정량 $\boldsymbol{\hat \beta}^R = \bf(X^{\top}X + \lambda I)^{-1}X^{\top}y$을 능형회귀 추정량(Ridge estimator)라고 하며, $\bf X^{\top}X$가 양반정치행렬이고 $\lambda > 0$이므로, $\bf(X^{\top}X + \lambda I_p)^{\top}$은 양정치행렬이 되고, 역행렬이 항상 존재한다.

또한 $\boldsymbol{\hat\beta}^R$의 MSE는 다음과 같이 나타낼 수 있다.

$$\begin{align}
\text{MSE}(\boldsymbol{\hat\beta}^R) & = tr(Var(\boldsymbol{\hat \beta}^R)) + \big(E(\boldsymbol{\hat\beta}^R) - \boldsymbol\beta \big)^{\top}\big(E(\boldsymbol{\hat\beta}^R) - \boldsymbol\beta \big) \\
& = tr\bigg(\bf \big(( VD^2V^{\top} + \lambda V I V^{\top} )^{-1}\big)VDU^{\top}\sigma^2 I UDV^{\top}\big(( VD^2V^{\top} + \lambda V I V^{\top} )^{-1}\big)^{\top}\bigg) \\
& + \big(\bf (VD^2V^{\top} + \lambda VIV^{\top})^{-1}VD^2V^{\top}\boldsymbol \beta - \boldsymbol \beta\big)^{\top}\big(\bf (VD^2V^{\top} + \lambda VIV^{\top})^{-1}VD^2V^{\top}\boldsymbol \beta - \boldsymbol \beta\big) \\
& = tr\bigg(\bf (V(D^2 + \lambda I)V^{\top})^{-1}VD^2V^{\top}\big((V(D^2 + \lambda I)V^{\top})^{-1}\big)^{\top} \bigg)\sigma^2 \\
& + \bf \bigg(V\big((D^2+\lambda I)^{-1}D^2 - I\big)V^{\top}\boldsymbol \beta\bigg)^{\top}\bigg(V\big((D^2+\lambda I)^{-1}D^2 - I\big)V^{\top}\boldsymbol \beta\bigg) \\
& = tr\bigg(\bf V\big(D^2 + \lambda I \big)^{-1}D^2\big(D^2 + \lambda I \big)^{-1}V^{\top}\bigg)\sigma^2 + \boldsymbol \beta^{\top} \bf V(-\lambda I)(D^2 + \lambda I)^{-2}(-\lambda I)V^{\top}\boldsymbol \beta \\
& = \sigma^2\sum_{j = 1}^{p}\frac{d_j^2}{(d_j^2 + \lambda)^2} + \sum_{j = 1}^{p}\frac{\lambda^2}{(d_j^2+\lambda)^2}(\boldsymbol \beta^{\top}V_j)^2
\end{align}$$
"""

# ╔═╡ 68a139a9-59d9-41cc-9702-7f534846e7db
md"""
설명변수 간 다중공선성이 존재하여 작은 특이값 몇이 0에 가깝다고 한다면, $MSE(\boldsymbol{\hat \beta})$에서의 분모가 작아져 그 값이 커지게 되지만, $MSE(\boldsymbol{\hat \beta^R})$의 경우 그 값은 $\lambda$에도 의존하기 때문에 능형회귀에서의 MSE가 더 작다는 관점에서 $\boldsymbol{\hat \beta^R}$는 더 좋은 추정량이 된다.
"""

# ╔═╡ d258f0d9-1dbf-4eb6-8815-ab0b82c8a6fa
md"""
## 5. 벡터 미분

---
"""

# ╔═╡ f69077db-13ed-4e90-9dd4-663da453c67b
md"""
!!! info "벡터미분" 
	임의의 벡터 ${\bf y}_{n \times 1}$를 고려하자. 벡터미분은 아래와 같은 **벡터비슷한것**으로 정의한다. 
	
	$$\frac{\partial}{\partial \bf y}=\begin{bmatrix} \frac{\partial}{\partial y_1} \\ \frac{\partial}{\partial y_{2}} \\ \dots  \\ \frac{\partial}{\partial y_n} \end{bmatrix}$$

	대부분의 경우에서 $\frac{\partial}{\partial \bf y}$ 은 (n,1) col-vector 처럼 생각해도 무방하다. (그렇지만 col-vector 자체는 아니다) 
"""

# ╔═╡ cd8c801f-6f97-4fb5-85b3-4119a0ba10c9
md"""
!!! warning "공식 억지로 외울필요 없음"
	언급하였듯이 그냥 $\frac{\partial}{\partial \bf y}$자체를 $n\times 1$ 매트릭스로 생각하고 $\bf z^\top$를 $1\times n$ 매트릭스로 생각하는 것이 속편하다. 즉 아래와 같이 생각하자. 
	
	$$\frac{\partial }{\partial \bf y}{\bf z}^\top=
	\begin{bmatrix}
	\frac{\partial}{\partial y_1}\\
	\dots\\
	\frac{\partial}{\partial y_n}\\
	\end{bmatrix}
	[z_1,\dots,z_n]=\begin{bmatrix} 
	\frac{\partial z_1}{\partial y_1} & \frac{\partial z_2}{\partial y_1} & \dots  & \frac{\partial z_n}{\partial y_1} \\
	\frac{\partial z_1}{\partial y_2} & \frac{\partial z_2}{\partial y_2} & \dots  & \frac{\partial z_n}{\partial y_2} \\
	\dots & \dots & \dots  & \dots \\
	\frac{\partial z_1}{\partial y_n} & \frac{\partial z_2}{\partial y_n} & \dots  & \frac{\partial z_n}{\partial y_n}
	\end{bmatrix}$$

	이러면 공식 안외워도 된다.
"""

# ╔═╡ 5e7e945f-6e1f-4e2a-bdee-29b28b3956ba
md"""
**벡터 미분도 곱의 미분법과 Chain Rule을 따른다는 사실을 명심할 것!!!**
"""

# ╔═╡ a13213a6-08c9-4037-a7f1-1409ec568401
md"""
## 6. 변환을 의미하는 행렬
"""

# ╔═╡ 7789fdd2-4ea8-417b-bbfb-2e5f2fdc0370
md"""
### **A. 열 단위 변환**
"""

# ╔═╡ a1ca3cf4-13e4-419d-b202-bcb8579d2f48
md"""
`-` 변환을 의미하는 행렬 $\bf A$가 데이터를 의미하는 행렬 $\bf X$앞에 곱해지는 경우, $\bf A$는 $\bf X$의 열별로 정의되는 선형변환을 의미한다.

$$\bf AX = \begin{bmatrix} \bf AX_1 & \bf AX_2 & \cdots & \bf AX_p\end{bmatrix}$$
"""

# ╔═╡ 4dfe627b-d2a6-4515-a19c-dacec57de21c
md"""
`-` 예시

* 열별로 평균 계산 : $\frac1n j_n^{\top}$

$\frac1n j_n^{\top}\bf X = [\bar x_1 ~ \bar x_2 ~ \cdots ~ \bar x_p]$

* 전체값 센터링 : $\bf \bar C_n$

$\bf (I - \frac1n J_n)X = \begin{bmatrix}
	x_{11} - \bar x_1 & x_{12} - \bar x_2 & \cdots & x_{1p} - \bar x_p \\
	x_{21} - \bar x_1 & x_{22} - \bar x_2 & \cdots & x_{2p} - \bar x_p \\
	\vdots & \vdots & \ddots & \vdots \\
	x_{n1} - \bar x_1 & x_{n2} - \bar n_2 & \cdots & x_{np} - \bar x_p \\
\end{bmatrix}$

* 공분산행렬(센터링 응용) : $\bf X^{\top}\bar C_n X$

$\frac{1}{n-1}\bf X^{\top}(I - \frac1n J_n)^{\top}(I - \frac1n J_n)X = \frac{1}{n-1}X^{\top}(I - \frac1n J_n)X = \Sigma$

* 총제곱합(SST) : $\bf y^{\top}\bar C_n y$

$\text{SST} = \bf y^{\top}(I - \frac1n J_n)y$

* 이동평균(Running Average)

$\bf M = \begin{bmatrix}
	1 & 1 & 0 & 0 & 0 & \cdots & 0 & 0\\
	1 & 1 & 1 & 0 & 0 & \cdots & 0 & 0\\
	0 & 1 & 1 & 1 & 0 & \cdots & 0 & 0\\
	\vdots & \vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
	0 & 0 & 0 & 0 & 0 & \cdots & 1 & 1
\end{bmatrix}/3$
"""

# ╔═╡ cea7c29a-5f46-4ab3-b8b2-c43969f460e2
let 
	Random.seed!(43052)
	n = 100
	t = (1:n)/n
	y = sin.(2π*t) + randn(n)*0.2
	scatter(t,y,alpha=0.2,color="gray")
	dl,d,du = ones(n-1)/3, ones(n)/3, ones(n-1)/3
	M = Tridiagonal(dl,d,du)
	k = 20
	@show k  ## M이란 변환을 반복할수록 더 스무딩이 됨.
	plot!(t,(M^k)*y,linewidth=2, color="red")
end

# ╔═╡ 7357ef6c-f53d-41d7-97c3-8cd03114c020
md"""
### **B. 행 단위 변환**
"""

# ╔═╡ def5636e-cb44-4e1b-bc90-ac4ca93826d3
md"""
`-` 변환을 의미하는 행렬 $\bf A$가 데이터를 의미하는 행렬 $\bf X$ 뒤에 곱해지는 경우 $\bf A$는 $\bf X$의 행별로 적용되는 어떠한 선형변환을 의미한다.

$$\bf XA = \begin{bmatrix}
	x_1^{\top}A \\
	x_2^{\top}A \\
	\vdots \\
	x_n^{\top}A \\
\end{bmatrix}$$
"""

# ╔═╡ f104e097-1a5f-4a8a-b0ff-935da248aa3a
md"""
아래와 같은 n×2 matrix를 가져오자.
"""

# ╔═╡ a169e60a-050a-4009-b9bb-d0c6d604cf04
default(markerstrokewidth = 0, alpha = 0.5)

# ╔═╡ 921b4657-c6fd-46f9-85d3-f13a2e966e69
begin
	url = "https://raw.githubusercontent.com/guebin/2021IR/master/_notebooks/round2.csv"
	dt = CSV.File(download(url))
	Y1,Y2 = dt.x[1:30:end], dt.y[1:30:end]
	Y = [Y1 Y2]
	scatter(
		Y1,Y2,
		xlim=(-1000,2000),ylim=(-750,1500),
		label = "Y"
	)
end

# ╔═╡ 72dcd5f2-ed09-4f2b-8346-9bf030a329ab
md"""
`-` 스케일링하는 변환 : $A = \begin{bmatrix} d_1 & 0 \\ 0 & d_2 \end{bmatrix}$

 $x$축으로 $d_1$배, $y$축으로 $d_2$배

`-` 한 축으로 사영(한쪽 스케일을 0으로) : $A = \begin{bmatrix} 1 & 0 \\ 0 & 0 \end{bmatrix} ~ \text{or} ~ \begin{bmatrix} 0 & 0 \\ 0 & 1 \end{bmatrix}$

`-` 대칭이동 : $A = \begin{bmatrix} -1 & 0 \\ 0 & 1 \end{bmatrix} ~ \text{or(y축 대칭)} ~ \begin{bmatrix} 1 & 0 \\ 0 & -1 \end{bmatrix} ~ \text{or(x축 대칭)} ~ \begin{bmatrix} -1 & 0 \\ 0 & -1 \end{bmatrix} ~ \text{대각}$

`-` 회전이동 : $A = \begin{bmatrix} \cos(\theta) & -\sin(\theta) \\ \sin(\theta) & \cos(\theta) \end{bmatrix}$
"""

# ╔═╡ 593dd552-2e10-4c78-bfa2-7f9e9acb80bf
let
	## x축으로 2배, y축으로 0.5배 스케일링
	# A = [2.0 0
	# 	 0 	 0.5]
	## x축으로 정사영
	# A = [1 0
	# 	 0 0]
	## y축으로 정사영
	# A = [0 0
	# 	 0 1]
	## x, y축 대칭
	# A = [-1  0
	# 	  0 -1]
	## 회전이동
	θ = 0.2π
	A = [ cos(θ) -sin(θ)
		  sin(θ)  cos(θ)]
	Z = Y*A
	Z1, Z2 = eachcol(Z)
	scatter(Y1,Y2, xlim=(-1000,2000),ylim=(-750,1500),label="Y")	
	scatter!(Z1,Z2,label="YA")
end

# ╔═╡ 4bb31695-2b0b-4c57-89f0-b6c7bf8113cc
md"""
`-` **디커플링** : $\bf A = \Psi\Lambda^{-\frac12} = VD^{-1} \Leftarrow \bf X^{\top}X = \Psi\Lambda\Psi^{\top} = VDU^{\top}UDV^{\top} = VD^2V^{\top}$
"""

# ╔═╡ 760aac93-6928-4030-ab9b-f7aed9e85544
let 
	Random.seed!(43052)
	n = 500
	μ = [0,0]
	Σ = [1.0 0.7
		 0.7 2.0]
	X = rand(MvNormal(μ,Σ),n)'
	X1,X2 = eachcol(X)
	p1 = scatter(X1,X2,alpha=0.2,xlim=(-5,5),ylim=(-6,6),label="X")
	Σ̂ = cov(X)
	λ,Ψ = eigen(Σ̂)
	A = Ψ*Diagonal(.√(1 ./λ))  ## XVD^{-1}, X를 직교하게 만들고 스케일링을 수행
	Z = X*A 
	Z1,Z2 = eachcol(Z)
	p2 = scatter(Z1,Z2,alpha=0.2,xlim=(-5,5),ylim=(-6,6),label="XA")
	plot(p1,p2)
end 

# ╔═╡ ecba1cf4-b706-4761-a134-6d4f6a2982d8
md"""
### **C. 직교행렬**
"""

# ╔═╡ 022a7914-92c7-4ce0-89bd-4870a665574c
md"""
* 데이터를 나타내는 행렬이 직교행렬이라면, 각 열들의 공분산(내적)이 모두 0이 되므로 각 데이터들이 서로 다른 정보를 가지고 있다고 볼 수 있다.

* 어떠한 벡터에 직교행렬이 변환으로 적용되면, 그 벡터는 크기와 각도가 모두 보존된다. 즉, 벡터들에 직교행렬을 곱한다는 것은 벡터들이 가지는 정보를 모두 보존한 상태에서 자료를 보는 관점을 변화시키는 변환이라고 볼 수 있다.

**열벡터에 적용되는 경우**
- 크기보존: $\|{\boldsymbol X}_1\|^2=\|{\bf A} {\boldsymbol X}_1\|^2$ 이므로 크기가 보존 
- 각도보전: $\frac{{\boldsymbol X}_1 \cdot {\boldsymbol X}_2}{\|{\boldsymbol X}_1\|\|{\boldsymbol X}_2\|}=\frac{({\bf A}{\boldsymbol X}_1)\cdot ({\bf A}{\boldsymbol X}_2)}{\|{\bf A}{\boldsymbol X}_1\|\|{\bf A}{\boldsymbol X}_2\|}$(이거 분자 행렬곱이 아니라 내적임) 이므로 각도도 보존 

**행벡터에 적용되는 경우**
- 크기보존: $\|{\boldsymbol x}_1^\top\|^2=\|{\boldsymbol x}_1^\top {\bf A} \|^2$ 이므로 크기가 보존
- 각도보전: $\frac{{\boldsymbol x}_1^\top \cdot {\boldsymbol x}_2^{\top}}{\|{\boldsymbol x}_1^\top\|\|{\boldsymbol x}_2^\top\|}=\frac{({\boldsymbol x}_1^\top{\bf A})\cdot ({\boldsymbol x}_2^\top{\bf A})}{\|{\boldsymbol x}_1^\top {\bf A}\|\|{\boldsymbol x}_2^\top{\bf A}\|} = \cos(\theta)$ 이므로 각도도 보존 ( $x_1 ㆍ x_2 = ||x_1||||x_2|| \cos (\theta)$)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.14"
Distributions = "~0.25.108"
HTTP = "~1.10.8"
Images = "~0.26.1"
Plots = "~1.40.4"
PlutoUI = "~0.7.58"
RDatasets = "~0.7.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "fd16ec0ac632f38c89b815fc4cd424a4ab9d3ef1"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "6a55b747d1812e699320963ffde36f1ebdda4099"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.4"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "133a240faec6e074e07c31ee75619c90544179cf"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.10.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "585a387a490f1c4bd88be67eea15b93da5e85db7"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.5"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a2f1c8c668c8e3cb4cca4e57a8efdb09067bb3fd"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+2"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "575cd02e080939a33b6df6c5853d14924c08e35b"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.23.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "70232f82ffaab9dc52585e0dd043b5e0c6b714f1"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.12"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "9ebb045901e9bbf58767a9f34ff89831ed711aae"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "4b270d6465eb21ae89b732182c20dc165f8bf9f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.25.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "6cbbd4d241d7e6579ab354737f4dd95ca43946e1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.1"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "22c595ca4146c07b16bcf9c8bea86f731f7109d2"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.108"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "82d8afa92ecf4b52d78d869f038ebfb881267322"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.3"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "9f00e42f8d99fdde64d40c8ea5d14269a2e2c1aa"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.21"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "0653c0a2396a6da5bc4766c43041ef5fd3efbe57"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.11.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "ddda044ca260ee324c5fc07edb6d7cf3f0b9c350"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.5"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "278e5e0f820178e8a26df3184fcb2280717c79b1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.5+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "43ba3d3c82c18d88471cfd2924931658838c9d8f"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+4"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "7c82e6a6cd34e9d935e9aa4051b66c6ff3af59ba"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.2+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "4f2b57488ac7ee16124396de4f2bbdd51b2602ad"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.11.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "eb8fed28f4994600e29beef49744639d985a04b2"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.16"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "f218fe3736ddf977e0e772bc9a586b2383da2685"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.23"

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

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "f5356e7203c4a9954962e3757c08033f2efe578a"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.0"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "3447781d4c80dbe6d71d239f7cfb1f8049d4c84f"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.6"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "437abb322a41d527c197fa800455f79d414f0a3c"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.8"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils", "Libdl", "Pkg", "Random"]
git-tree-sha1 = "5bc1cb62e0c5f1005868358db0692c994c3a13c6"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d65554bad8b16d9562050c67e7223abf91eaba2f"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.13+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "44664eea5408828c03e5addb84fa4f916132fc26"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.1"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "e0884bdf01bbbb111aea77c348368a86fb4b5ab6"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.1"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "12fdd617c7fe25dc4a6cc804d657cc4b2230302b"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.1"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "ea8031dea4aff6bd41f1df8f2fdfb25b33626381"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.4"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be50fe8df3acbffa0274a744f1a99d29c45a57f4"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.1.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"
weakdeps = ["Unitful"]

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "PrecompileTools", "Reexport", "Requires", "TranscodingStreams", "UUIDs", "Unicode"]
git-tree-sha1 = "bdbe8222d2f5703ad6a7019277d149ec6d78c301"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.48"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c84a835e1a09b289ffcd2271bf2a337bbdda6637"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.3+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "70c5da094887fd2cae843b8db33920bac4b6f07d"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "e0b5cd21dc1b44ec6e64f351976f961e6f31d6c4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.3"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "62edfee3211981241b57ff1cedf4d74d79519277"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.15"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "9fd170c4bbfd8b935fdc5f8b7aa33532c991a673"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.11+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fbb1f2bef882392312feb1ede3615ddc1e9b99ed"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.49.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0c4f9c4f1a50d8f35048fa0532dabbadf702f81e"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "fa7fd067dca76cadd880f1ca937b4f387975a9f5"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.16.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "18144f3e9cbe9b15b070288eef858f71b291ce37"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.27"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "8f6786d8b2b3248d79db3ad359ce95382d5a6df8"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.170"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "80b2833b56d466b3858d565adcd16a4a05f2089b"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.1.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "bf17d9cb4f0d2882351dfad030598f64286e5936"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.7.8"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ded64ff6d4fdd1cb68dfcbb818c69e144a5b2e4c"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.16"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "e64b4f5ea6b7389f6f046d13d4896a8f9c1ba71e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "f4cb457ffac5f5cf695699f82c537073958a6a6c"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.2+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3da7367955dcc5c54c1ba4d402ccdc09a1a3e046"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.13+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "442e1e7ac27dd5ff8825c3fa62fbd1e86397974b"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.4"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "240d7170f5ffdb285f9427b92333c3463bf65bf6"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.1"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

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

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "88b895d13d53b5577fd53379d913b9ab9ac82660"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "763a8ceb07833dd51bb9e3bbca372de32c0605ad"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.0"

[[deps.PtrArrays]]
git-tree-sha1 = "f011fbb92c4d401059b2212c05c0601b70f8b759"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "994cc27cdacca10e68feb291673ec3a76aa2fae9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.6"

[[deps.RData]]
deps = ["CategoricalArrays", "CodecZlib", "DataFrames", "Dates", "FileIO", "Requires", "TimeZones", "Unicode"]
git-tree-sha1 = "19e47a495dfb7240eb44dc6971d660f7e4244a72"
uuid = "df47a6cb-8c03-5eed-afd8-b6050d6c41da"
version = "0.8.3"

[[deps.RDatasets]]
deps = ["CSV", "CodecZlib", "DataFrames", "FileIO", "Printf", "RData", "Reexport"]
git-tree-sha1 = "2720e6f6afb3e562ccb70a6b62f8f308ff810333"
uuid = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
version = "0.7.7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d483cd324ce5cf5d61b77930f0bbd6cb61927d21"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.2+0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "5680a9276685d392c87407df00d57c9924d9f11e"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.7.1"
weakdeps = ["RecipesBase"]

    [deps.Rotations.extensions]
    RotationsRecipesBaseExt = "RecipesBase"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "2803cab51702db743f3fda07dd1745aadfbf43bd"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.5.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "3aac6d68c5e57449f5b9b865c9ba50ac2970c4cf"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.42"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "90b4f68892337554d31cdcdbe19e48989f26c7e6"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.3"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "d2fdac9ff3906e27f7a618d47b676941baa6c80c"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.10"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Requires", "SparseArrays", "Static", "SuiteSparse"]
git-tree-sha1 = "5d66818a39bb04bf328e92bc933ec5b4ee88e436"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.5.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "9ae599cd7529cfce7fea36cf00a62cfc56f0f37c"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.4"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "cef0472124fab0695b58ca35a77c6fb942fdab8a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.1"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TZJData]]
deps = ["Artifacts"]
git-tree-sha1 = "1607ad46cf8d642aa779a1d45af1c8620dbf6915"
uuid = "dc5dba14-91b3-4cab-a142-028a31da12f7"
version = "1.2.0+2024a"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "cb76cf677714c095e535e3501ac7954732aeea2d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.11.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "bc7fd5c91041f44636b2c134041f7e5263ce58ae"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.0"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

[[deps.TimeZones]]
deps = ["Dates", "Downloads", "InlineStrings", "Mocking", "Printf", "Scratch", "TZJData", "Unicode", "p7zip_jll"]
git-tree-sha1 = "6505890535a2b2e5145522ac77bddeda85c250c4"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.16.1"
weakdeps = ["RecipesBase"]

    [deps.TimeZones.extensions]
    TimeZonesRecipesBaseExt = "RecipesBase"

[[deps.TranscodingStreams]]
git-tree-sha1 = "5d54d076465da49d6746c647022f3b3674e64156"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.8"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "dd260903fdabea27d9b6021689b3cd5401a57748"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.20.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "6129a4faf6242e7c3581116fbe3270f3ab17c90d"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.67"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "52ff2af32e591541550bd753c0da8b9bc92bb9d9"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.7+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ac88fb95ae6447c8dda6a5503f3bafd496ae8632"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.6+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e678132f07ddb5bfa46857f0d7620fb9be675d3b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7d0ea0f4895ef2f5cb83645fa689e52cb55cf493"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2021.12.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─56d6b120-11b8-11ef-0a96-813d616625a0
# ╠═e7c0312a-a5b9-495a-a44b-6ae292313ea9
# ╠═6e4727f6-d505-433e-94d4-b1efd44c1fc4
# ╠═503e9e0a-a5f7-4b19-94cc-3adaf673a79b
# ╟─73efddba-46cc-4739-bbfc-c0ee3414ac5d
# ╟─6ed39091-a9ef-4795-b59f-bfaab857df2d
# ╠═f50cda22-0b85-4580-81da-43aa5d5d304b
# ╠═5a1894d8-a894-4732-bdc6-90ed4f01519c
# ╟─ebaa72f5-7e6b-4284-ae3f-97915f67a348
# ╠═d435fbf9-ae40-40b8-9abf-fdcdcd0a86c7
# ╟─20f8579d-ae50-41fa-83b2-937a9e8d6a8f
# ╠═71920666-d590-479b-90b0-37a1af7566fc
# ╟─07fb05d1-0d3f-4783-895a-98bcb5c70489
# ╠═0834ec62-d79d-4139-ab33-2c3ca2fe34b6
# ╠═302a0283-ee3b-4fbb-831e-008202775c71
# ╟─c676dce2-0045-48f0-a5ec-1a42b4619c7e
# ╟─1234f31e-55bb-4e65-910f-28d8e64b5295
# ╠═d29d4e1a-a704-4704-84f4-c6eae3c36d86
# ╠═f4b76421-5d76-4b30-ba5d-db754afda812
# ╟─b6eb066a-56a6-482e-8eba-1100575bee30
# ╟─427ad2af-beb5-413e-aeb8-37affae10eb1
# ╠═76323502-a963-4d1c-9fb3-fd66d74a9cd3
# ╠═f2ff16e3-3e58-4315-90a2-d1bb01a599bb
# ╠═5c4c3c0a-4d34-4b60-90e8-2948b1a29cd2
# ╟─fa18aded-5de3-4c88-ab2a-48ac6635d7e4
# ╠═d58e9cda-3dd8-4764-8bc7-b7ed185ba123
# ╠═4e1e9b4c-7ae7-450e-a648-163d317170c1
# ╟─d3ce8d58-f187-43dc-95be-7154567e9480
# ╟─189800ad-2d41-4f0f-b987-e39db32f6782
# ╠═3c1126c0-ae6d-4052-8042-2bc89f629f8a
# ╠═27f3a1b4-b447-4f65-98e7-4eb7a6b68f3e
# ╟─63b30063-4142-4212-82ee-75010416a771
# ╟─30609c65-8ad8-4343-b7b3-e66c9c4bb92a
# ╠═037713f9-1703-48fc-a4c8-2244f74749f0
# ╟─4be1e972-85f9-472c-b457-65ed679a1342
# ╠═62715ee9-c512-404e-9411-b9c624a7da00
# ╠═8824eb80-3f0f-4a57-9f6a-f9f72003dc3f
# ╟─cddd92fc-a75a-415b-9885-ea856d67e8a0
# ╟─a88e3113-2676-405a-a7d6-1be574456f69
# ╟─cb290f74-1dc9-432c-91bb-6a4614a66b68
# ╟─a756bf85-38f8-460d-bd5f-95059b51c1bc
# ╟─15ea5b7d-5fbc-4f06-8eba-80fae726d43e
# ╠═da8c6f35-ce43-4aa1-86d1-ad221f6214ca
# ╠═5b345e21-a675-46ee-9133-453cb1512f14
# ╟─757acf58-11bb-4abd-9444-15cb9bb310fd
# ╟─0e804e95-56b9-4f13-b37a-7f5bb15ce879
# ╟─916827a4-2a9f-4b9a-93ee-1eeeb50461ab
# ╟─870b0a9f-2661-4db9-a0fa-1481c9b771cf
# ╠═f754cdd2-4aeb-4529-b119-20da8306a2f6
# ╠═9a80b3c5-b2b0-4467-9fe9-6e0c9f55f3a6
# ╟─c3bee2ec-474f-40cc-a4f8-cfca65d2150a
# ╟─2987a979-dd5a-485f-aafa-e0e8b4d83487
# ╠═c926ad48-e020-43f6-b141-36803c8caccf
# ╟─3bf43063-c6aa-48b2-9b3c-abf218ae40b0
# ╠═749ebb52-000a-4299-9520-ed3b3c0fd8af
# ╟─a474a3ae-2518-462a-99b4-2cac97c0d811
# ╠═953b27bb-e397-47d0-8219-2dbfcaebdb25
# ╟─10ec58d9-79bf-44c8-8d19-40a8db982642
# ╟─6908a2d0-4ef1-46a2-af96-de32647cd3c3
# ╟─9fc34bdc-4092-4eba-9ed0-8d7ae4925b88
# ╠═20394eaa-6969-46f9-a77d-e0f4aece0934
# ╟─dfbe0d7a-e5f8-4c5b-a2ad-f58eb0e10698
# ╟─cdfdee60-c095-4ac6-8231-7bce8b879549
# ╟─b94452af-1ec6-4cc3-ae8c-0d53c70c57a1
# ╟─94ebb3ad-d3c7-4c00-ba64-200e8276deae
# ╟─30bec97b-262a-4c97-98b4-d8ab04892621
# ╟─e4575f44-454c-40e8-9864-6c02054ada2f
# ╟─9b5948f5-bbd4-4518-9833-73bf37f0ec51
# ╟─487ba976-6b51-494e-99d9-101063d734df
# ╟─f6801e17-2bea-41fa-bb9f-505e10a3ff14
# ╟─0129cd06-2230-4219-a231-657bdc23ca7a
# ╟─38673ecb-b4a5-416d-a1ad-f78cfd9f9a6c
# ╟─808e59f6-a615-45e6-9dc7-9863da1fb781
# ╟─7d0b49e7-a6ab-499a-ad4c-a63a10853fc1
# ╟─c0ea6990-d3a4-4c64-8494-aa09c8d8c027
# ╟─f9e7de90-c06f-4529-994b-b3d1f8fd2404
# ╠═6568552c-c7ff-4f3f-a891-be9a801861ba
# ╟─07bcaec5-f414-476f-a403-7feecf5b956f
# ╟─1a0cbbc6-5f5b-4e15-90d5-7d1613405c25
# ╟─8d92734b-6b76-4eae-b44d-d36fbc9932f2
# ╠═1abb20ed-28f6-4ddb-9881-f576ea3793e6
# ╟─4febe3b0-b6bb-4c80-a815-fbdc7d0a9efe
# ╟─ff4500cb-02b8-48e2-9514-8420bb1f5bd3
# ╟─edc34495-5bb4-4c56-a580-ee4a6ee8469e
# ╟─d316a617-2f59-45f7-90d9-1b243165b5af
# ╟─15875303-0a13-49ae-b0d2-e70625315a1b
# ╠═f5589ea2-d055-4b8b-8575-f60f5d821745
# ╟─5a4cf8cd-f2da-482c-9a66-c911e8a01a82
# ╠═08d81543-3a3e-4f3a-99ed-e8c5586c8353
# ╟─03eb6cb3-4b6c-4179-bdde-f4510d277b31
# ╟─24fb1cb7-2c64-4fac-a76f-a6a1c2a43023
# ╠═fdab6d81-ba42-4625-ac2f-b1ac8ed4a88c
# ╟─ea6409f1-dd41-4310-bd0a-dbe070dfa58a
# ╟─c0ee5dee-6b1a-4199-9085-d9355d618381
# ╟─ae3531fb-1f81-49fb-9fcf-8dd5cc823094
# ╟─e625a1f5-d1f2-4082-b238-9644084d2591
# ╟─be2737cf-17bd-423f-a0c9-a774b072c22a
# ╟─68a139a9-59d9-41cc-9702-7f534846e7db
# ╟─d258f0d9-1dbf-4eb6-8815-ab0b82c8a6fa
# ╟─f69077db-13ed-4e90-9dd4-663da453c67b
# ╟─cd8c801f-6f97-4fb5-85b3-4119a0ba10c9
# ╟─5e7e945f-6e1f-4e2a-bdee-29b28b3956ba
# ╟─a13213a6-08c9-4037-a7f1-1409ec568401
# ╟─7789fdd2-4ea8-417b-bbfb-2e5f2fdc0370
# ╟─a1ca3cf4-13e4-419d-b202-bcb8579d2f48
# ╟─4dfe627b-d2a6-4515-a19c-dacec57de21c
# ╠═cea7c29a-5f46-4ab3-b8b2-c43969f460e2
# ╟─7357ef6c-f53d-41d7-97c3-8cd03114c020
# ╟─def5636e-cb44-4e1b-bc90-ac4ca93826d3
# ╟─f104e097-1a5f-4a8a-b0ff-935da248aa3a
# ╠═a169e60a-050a-4009-b9bb-d0c6d604cf04
# ╠═921b4657-c6fd-46f9-85d3-f13a2e966e69
# ╟─72dcd5f2-ed09-4f2b-8346-9bf030a329ab
# ╠═593dd552-2e10-4c78-bfa2-7f9e9acb80bf
# ╟─4bb31695-2b0b-4c57-89f0-b6c7bf8113cc
# ╠═760aac93-6928-4030-ab9b-f7aed9e85544
# ╟─ecba1cf4-b706-4761-a134-6d4f6a2982d8
# ╟─022a7914-92c7-4ce0-89bd-4870a665574c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
