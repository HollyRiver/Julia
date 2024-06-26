### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 3c5aa44e-d594-11ec-21d6-25d65911031d
using PlutoUI,Plots, Distributions, LinearAlgebra,RDatasets

# ╔═╡ 1f42323f-5074-41f8-bd6a-1806c123e149
md"""
# 08wk-1: 주성분분석 
"""

# ╔═╡ 67efeeff-8a5c-476f-ab22-f3ff4208439c
md"""
## 1. 강의영상
"""

# ╔═╡ 32bd60e5-2872-430a-8053-421b6e454f83
# html"""
# <div style="display: flex; justify-content: center;">
# <div  notthestyle="position: relative; right: 0; top: 0; z-index: 300;">
# <iframe src=
# "
# https://www.youtube.com/embed/playlist?list=PLQqh36zP38-w4vySc_CZBMkKdkXfaxnbV
# "
# width=600 height=375  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
# """
	

# ╔═╡ e36c494d-0e97-4010-a57d-fcd60ab93900
md"""
## 2. Imports
"""

# ╔═╡ 107c213d-b88e-4138-9a1e-0fba804f6e09
PlutoUI.TableOfContents()

# ╔═╡ 9af6ddd2-d726-4ed0-baa1-0c692d1f96d9
Plots.plotly()

# ╔═╡ ece414e2-e7dd-40f5-b401-5f5039d9b804
md"""
## 3. SVD의 응용: 주성분분석
"""

# ╔═╡ 5d183e7c-12bf-49bc-845a-80497a204ebc
md"""
> SVD를 통해서 원소 몇개만 가지고 행렬을 간단하게 나타낼 수 있었다. 더하기 꼴로 분해하거나, 곱하기 꼴로 분해할 수 있음. 더하기 꼴로 분해해서 일부만 더하는 방식으로 데이터를 근사...
"""

# ╔═╡ b3ab776c-9dbc-4e17-9f28-0c8f26bba169
md"""
-- 주성분분석(PCA)은 차원축소에 이용되거나 다중공선성의 해결에 이용되는 기법이다. 
"""

# ╔═╡ 174ef9ba-a3c0-4040-8d31-1cd6962b7b8f
md"""
-- **우선은 차원축소의 관점에서만 PCA를 서술해보자.**

: 열의 개수를 줄이는 거...
"""

# ╔═╡ d56fac91-c4c1-4529-9a75-8f4e007cf258
md"""
### A. PCA의 목적
"""

# ╔═╡ 45ca0b83-4ca4-4137-9cbf-a03ca32d4897
md"""
-- 데이터: 아래와 같은 $n\times p$ 매트릭스 (혹은 데이터프레임)이 있다고 하자. 

${\bf X}_{n\times p}$

- 통계학과에서 많이 쓰는 그 design matrix라고 생각하면 된다. 
- 여기에서 $n>p$ 를 가정한다. 

$$r(X) = p <<<<<< n$$

"""

# ╔═╡ 762c7cf9-73ab-4fce-9f74-177140560eec
md"""
-- 소망: `(1)` ${\bf X}$가 가지고 있는 정보는 거의 유지하면서 `(2)` 저장비용은 좀 더 저렴한 매트릭스 ${\bf Z}$를 만들고 싶다. (얌체아냐??)
- 정보를 거의 유지한다는 것이 무슨 말? 
- 저장비용이 저렴하다는 것은 무슨 말?

"""

# ╔═╡ 989e6e04-1d01-41be-9d77-973089e0264b
md"""
-- 소망을 좀 더 구체적으로 수식화하면 아래와 같다. 

`(1)` ${\bf Z}$의 차원이 $(n,q)$ 이며, (단 여기에서 $q<p$). 

`(2)` ${\bf Z}$에서 적당한 변환 ${\bf B}$를 하면 언제든지 ${\bf X}$와 비슷한 매트릭스로 복원(reconstruction) 할 수 있다. 즉

${\bf Z}{\bf B} \approx {\bf X}$

을 만족하는 적당한 ${\bf B}$가 존재한다. (이렇게 되면 변환 ${\bf B}$ 의 차원은 $(q,p)$ 가 되어야 한다.)

"""

# ╔═╡ 9c968667-0a77-42ce-b381-8aa3cf5e31e2
md"""
### B. SVD $\to$ ${\bf Z}$를 찾아보자.
"""

# ╔═╡ 0c36fb86-88e4-4f92-8b34-94944150f273
md"""
-- 우선 임의의 매트릭스 ${\bf X}_{n\times p}$의 SVD를 이용하면 적당히 아래를 만족하는 매트릭스들을 찾을 수 있다. 

- ``{\bf X}={\bf U}{\bf D}{\bf V}^\top= {\bf U}_1 {\bf D}_1 {\bf V}_1^\top+ {\bf U}_2 {\bf D}_2 {\bf V}_2^\top``
- ``{\bf X} \approx {\bf U}_1 {\bf D}_1 {\bf V}_1^\top`` *<-- 이렇게 잡을수 있는게 포인트!!*

여기에서 각 매트릭스의 차원은 

-  ${\bf U_1} : (n,q)$
-  ${\bf U_2} : (n,p-q)$
-  ${\bf D_1} : (q,q)$
-  ${\bf D_1} : (p-q,p-q)$
-  ${\bf V_1} : (p,q) \Rightarrow {\bf V^{\top}_1} : (q,p)$
-  ${\bf V_1} : (p,p-q) \Rightarrow {\bf V^{\top}_1} : (p-q,p)$
"""

# ╔═╡ ffd6d9f2-e4a5-4f06-a75b-242cb4ee71d1
md"""
-- 여기에서 ${\bf U}_1{\bf D}_1$를 유심히 관찰해보자. 아래와 같은 특징이 있다. 

`(1)` ${\bf U}_1{\bf D}_1$의 차원이 $(n,q)$ 이다. 

`(2)` ${\bf U}_1{\bf D}_1$에서 ${\bf V}_1^\top$를 곱하면 ${\bf X}$를 비슷하게 만들 수 있다.  ($\because {\bf U}_1{\bf D}_1{\bf V}_1 \approx {\bf X}$)

따라서 

${\bf Z}:={\bf U}_1{\bf D}_1, \quad {\bf B}:={\bf V_1}^\top$

와 같이 정의하면 PCA의 소망에서 언급한 `(1)`,`(2)`의 조건을 만족하게 된다. 
"""

# ╔═╡ 0ae3053c-51de-4fd0-809d-0df5f539de61
md"""
!!! info "주성분 분석"
	임의의 $(n,p)$ matrix ${\bf X}$ 에 대한 SVD가 아래와 같다고 하자. $(n \geq p)$.
	
	${\bf X} = {\bf U}{\bf D}{\bf V}^\top$

	이때 ${\bf Z}={\bf U}{\bf D}={\bf X}{\bf V}$ 의 each-column 을 주성분 (principle component) 라고 한다. 구체적으로 
	- PC1 = first column of ${\bf Z}$. 
	- PC2 = second column of ${\bf Z}$. 
	- ``\dots``
	- PCp = $p$-th column of ${\bf Z}$. 
	와 같이 부른다. 또한 ${\bf Z}$ 의 각 원소를 principal component score라고 부른다. 따라서 ${\bf Z}_{n \times p}$ 에는 $np$ 개의 principal component score가 있다. 그리고 ${\bf V}$ 는 rotation matrix 혹은 loading matrix 라고 부른다. 마지막으로 원래의 자료 ${\bf X}$를 그대로 분석하것이 아니라, ${\bf X}$를 ${\bf Z}$로 바꾼뒤에 분석하는 일련의 기법 (즉 ${\bf X}$의 주성분을 분석하는 기법)을 통칭하여 주성분분석이라고 한다. 
"""

# ╔═╡ 14ac8938-6de1-408c-ac99-a2dcbeef7e07
md"""
* column의 수만큼 주성분이 나옴(PC), 그리고 n×p개의 주성분 점수가 나온다.

* V는 직교행렬이므로 X를 회전시키는 변환을 한다고 이해가 가능 : rotation matrix

> X를 이용하는 것이 싫어서 Z로 바꿈. 그것들을 이용하는 것 자체가 주성분분석. 주성분분석에서 차원을 줄이거나 회귀를 하는 등의 분석 과정까지 주성분분석
"""

# ╔═╡ dcd8d3f1-5022-4b1b-a67e-4b57e856dbfa
md"""
!!! caution "U는 남겨둬야 함!"
	차원을 축소할 때 행을 축소하면 안되니까, U는 증발시키면 안돼...
"""

# ╔═╡ dd3262c1-d3fb-4feb-ac5b-187833541b19
md"""
### C. IRIS data
"""

# ╔═╡ cee6edd8-a040-4c7c-a417-854904fb413b
md"""
-- iris 데이터 로드
"""

# ╔═╡ ba4fdd2e-f83b-4b85-9ec2-85119c97ab15
iris = dataset("datasets","iris")

# ╔═╡ 0017fd0e-2ba5-4c30-a2f1-b0f6edf0c3c2
md"""
-- 각 열에 접근
"""

# ╔═╡ 70416c2d-5b83-40c3-bd5f-3dde9ef5ff2e
iris.SepalWidth  ## 판다스 데이터프레임처럼...

# ╔═╡ c3973f3f-2cba-4aaa-9f4b-1db2c43ab6dd
Array(iris[:, 1:4])  ## 데이터 슬라이싱 하듯...

# ╔═╡ 48178775-ed6f-45e8-bfcf-dbc1a93fa98d
md"""
-- 데이터의 정리
"""

# ╔═╡ 3620eaa8-5ed5-45c7-bac1-aaa2de363de4
X,y = Array(iris[:,1:4]), iris[:,5]  ## 다중 분류 문제처럼...

# ╔═╡ 238de6fe-735d-4ada-9543-3b78ff3f4b2a
md"""
-- SVD를 이용한 주성분 분석 수행
"""

# ╔═╡ c3a344ba-0f5d-420c-9511-61571e825c52
let
	# Z*B ≈ X  ## 이게 true가 되도록 하는 게 목적
	U, d, V = svd(X)

	U1, U2 = U[:, 1:2], U[:, 3:4]
	D1, D2 = Diagonal(d[1:2]), Diagonal([3:4])
	V1, V2 = V[:, 1:2], V[:, 3:4]

	Z = U1*D1  ## or X*V1' (150, 2). PC₁ + PC₂
	[X Z*V1']  ## (150, 4), 숫자를 반 정도 날렸는데 꽤 비슷함.
end

# ╔═╡ 92108017-9d7b-4434-be5f-1dd3c3811131
md"""
-- 주성분분석을 이용한 시각화(4차원을 인간따리가 인지할 수 있도록 시각화)
"""

# ╔═╡ e0550fad-df86-48a8-8ad0-f01eff85718b
let
	U, d, V = svd(X)  ## U : (150, 4)
	U1, U2, U3, U4 = eachcol(U)
	d1, d2, d3, d4 = d
	V1, V2, V3, V4 = eachcol(V)  ## V : (4, 4)
	PC1, PC2 = U1*d1, U2*d2  ## 각 주성분으로 쪼갬

	@show unique(y)
	
	p1 = scatter()
	for i in unique(y)
		scatter!(PC1[y .== i], PC2[y .== i], label = i)
	end

	p1
end

# ╔═╡ 00367152-c595-4a2e-9666-01d1a136b4f8
md"""
-- Perfect Reconstruction
"""

# ╔═╡ 22777cad-21a1-4101-b7ef-e6cbfe7adc64
let
	U, d, V = svd(X)
	Z = U*Diagonal(d)
	X ≈ Z*V'
end

# ╔═╡ 8975e5ea-b410-4c87-ba48-5fd8a639dc92
md"""
> 왜 Z로 바꿔서 분석할 때도 있는가?

Z의 각 열은 othogonal하기 때문에 다중공선성 문제에서 자유롭고, 오버피팅도 일어나지 않을 거라고 할 수 있다.
"""

# ╔═╡ 502c4e40-520b-4051-92d8-243e97ed7982
md"""
### D. PCA에 대한 자잘이들.
"""

# ╔═╡ 839ee40e-8e0a-409d-ac02-fad2233b7454
md"""
!!! info "자잘이1: 주성분분석시 보통 scaling을 선행한다"
	주성분분석을 할때 ${\bf X}$ 자체를 특이값분해하기 보다 ${\bf X}$를 열별로 표준화한것을 고려하는 경우가 많다. (이유는 ${\bf X}$가 가지고 있는 변수사이의 관계를 포착하기 위해서!!)
"""

# ╔═╡ ed227c0f-3d31-4ab4-bd32-a0728349412e
let
	X1, X2, X3, X4 = eachcol(X)
	# X1 .- mean(X1)  ## centering
	X1 = (X1 .- mean(X1))/std(X1)
	X2 = (X2 .- mean(X2))/std(X2)
	X3 = (X3 .- mean(X3))/std(X3)
	X4 = (X4 .- mean(X4))/std(X4)

	X = [X1 X2 X3 X4]  ## 보통은 이걸 X로 고려하여 분석함
	U, d, V = svd(X)
	Z = U*Diagonal(d)
end

# ╔═╡ 3e64482f-7fc6-4544-ab28-189dc7293830
md"""
!!! info "자잘이2: PC score를 쓰는 경우"
	PC score는 보통 observation 별로 분석하고 싶을 때 사용한다. 따라서 **"PC scores of $i$-th observation**" 와 같은 문맥으로 자주 쓴다. 
"""

# ╔═╡ 011afd61-b6bb-4070-a210-a2a720e7ad98
md"""
행별로 보통 표현한다는 얘기임... 관측치, 같은 행 별로 말하는 게 의미가 있음.
"""

# ╔═╡ 77a73681-4c75-4f71-b528-db32f18e5ed9
let
	U, d, V = svd(X)
	Z = U*Diagonal(d)
	Z[1, :]  ## PC scores of 1st observation. 첫 관측치에 대한 PC scores
end

# ╔═╡ cbe9a2f9-2874-4635-bac9-3b51d1a50a78
md"""
!!! info "자잘이3: ?? 개의 주성분이라는 표현"
	``{\bf X}_{n \times p}`` 인 행렬에서 주성분의 숫자는 최대 $p$개 까지 있을 수 있다. 만약에 **"${\bf X}$의 주성분을 고려하면"** 이라는 용어를 쓴다면 아래와 같은 ${\bf Z}$를 고려한다는 의미이다. (*다 쓴다고*)
	
	```julia
	U,d,V = svd(X) # X: (n,p)
	Z = U*Diagonal(d) # Z: (n,p)
	```

	만약에 **"${\bf X}$의 (처음) 3개 주성분만 고려하면"** 이라는 용어를 쓴다면 아래와 같은 ${\bf Z}$를 고려한다는 의미이다. (*처음 몇 개 열만 쓴다고*)

	```julia
	U,d,V = svd(X) # X: (n,p)
	Z = U[:,1:3]*Diagonal(d[1:3]) # Z: (n,3)
	```
"""

# ╔═╡ 2e2a7afe-b2ff-4683-9ab0-8474e946e8be
md"""
## 4. ${\bf Z}$를 계산하는 여러 방법
"""

# ╔═╡ b7ead0c1-079d-48ee-bf4c-aa699bb50161
md"""
### A. ${\bf Z} = {\bf UD}$
"""

# ╔═╡ a11710fd-111e-4977-8490-b5b69dd4a50f
let
	U, d, V = svd(X)
	Z = U*Diagonal(d)
end

# ╔═╡ 27238d09-b7d9-46ad-b33e-937f1ffe449e
md"""
### B. ${\bf Z} = {\bf X} {\bf V}$
"""

# ╔═╡ 59ab1041-81fe-4228-a9d0-30a4f2014c19
let
	U, d, V = svd(X)
	Z = X*V  ## X = UDV' -> XV = UD
end

# ╔═╡ 62a9ea09-ae87-40e7-893b-1a5449100c13
md"""
### C. ${\bf X}^\top{\bf X}$의 SVD를 이용
"""

# ╔═╡ 132fb204-63ad-4019-b42b-2576217f3c93
let
	U, d, V = svd(X'X)
	Z = X*V
end

# ╔═╡ 37582b01-d77f-4944-b376-db4132c1e83c
let
	U, d, V = svd(X'X)
	Z = X*U  ## U가 (p, p). 유사표준형 느낌
end

# ╔═╡ f1a8a4a8-7dfb-4f1f-9877-9b87f1228006
md"""
> X'X는 symmetric이 되고, 행렬의 크기가 많이 줄어듦. 따라서 이득이 되는 경우가 많음.
"""

# ╔═╡ d27ab23b-efd4-461d-9266-43c280c64dd6
md"""
### D. ${\bf Z} = {\bf X \Psi}$
"""

# ╔═╡ 09739f0f-2df5-457c-a3f1-0f4822a12e00
let
	λ, ψ = eigen(X'X)
	X*ψ  ## 고유값의 행렬이 작은 것부터 되어있어서 반대로 나옴
end

# ╔═╡ 4dab9096-6d22-4ba6-92a3-f4ac1386664a
let
	λ, ψ = eigen(X'X, sortby = -)
	X*ψ
end

# ╔═╡ d439a3bd-9a8b-472d-a374-3e5a119f33c0
let
	U, d, V = svd(X'X)
	λ, ψ = eigen(X'X, sortby = -)
	
	@show U ≈ V ≈ ψ
	@show d ≈ λ
end

# ╔═╡ cb9b1676-04aa-427e-a7fd-b7d692e1cd7f
md"""
언제 위같은 상황이 발생할까??

1. X가 정방행렬
2. X가 대칭행렬
3.  $X^{\frac12}$이 정의 가능
"""

# ╔═╡ fcb48c59-e26c-4c17-b087-beab10b3b66e
md"""
## 5. "고유값분해 = SVD" 인 경우
"""

# ╔═╡ 6fed3d84-bb66-4951-9dae-ddc221e14669
md"""
!!! info "'고유값분해 = 특이값분해' 인 경우"
	정사각행렬 $\bf X$ 가 어떠한 조건을 만족하면 특이값분해의 ${\bf U}$와 ${\bf V}$가 같아지는 경우가 있다. 즉 ${\bf X}$가 아래와 같이 분해되는 경우가 있다. 

	${\bf X}={\bf V}{\bf D}{\bf V}^\top={\bf U}{\bf D}{\bf U}^\top$

	이 상황을 코드로 표현하면 아래와 같다. 

	```julia
	U,d,V = svd(X)
	U ≈ V # <- true
	```

	또한 이때 ${\bf V}$는 (매우 놀랍게도) 아래를 실행하여 얻어지는 고유벡터 행렬 ${\bf \Psi}$와 일치하게 된다.

	```julia
	λ, Ψ = eigen(X, sortby = -)
	```

	따라서 이 내용을 종합하면 ${\bf X}$가 특정한 조건을 만족할 때, 아래가 성립하는 경우가 있다고 기억하면 된다. 
	
	```julia
	λ, Ψ = eigen(X, sortby = -)
	U,d,V = svd(X)
	U ≈ V ≈ Ψ # true
	d ≈ λ # true
	```

	수식으로 쓰면 아래와 같이 쓸 수 있다. 

	${\bf X}={\bf U}{\bf D}{\bf V}^\top={\bf \Psi}{\bf \Lambda}{\bf \Psi}^\top$

	그렇다면 이러한 경우를 만드는 "특수한 ${\bf X}$" 는 무엇일까?
"""

# ╔═╡ 4c934d1d-7962-4076-a8ce-a1c7b2788652
md"""
### A. (실대칭행렬 : 실수가 원소인 대칭행렬 + $\alpha$) 의 조건에서 가능
"""

# ╔═╡ 1c8e324f-c9b0-40cf-862c-6e9f726d6e0d
md"""
-- 예제1: 실대칭행렬이 아니어서 불가능한 경우
"""

# ╔═╡ dfc79091-f1c3-4ca4-812b-bd3b95bff483
# 대칭행렬이 아니야..
let
	X = [0 1 0 
		 0 0 1 
	     1 0 0]
	U,d,V = svd(X)
	U ≈ V 
end 

# ╔═╡ 2789d231-f61d-469d-9ba8-d65afd99da0e
md"""
-- 예제2: 실대칭행렬이 아니어서 불가능한 경우2
"""

# ╔═╡ 37750ce5-0c0c-488a-9e35-4274b4860d67
# 대칭행렬이지만 원소가 실수가 아니야..
let
	X = [2im 1
		 1   0]  ## 복소수 행렬
	U,d,V = svd(X)
	U ≈ V
end 

# ╔═╡ 14b7545c-9c63-449f-9b01-b7df40914694
md"""
-- 예제3: 실대칭행렬이지만 불가능한 경우
"""

# ╔═╡ 21038d5f-9017-4860-ac1f-c4ca7c8f8037
# 실대칭행렬이지만 불가능함
let 
	X = [2  0
		 0 -1]  ## 제곱근이 정의가 안됨
	U,d,V = svd(X)
	U ≈ V
end 

# ╔═╡ d4bff255-c5c8-43c1-9493-2184deaab5ad
md"""
-- 예제4: (실대칭행렬+$\alpha$)의 조건에서 가능한 경우
"""

# ╔═╡ 28a12ec6-ac27-429c-b183-de313b359100
# 실대칭행렬 + alpha 의 조건에서 가능
let 
	X = [1 2
	     2 4]
	U,d,V = svd(X)
	U ≈ V
end 

# ╔═╡ 369c96a1-3742-4474-b502-87a08f3571fe
let
	X = [1 2
		 2 4]
	U, d, V = svd(X)
	λ, Ψ = eigen(X, sortby = -)

	@show λ ≈ d
	@show U
	@show Ψ  ## eigen vector라 음수로 바꿔도 똑같음
end

# ╔═╡ b4e47ad5-656d-406c-9268-d95c5e59028f
md"""
### B. 무조건 가능한 경우
"""

# ╔═╡ 7f6defd4-670e-4282-ab67-81ff268e7a6b
md"""
*통계학과에서 자주 사용하는 design matrix ${\bf X}_{n\times p}$, $n \geq p$를 생각하자.*
"""

# ╔═╡ 2967744e-7512-4b87-9811-9c35e4813590
md"""
-- 예제1: 공분산행렬
"""

# ╔═╡ f57616cd-26c8-4e68-9c4e-91236b10718e
let
	cov(X)
end 

# ╔═╡ 2e2bfeb9-66f5-4d92-8a07-3256b5dcb742
md"""
-- 예제2: 상관계수 행렬
"""

# ╔═╡ ab13954d-5c71-4fde-9e33-11016ca8368d
let
	cor(X)
end 

# ╔═╡ b9a1c683-5b09-4217-9294-c79549b69e6e
md"""
-- 예제3: 그냥 ${\bf X}^\top {\bf X}$의 꼴..
"""

# ╔═╡ 2f17a7f4-68b0-49ee-b744-352720788178
let
	X'X
end 

# ╔═╡ 08698ea9-7ca0-41f6-a5be-aaefd0255828
md"""
-- 예제4: hat-matrix
"""

# ╔═╡ 1a6c376d-2899-48d8-b8c5-96ee42b9622b
let
	H = X*inv(X'X)*X'
	U, d, V = svd(H)

	@show U ≈ V  ## ??? 안됨

	@show d[1:10]  ## 고유값이 처음 넷을 제외하고는 거의 0임

	U1, U2 = U[:, 1:4], U[:, 5:150]
	d1, d2 = d[1:4], d[5:150]
	V1, V2 = V[:, 1:4], V[:, 5:150]

	@show U1 ≈ V1
	@show H ≈ U1*Diagonal(d1)*V1'
	@show H ≈ U1*Diagonal(d1)*U1'

	U = [U1 U2]
	V = [V1 U2]

	@show U ≈ V
end

# ╔═╡ d4057f66-0894-405b-b7e6-b186d1b3997b
md"""
> U와 V가 항상 unique한 것은 아님. 뒤에가 0이 되는 경우가 많아서... 뒤에는 아무거나 붙여도 동일한 식이 됨.
>
> 즉, U, D, Ψ를 선택할 수 있다.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"

[compat]
Distributions = "~0.25.107"
Plots = "~1.40.4"
PlutoUI = "~0.7.58"
RDatasets = "~0.7.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "c9cab99505e195ed28b9ba091e10b1d52f1bc838"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "297b6b41b66ac7cbbebb4a740844310db9fd7b8c"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a4c43f59baa34011e303e76f5c8c91bf58415aaf"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

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

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "6cbbd4d241d7e6579ab354737f4dd95ca43946e1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.1"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

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
git-tree-sha1 = "97d79461925cdb635ee32116978fc735b9463a39"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.19"

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

[[deps.Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "7c302d7a5fec5214eb8a5a4c466dcf7a51fcf169"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.107"

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
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

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
git-tree-sha1 = "bfe82a708416cf00b73a3198db0859c82f741558"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.10.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "3437ade7073682993e092ca570ad68a2aba26983"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.3"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a96d5c713e6aa28c242b0d25c1347e258d6541ab"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.3+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "359a1ba2e320790ddbe4ee8b4d54a305c0ea2aff"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "8e59b47b9dc525b70550ca082ce85bcd7f5477cd"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.5"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3336abae9a713d2210bb57ab484b1e065edd7d23"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

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

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dae976433497a2f841baadea93d27e68f1a12a97"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.39.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0a04a1318df1bf510beb2562cf90fb0c386f58c4"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.39.3+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

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

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "4cc0c5a83933648b615c36c2b956d94fda70641e"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.7.7"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "af81a32750ebc831ee28bdaaba6e1067decef51e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.2"

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
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

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
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6ed52fdd3382cf21947b15e8870ac0ddbff736da"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

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
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

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
git-tree-sha1 = "b69f8338df046774bd975b13be9d297eca5efacb"
uuid = "dc5dba14-91b3-4cab-a142-028a31da12f7"
version = "1.1.0+2023d"

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

[[deps.TimeZones]]
deps = ["Artifacts", "Dates", "Downloads", "InlineStrings", "LazyArtifacts", "Mocking", "Printf", "Scratch", "TZJData", "Unicode", "p7zip_jll"]
git-tree-sha1 = "cc54d5c9803309474014a8955a96e4adcd11bcf4"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.14.0"
weakdeps = ["RecipesBase"]

    [deps.TimeZones.extensions]
    TimeZonesRecipesBaseExt = "RecipesBase"

[[deps.TranscodingStreams]]
git-tree-sha1 = "71509f04d045ec714c4748c785a59045c3736349"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.7"
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

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

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

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "532e22cf7be8462035d092ff21fada7527e2c488"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.6+0"

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
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

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
# ╟─1f42323f-5074-41f8-bd6a-1806c123e149
# ╟─67efeeff-8a5c-476f-ab22-f3ff4208439c
# ╠═32bd60e5-2872-430a-8053-421b6e454f83
# ╟─e36c494d-0e97-4010-a57d-fcd60ab93900
# ╠═3c5aa44e-d594-11ec-21d6-25d65911031d
# ╠═107c213d-b88e-4138-9a1e-0fba804f6e09
# ╠═9af6ddd2-d726-4ed0-baa1-0c692d1f96d9
# ╟─ece414e2-e7dd-40f5-b401-5f5039d9b804
# ╟─5d183e7c-12bf-49bc-845a-80497a204ebc
# ╟─b3ab776c-9dbc-4e17-9f28-0c8f26bba169
# ╟─174ef9ba-a3c0-4040-8d31-1cd6962b7b8f
# ╟─d56fac91-c4c1-4529-9a75-8f4e007cf258
# ╟─45ca0b83-4ca4-4137-9cbf-a03ca32d4897
# ╟─762c7cf9-73ab-4fce-9f74-177140560eec
# ╟─989e6e04-1d01-41be-9d77-973089e0264b
# ╟─9c968667-0a77-42ce-b381-8aa3cf5e31e2
# ╟─0c36fb86-88e4-4f92-8b34-94944150f273
# ╟─ffd6d9f2-e4a5-4f06-a75b-242cb4ee71d1
# ╟─0ae3053c-51de-4fd0-809d-0df5f539de61
# ╟─14ac8938-6de1-408c-ac99-a2dcbeef7e07
# ╟─dcd8d3f1-5022-4b1b-a67e-4b57e856dbfa
# ╟─dd3262c1-d3fb-4feb-ac5b-187833541b19
# ╟─cee6edd8-a040-4c7c-a417-854904fb413b
# ╠═ba4fdd2e-f83b-4b85-9ec2-85119c97ab15
# ╟─0017fd0e-2ba5-4c30-a2f1-b0f6edf0c3c2
# ╠═70416c2d-5b83-40c3-bd5f-3dde9ef5ff2e
# ╠═c3973f3f-2cba-4aaa-9f4b-1db2c43ab6dd
# ╟─48178775-ed6f-45e8-bfcf-dbc1a93fa98d
# ╠═3620eaa8-5ed5-45c7-bac1-aaa2de363de4
# ╟─238de6fe-735d-4ada-9543-3b78ff3f4b2a
# ╠═c3a344ba-0f5d-420c-9511-61571e825c52
# ╟─92108017-9d7b-4434-be5f-1dd3c3811131
# ╠═e0550fad-df86-48a8-8ad0-f01eff85718b
# ╟─00367152-c595-4a2e-9666-01d1a136b4f8
# ╠═22777cad-21a1-4101-b7ef-e6cbfe7adc64
# ╟─8975e5ea-b410-4c87-ba48-5fd8a639dc92
# ╟─502c4e40-520b-4051-92d8-243e97ed7982
# ╟─839ee40e-8e0a-409d-ac02-fad2233b7454
# ╠═ed227c0f-3d31-4ab4-bd32-a0728349412e
# ╟─3e64482f-7fc6-4544-ab28-189dc7293830
# ╟─011afd61-b6bb-4070-a210-a2a720e7ad98
# ╠═77a73681-4c75-4f71-b528-db32f18e5ed9
# ╟─cbe9a2f9-2874-4635-bac9-3b51d1a50a78
# ╟─2e2a7afe-b2ff-4683-9ab0-8474e946e8be
# ╟─b7ead0c1-079d-48ee-bf4c-aa699bb50161
# ╠═a11710fd-111e-4977-8490-b5b69dd4a50f
# ╟─27238d09-b7d9-46ad-b33e-937f1ffe449e
# ╠═59ab1041-81fe-4228-a9d0-30a4f2014c19
# ╟─62a9ea09-ae87-40e7-893b-1a5449100c13
# ╠═132fb204-63ad-4019-b42b-2576217f3c93
# ╠═37582b01-d77f-4944-b376-db4132c1e83c
# ╟─f1a8a4a8-7dfb-4f1f-9877-9b87f1228006
# ╟─d27ab23b-efd4-461d-9266-43c280c64dd6
# ╠═09739f0f-2df5-457c-a3f1-0f4822a12e00
# ╠═4dab9096-6d22-4ba6-92a3-f4ac1386664a
# ╠═d439a3bd-9a8b-472d-a374-3e5a119f33c0
# ╟─cb9b1676-04aa-427e-a7fd-b7d692e1cd7f
# ╟─fcb48c59-e26c-4c17-b087-beab10b3b66e
# ╟─6fed3d84-bb66-4951-9dae-ddc221e14669
# ╠═4c934d1d-7962-4076-a8ce-a1c7b2788652
# ╟─1c8e324f-c9b0-40cf-862c-6e9f726d6e0d
# ╠═dfc79091-f1c3-4ca4-812b-bd3b95bff483
# ╟─2789d231-f61d-469d-9ba8-d65afd99da0e
# ╠═37750ce5-0c0c-488a-9e35-4274b4860d67
# ╟─14b7545c-9c63-449f-9b01-b7df40914694
# ╠═21038d5f-9017-4860-ac1f-c4ca7c8f8037
# ╟─d4bff255-c5c8-43c1-9493-2184deaab5ad
# ╠═28a12ec6-ac27-429c-b183-de313b359100
# ╠═369c96a1-3742-4474-b502-87a08f3571fe
# ╟─b4e47ad5-656d-406c-9268-d95c5e59028f
# ╟─7f6defd4-670e-4282-ab67-81ff268e7a6b
# ╟─2967744e-7512-4b87-9811-9c35e4813590
# ╠═f57616cd-26c8-4e68-9c4e-91236b10718e
# ╟─2e2bfeb9-66f5-4d92-8a07-3256b5dcb742
# ╠═ab13954d-5c71-4fde-9e33-11016ca8368d
# ╟─b9a1c683-5b09-4217-9294-c79549b69e6e
# ╠═2f17a7f4-68b0-49ee-b744-352720788178
# ╟─08698ea9-7ca0-41f6-a5be-aaefd0255828
# ╠═1a6c376d-2899-48d8-b8c5-96ee42b9622b
# ╟─d4057f66-0894-405b-b7e6-b186d1b3997b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
