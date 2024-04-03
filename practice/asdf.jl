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

# ╔═╡ 6f5e1250-e775-11ee-1994-e3c1b9e5584c
using PlutoUI, Plots, Distributions, Random, ForwardDiff

# ╔═╡ 455a0811-d32e-4459-a1da-2dedae860d88
md"""
### code and theorem review
"""

# ╔═╡ 9f1e3085-6804-4631-aeba-04afdd1fd01e
Plots.plotly()

# ╔═╡ abf78c62-9107-4aac-8113-9da0f95f5cde
PlutoUI.TableOfContents()

# ╔═╡ 1d41c736-6b1d-46d1-9df7-447b7c7a02ce
md"""
### 기초지식


---



`-` 이미 할당된 값들
"""

# ╔═╡ d0052329-8f0b-4fc3-998e-b8e5912d5536
let
	println(π)  ## \pi
	println(ℯ)  ## \euler
end

# ╔═╡ e38a58bc-c110-4885-993a-7f25fb0166ef
md"""
`-` 새로운 연산자
"""

# ╔═╡ 4e593850-16ed-40ca-83fd-a486b18ec079
1 ≈ 1.00000001  ## \approx, 이 이상부터는 다른 수라고 판단

# ╔═╡ 6efcbb0a-8ef3-4599-b874-0b4d02fa7518
1 ≤ 1.0  ## 보기 좋으라고...

# ╔═╡ a16b583b-9405-48ee-9c05-83e38533b68f
1 <= 1.0  ## 솔직히 이걸 쓰는 게 더 편하긴 하다.

# ╔═╡ b29f68bf-3de5-4d7c-84f4-2bd2bd874537
md"""
`-` 편리한 함수사용
"""

# ╔═╡ a7de0a15-d975-418f-9a54-1f8441ae91ac
let
	f(x) = x+5
	@show f(2)  ## 일반 함수 사용

	g(x) = 2x
	@show (g∘f)(1)  ## 함성함수, \circ

	@show 1 |> f |> g  ## 파이프 연산자
end

# ╔═╡ cec3fbdf-1b41-438c-b263-8fe140700b26
md"""
`-` 모듈 없는 매트릭스 선언
"""

# ╔═╡ a65c8eef-f5b2-4ae5-8520-db338fe5780c
let
	X = [1 2
		 3 4]
	X
end

# ╔═╡ 9ee8c5bc-5f7a-4833-a531-1007466ffda8
md"""
`-` 인덱스
"""

# ╔═╡ 4997f438-a5ce-40bd-968c-32d70f07f801
lst = [11, 22, 33]

# ╔═╡ 8cc89254-26ff-4020-bbeb-0a248564bbef
lst[1]  ## 1부터 시작한다.

# ╔═╡ b8ebbd63-f1ef-4892-9ef9-2f9286129f86
md"""
`-` 컴프리헨션
"""

# ╔═╡ 059cd126-a60a-4009-8c1c-74f2de00ca8c
[x^2 for x in [1,2,3]]  ## 파이썬과 동일하게 사용이 가능

# ╔═╡ 0c8547d7-13e9-4215-b1a0-c4438a1127f7
md"""
`-` 튜플
"""

# ╔═╡ 58be869e-bc81-4232-932e-a54d3fe0b3e3
let
	x1, x2, x3 = 1,2,3
	print(x1, x2, x3)  ## 그 자체로 이어서 출력(sep 없음)
	x1, x2  ## 튜플로 출력
end

# ╔═╡ 1df27dda-e79b-44bb-a8a3-5b6c48af4cc5
md"""
`-` 변수 할당 처리
"""

# ╔═╡ 7b9f0ebd-91fb-4bba-8cca-c1a515ff312e
# ╠═╡ disabled = true
#=╠═╡
a = 1
  ╠═╡ =#

# ╔═╡ dc1c5b25-84cf-4967-b915-7468955ffa24
a = 2  ## 전역으로 선언시 이전 셀 비활성화

# ╔═╡ bd78e53c-d222-41b7-beb3-a10991feb09a
@bind x Slider(0:0.1:2, show_value = true, default = 1)

# ╔═╡ c00b097a-d5ae-4a5d-a384-bc06cbfdef08
y = 2

# ╔═╡ dcea012a-3cef-4a3d-9fcd-1014baec2b8f
z = x + y  ## 변수 할당에 변수가 관여될 때, 해당 변수가 바뀌면 할당된 변수도 연쇄적으로 바뀜

# ╔═╡ 8dc0960a-99da-4a6b-b7b0-ffae32df16b4
md"""
`-` 마크다운 셀 이용
"""

# ╔═╡ 45ff35d1-1ebd-4ea7-b72c-0eb4ddf6f58f
name = "강신성"

# ╔═╡ 3f4e4892-a743-4bc5-8eb1-adaf684c61d5
md"이름 : 3학년 $(name)
> f스트링처럼 \$( )를 통해 외부 변수를 집어넣을 수가 있다."

# ╔═╡ c170c172-2a1c-49d1-914f-aaf23a0c6f1f
md"""
`-` 슬라이터와 인터렉티브 플롯
"""

# ╔═╡ 77c34287-881b-408b-9d9e-287318b5ba01
begin
	alpha_selector = @bind α Slider(-1:0.1:1, show_value = true, default = 0)
	beta_selector = @bind β Slider(-1:0.1:1, show_value = true, default = 0)
end

# ╔═╡ e2d79467-f780-404a-b084-f71de303d97f
md"""
α = $(alpha_selector)

β = $(beta_selector)
"""  ## 마크다운 셀 응용

# ╔═╡ 668a0ce3-03ac-4f5e-8313-5fa3e741d9e9
let
	f(x) = (x - α)*(x - β)*(x - y)
	plot(-1:0.01:2, f)  ## x의 범위를 지정
end

# ╔═╡ cefde001-9774-4069-9dda-cee8271f4c1f
md"""
`-` 라디오 버튼
"""

# ╔═╡ 16feef51-3329-4289-a95d-59fa89576c73
@bind vote Radio(["male", "female"], default = "male")  ## default가 없으면 nothing(null)

# ╔═╡ 38e95bf2-76f6-4ff8-b108-ac3cafa2f308
md"당신의 성별은 $(vote)입니다."

# ╔═╡ 682518ab-28ad-4d98-93fe-3f9ba66380bf
md"""
### 함수식과 연산

---


"""

# ╔═╡ 623fe2c0-6e50-44f2-982a-a99f7c5cbead
md"`-` 함수식 선언"

# ╔═╡ 9ab07c9f-4d3b-4109-8bda-cc29e99a40ef
f(x, y) = √(x^2+y^2); println(f(2,3))  ## 수학적 정의

# ╔═╡ 7ebf832f-13eb-4b0f-9d7d-b84dd1fb660c
(x -> 2x)(2)  ## 람다 수식 이용

# ╔═╡ cb5eae90-aa93-4c04-9aff-dc4fd587e630
function h(x)
	return ℯ^x / (1 + ℯ^x)  ## 사용자 정의 함수 지정
	return ℯ^x / (1 + ℯ^x)  ## 
end

# ╔═╡ c71c0636-3c50-4775-8578-640c70cc9009
h(2)

# ╔═╡ 538ceafd-c3ad-4f58-8ef1-b8d2f7a80fb6
md"""
### 이변량 정규분포

---
"""

# ╔═╡ 18afa3d2-517f-4c47-ac41-a8012079ada9
md"""
파라메터
-  $\rho$ = $(@bind ρ Slider(-0.99:0.01:0.99, show_value=true))
-  $\mu_X$ = $(@bind μ₁ Slider(-1:0.1:1, show_value=true))
-  $\mu_Y$ = $(@bind μ₂ Slider(-1:0.1:1, show_value=true))
-  $\sigma_X$ = $(@bind σ₁ Slider(0.01:0.01:2, show_value=true))
-  $\sigma_Y$ = $(@bind σ₂ Slider(0.01:0.01:2, show_value=true))
"""

# ╔═╡ e03cc014-83c8-4659-8737-c44be8c6ae74
function pdf(x, y)
	x = (x - μ₁)/σ₁
	y = (y - μ₂)/σ₂
	c₁ = 2π*σ₁*σ₂*√(1-ρ^2)
	c₂ = 2(1-ρ^2)

	return 1/c₁ * ℯ^(-1/c₂*(x^2 + y^2 - 2ρ*x*y))
end

# ╔═╡ 08e626a3-6bdf-4dec-9a44-f051ed68d745
begin
	p1 = plot(-5:0.1:5, -5:0.1:5, pdf, st=[:surface],legend=false);  ## surface : 입체도
	p2 = plot(-5:0.1:5, -5:0.1:5, pdf, st=[:contour],legend=false);  ## contour : 등고선
	plot(p1, p2)
end

# ╔═╡ 3c403a5e-60cb-4f0b-a882-679cdfae1b6b
md"""
# 분포 이론
"""

# ╔═╡ 32336b49-3be3-48d7-9f5c-d9fad228c27b
md"모든 분포는 균일분포에서 비롯된다..."

# ╔═╡ db1b6061-2513-4ca3-9205-8242bd1c7472
md"""
## 분포 생성 코드

---


"""

# ╔═╡ 0153b93a-6edd-4a64-a992-c2c2e0cfe06b
let
	N = 10
	p = 0.5
	distribution = Bernoulli(p)
	rand(distribution, N)
	@show distribution
end

# ╔═╡ 6f523ea7-cbae-47aa-a1c5-3480fbeaeedd
md"""
> 분포라는 개체 자체를 가지고 놀 수 있다...
"""

# ╔═╡ cfd3861e-3440-4822-a83d-9382bb2bc316
@show Binomial(10, 0.5)

# ╔═╡ 32f8f3a7-ab89-4188-aa6d-4d52cc084c21
md"""
## 난수 생성 알고리즘

---


"""

# ╔═╡ e7caf6fc-e34c-42a5-93fe-a7b9d4605afa
md"""
### 1. 이항분포

> 확률이 같은 이항분포의 합은 이항분포이다.
"""

# ╔═╡ a2c165b4-6459-4113-a25d-0c35e41f2e3c
md"""
n = $(@bind n Slider(1:20, show_value = true, default = 10))

p = $(@bind p Slider(0.1:0.1:1, show_value = true, default = 0.5))
"""

# ╔═╡ 7ef017b1-5822-48ae-9643-7960ebf4fdb0
let
	X = rand(Binomial(n, p), 100)
	histogram(X)
end

# ╔═╡ 3df97593-cea3-45d5-840b-9a9874abb8cc
md"""
균일분포 → 베르누이분포 → 이항분포
"""

# ╔═╡ 43536bc0-599c-4180-87a5-6d3b02c77dd4
let
	N = 1000
	n = 10
	p = 0.5
	X = [(rand(10) .< p) |> sum for i in 1:N]  ## 테이블 연산자가 논리 연산자보다 우선
	histogram(X, xlim = (0, 11), bin = 12, label = "By Uniform")
	histogram!(rand(Binomial(n, p), N), bin = 12, label = "Pure binomial")
end

# ╔═╡ 843fd1fa-3f42-41da-9254-34977df8d736
md"""
### 2. 포아송분포

> 서로 다른 포아송분포의 합 → 포아송분포
"""

# ╔═╡ 2afbbb9b-46a0-47a1-8599-8363f458755b
md"λ = $(@bind λ Slider(0.1:0.1:10, show_value = true, default = 1))"

# ╔═╡ c0044d57-4bfc-4c8a-a8d9-9513fc9a1bef
let
	N = 100
	X = rand(Poisson(λ), N)
	histogram(X)
end

# ╔═╡ daa6729a-5f5d-4547-a792-0e8c54bf597e
md"균일분포 → 베르누이분포 → 이항분포 ≈ 포아송분포"

# ╔═╡ 2a8cb317-2ccf-4d50-a005-6c4a3953febf
let
	N = 1000
	λ = 4
	n = 1000
	p = λ/n  ## np = lambda, p가 작고, n이 크면 포아송분포로 근사할 수 있음.

	X = [(rand(n) .< p) |> sum for i in 1:N]
	histogram(X, label = "By Uniform", xlim = (0, 60))
	histogram!(rand(Poisson(λ), N), label = "Pure Poisson")
end

# ╔═╡ 027c5b5d-5212-488f-beba-b3476c7cec54
md"""
### 3. 지수분포

> 지수분포에 양수를 곱하면 지수분포(척도모수)
"""

# ╔═╡ f1f8dd40-c975-490b-9e91-7b49b84581ca
md"θ = $(@bind θ Slider(0.1:0.1:10, show_value = true, default = 2))"

# ╔═╡ 5baad307-94f3-453c-9878-57d0c0fb6150
let
	X = rand(Exponential(θ), 100)
	histogram(X)
end

# ╔═╡ 032ddcbf-1edd-45fc-8ea7-c2c9a7c17b3a
md"균일분포 → 베르누이분포 → 기하분포 → 지수분포"

# ╔═╡ 1e75c5ab-c0ea-49fd-9cb0-da11d2ae6de8
function GEO(p)
	if (rand() < p)
		X = 1
	else
		X = 1
		while (rand() >= p)
			X = X + 1
		end
	end
	
	return X
end

# ╔═╡ cda2ef25-f70e-42a4-b721-882509c3b418
let
	N = 10000
	λ = 1/θ
	n = 1000
	p = λ/n
	Δt = 1/n  ## 단위시간분의 n

	X = [GEO(p)*Δt for i in 1:N]
	histogram(X, label = "By Uniform")
	histogram!(rand(Exponential(θ), N), label = "Pure Exponential")
end

# ╔═╡ 337076ae-8469-4a0a-b1ea-c52ebc7a9027
md"지수분포의 누적분포함수의 역함수(균일분포) → 지수분포"

# ╔═╡ 9e2bc040-2a33-43b0-86a0-e610b98f5930
let
	f(x) = 1/θ * exp(-x/θ)
	F(x) = 1-exp(-x/θ)
	Finv(x) = -θ*log(1-x)

	N = 10000
	histogram(rand(N) .|> Finv, label = "By Inverse Func")
	histogram!(rand(Exponential(θ), N), label = "Pure Exponential")
end

# ╔═╡ 7ed313dd-830e-4381-8cfe-b8c98da4d002
md"Memoryless Property : 지수분포, 기하분포"

# ╔═╡ 5bb17acc-c570-4b62-a01a-6b7c00c35dde
md"""
t = $(@bind t Slider(0.01:0.01:5, show_value = true, default = 1))

s = $(@bind s Slider(0.01:0.01:5, show_value = true, default = 2))
"""

# ╔═╡ ea41d446-be33-45f8-b372-2776119f4fda
let
	N = 10000000
	X = rand(Exponential(5), N)
	println("P(X > t) = $(sum(X .> t) / N)")
	println("P(X > t+s | X > t) = $(sum(X .> s+t) / sum(X .> s))")
end

# ╔═╡ a30d1531-bcb7-48d1-a369-460aced7cc4f
md"""
### 4. 정규분포 : 박스뮬러변환

> 이변량 정규분포와 지수분포의 관계를 이용
"""

# ╔═╡ 84bc5e5a-3c61-486c-b0b0-4e03d301690e
md"i = $(@bind i Slider(1:1:3000, show_value = true, default = 1))"

# ╔═╡ 57e5b93d-2f3b-40a8-9e4c-11901d498d98
let
	Random.seed!(14107)
	N = 3000
	R = rand(Exponential(2), N) .|> sqrt
	θ = rand(N)*2*π
	X = (@. R*cos(θ))
	Y = (@. R*sin(θ))
	Z = rand(Normal(0, 1), N).^2 + rand(Normal(0, 1), N).^2

	p1 = scatter(X, Y, alpha = 0.1); ylims!(-5, 5)
	scatter!([0, X[i]], [0, Y[i]]); plot!([0, X[i]], [0, Y[i]], linewidth = 5);
	p2 = histogram(Z, label = "Box-Muler transform"); histogram!(rand(Exponential(2), N), label = "Pure Exponential");

	plot(p1, p2)
end

# ╔═╡ 1304886c-ab78-4d23-80ce-6025d66640a8
md"""
박스뮬러변환 : 지수분포 → 정규분포
"""

# ╔═╡ ccc44a13-355f-403e-be45-d4a031ea1ce5
let
	N = 10000
	Finv(x) = -2*log(1-x)

	X = rand(N)
	θ = rand(N)*2π

	histogram((@. (X |> Finv |> sqrt) * cos(θ)), label = "Box-Muler Transform")
	histogram!(rand(Normal(0,1), N), label = "Pure Normal Distribution")
end

# ╔═╡ 7f14bfa0-6fcd-4c8a-aba7-44c7937a4ddd
let 
	rand(Exponential(1),10000) .|> (x -> 1-exp(-x)) |> histogram
end

# ╔═╡ 8bdcb86c-1767-4990-9bb4-731790c9f2b1
md"""
>  $F(X) = P(X ≤ X) = 1$이므로, 모든 지점에서 확률이 같다. 즉, Uniform Distribution이다?
"""

# ╔═╡ 4379fd3f-3f92-4b0d-8d1a-a2cf17b189eb
md"""
### 5. 정규분포 : 표본평균의 분포
"""

# ╔═╡ 359d8ad8-a5a2-47c2-a62d-057ae7058c2a
md"$$X₁, X_2, … , X_n \sim N(μ, σ^2) ⇒ X̄ \sim N(μ, \frac{σ^2}{n})$$"

# ╔═╡ eaae015d-f8e4-404a-8c52-528f55f9843a
md"""
`-` $X_1, X_2, \dots, X_n \sim N(7, 5^2) \Rightarrow \bar{X} \sim N(7, \frac{5^2}{n})$
"""

# ╔═╡ 862e890f-6be2-4d97-9c56-84c557940e55
let
	N = 10000
	n = 25
	X̄ = [rand(Normal(7, 5), n) |> mean for i in 1:N]
	Y = rand(Normal(7, 5/sqrt(n)), N)

	histogram(X̄)
	histogram!(Y)
end

# ╔═╡ cc5c0817-b290-471f-aa31-0a2905b45741
md"""
`-` $X_1, X_2, \dots, X_{25} \sim N(μ, 10^2)$에서 $x̄ = 67.53$일 때, μ에 대한 95% 신뢰구간
"""

# ╔═╡ 61907f88-fa58-49fc-ac22-d8b757b28e82
let
	N = 100000
	n = 25
	σ = 10
	x̄ = 67.53

	X̄ = [rand(Normal(0, σ), n) |> mean for i in 1:N]
	c = quantile(X̄, 0.975)

	println("μ에 대한 95% CI : $((x̄-c, x̄+c))")  ## 실험을 통해 얻은 값
end

# ╔═╡ cccc3d9e-de04-4029-b0e0-d59d98b6bc77
let
	n = 25
	x̄ = 67.53
	σ = 10
	c = quantile(Normal(0, σ/√n), 0.975)

	println("μ에 대한 95% CI : $((x̄ - c, x̄ + c))")  ## 이론적인 값
end

# ╔═╡ a67234c9-94f6-4e5f-8c42-6f5cf4e1933d
md"""
### 6. 카이제곱분포
> 표준정규분포를 따르는 서로 독립인 확률변수의 제곱합
"""

# ╔═╡ 40871ab7-df22-4b9a-be07-0013cfbc656e
md"$$(X \sim \chi^2(k)) \Rightarrow (there~exists X_1, X_2, \dots, X_k~s.t. (1) X_1, X_2, \dots, X_k \sim^{iid} N(0,1)~and~(2) X_1^2 + X_2^2 + \dots + X_k^2 = X)$$"

# ╔═╡ f72c31a8-6065-465c-a0f8-62ca919094d4
md"`-` 정규분포 이용 (균일 $\to$ 기하×단위시간의 차분 → 지수분포 → 정규분포(박스뮬러변환) → 카이제곱분포)"

# ╔═╡ 29be535a-fa0b-44c5-9822-4fca701d021a
let
	N = 10000
	n = 4
	X = [rand(Normal(0, 1), n).^2 |> sum for i in 1:N]

	histogram(X)
	histogram!(rand(Chisq(n), N))
end

# ╔═╡ 50466eab-bd9c-47a5-903c-e1e7c99d3548
md"`-` 지수분포 이용"

# ╔═╡ 02242ed2-08df-49ee-91f5-61627dd28ecd
let
	N = 10000
	n = 4
	X = [rand(Exponential(2), Int64(n/2)) |> sum for i in 1:N]

	histogram(X)
	histogram!(rand(Chisq(n), N))
end

# ╔═╡ 1bcecc6e-c708-4cde-97f1-d21cbbe379f8
md"""
`-` 카이제곱분포의 합을 이용
"""

# ╔═╡ ff8e50a0-8afc-48ea-aba6-57cef582b7f4
let
	N = 10000
	n = 12
	X = [rand(Chisq(1), n) |> sum for i in 1:N]
	X₂ = [rand(Chisq(2), Int64(n/2)) |> sum for i in 1:N]
	X₃ = [rand(Chisq(3), Int64(n/3)) |> sum for i in 1:N]
	X₄ = [rand(Chisq(4), Int64(n/4)) |> sum for i in 1:N]
	X₅ = [rand(Chisq(6), Int64(n/6)) |> sum for i in 1:N]
	X₆ = [rand(Chisq(12)) for i in 1:N]

	histogram(X)
	histogram!(X₂)
	histogram!(X₃)
	histogram!(X₄)
	histogram!(X₅)
	histogram!(X₆)
end

# ╔═╡ f529499b-c961-4368-9a4d-a66ac7281d19
md"""
### 7. 감마분포
> 모수가 같은 독립인 지수분포를 k개 합친 것
"""

# ╔═╡ 1d5cf77b-e2f5-4927-8f98-da7babed96d3
md"""
$(X \sim \Gamma(k, θ)) \Rightarrow (there~exists X_1, \dots, X_k ~ s.t. (1) X_1, \dots, X_k \sim^{iid} Exp(θ)~and~(2) X_1 + \dots + X_k =^d X$
"""

# ╔═╡ daf035aa-2be1-4b0f-9b97-095e34350b0a
md"`-` $\Gamma(3, 2)$를 생성하라"

# ╔═╡ 2e34e170-aed1-446a-82d5-41455004a69c
md"지수분포의 합"

# ╔═╡ e41f0bad-3ed5-4298-8d22-14f443517978
let
	N = 10000
	X = [rand(Exponential(2), 3) |> sum for i in 1:N]
	histogram(X)
	histogram!(rand(Gamma(3,2), N))
end

# ╔═╡ d0be677b-ebac-4408-bc45-8f09044476be
md"카이제곱분포(정규분포 → 카이제곱분포 = 감마분포)"

# ╔═╡ b181dd35-8690-4ef6-9538-dcd2e67e9ddb
let
	N = 10000
	X = rand(Chisq(6), N)
	histogram(X)
	histogram!(rand(Gamma(3,2), N))
end

# ╔═╡ ebf0bdbf-868e-400a-b7ae-1dcedad97f89
md"""
> 감마분포의 합은 감마분포 & 감마분포의 곱도 감마분포
"""

# ╔═╡ ac52601f-714d-4657-b980-bc5c1f558163
let
	N = 10000
	X = [rand(Gamma(3,2), 4) |> sum for i in 1:N]
	X₂ = [rand(Gamma(6,2), 2) |> sum for i in 1:N]
	X₃ = rand(Gamma(12, 2), N)

	p1 = histogram(X); histogram!(X₂); histogram!(X₃); title!("더하기")

	Y = rand(Gamma(3,2), N) .* 6
	Y₂ = rand(Gamma(3,4), N) .* 3
	Y₃ = rand(Gamma(3,12), N)

	p2 = histogram(Y); histogram!(Y₂); histogram!(Y₃); title!("곱하기")

	plot(p1, p2)
end

# ╔═╡ 9aa12753-7cb4-4370-ae10-9f99dfe01652
md"""
## 상상실험과 구간 추정
"""

# ╔═╡ 7462ae30-aa78-479d-aa68-25acba417169
md"i₁ = $(@bind i₁ Slider(1:100, show_value = true, default = 1))"

# ╔═╡ e0db18e0-9b04-4eb6-bb0d-2091b428a553
let
	Random.seed!(14107)
	N = 100
	μ₁, μ₂ = 1.2, 3.4
	X = rand(Normal(μ₁, 1), N)
	Y = rand(Normal(μ₂, 1), N)

	scatter(X, Y, xlim = (-12, 14), ylim = (-9,9), alpha = 0.2)
	scatter!([μ₁], [μ₂], marker=:cross, color = "red")
	scatter!([X[i₁]], [Y[i]])
end

# ╔═╡ e98d6ef2-b836-4a7b-9beb-c24eed088abe
md"""
> 중심을 기준으로 원을 그렸을 때 95%의 자료가 원 안에 들어가있도록 해보자.
"""

# ╔═╡ 923eb57d-bf2a-4815-ba45-296685cf5f43
md"r = $(@bind r Slider(0.1:0.01:3, show_value = true, default = 2))"

# ╔═╡ 694ff7ac-f3e0-448b-9a47-d131c2d30650
let
	Random.seed!(1234)
	N = 100
	μ₁, μ₂ = 1.2, 3.4
	X = rand(Normal(μ₁, 1), N)
	Y = rand(Normal(μ₂, 1), N)
	θ = 0:0.01:1 .* 2π
	
	println("r이 $(r)일 때, 원 안에는 점의 $((@. (X-μ₁)^2 + (Y-μ₂)^2 < r^2) |> sum |> x -> x/N)만큼이 있다.")

	scatter(X, Y, xlim = (-12, 14), ylim = (-9,9), alpha = 0.2)
	scatter!([μ₁], [μ₂], marker=:cross, color = "red")

	plot!(r.*cos.(θ).+μ₁, r.*sin.(θ).+μ₂, color = "red")
end

# ╔═╡ 24332730-d9e4-45b2-8cc7-9bef7c0c3ec5
let
	Random.seed!(1234)
	N = 100
	μ₁, μ₂ = 1.2, 3.4
	X = rand(Normal(μ₁, 1), N)
	Y = rand(Normal(μ₂, 1), N)
	

	quantile((@. sqrt((X-μ₁)^2 + (Y-μ₂)^2)), 0.95)  ## 딱 걸치는 값이 얼마인지
end

# ╔═╡ f275e60c-912c-4feb-8010-e8449268a542
md"""
> 이론적인 수치는 아래와 같다.
"""

# ╔═╡ d220f49f-b652-4f9e-84d6-46c50497e719
let
	@show quantile(Exponential(2), 0.95) |> sqrt
end

# ╔═╡ a81e4c58-56e1-4f77-87de-ff26f070e77e
md"""
`-` 샘플의 수가 커지면 분산이 작아져 신뢰구간의 범위가 줄어든다.
"""

# ╔═╡ 3c1cbdb9-50f0-4429-ae50-b68de102cab7
let
	Random.seed!(1234)
	N = 100
	μ₁, μ₂ = 1.2, 3.4
	X = rand(Normal(μ₁, 1), N)
	Y = rand(Normal(μ₂, 1), N)
	θ = 0:0.01:1 .* 2π

	fig = scatter(X, Y, xlim = (-12, 14), ylim = (-9,9), alpha = 0.2)
	scatter!([μ₁], [μ₂], marker=:cross, color = "red")
	if (i != 1) & (i != 100)
		scatter!([X[i₁-1], X[i₁], X[i₁+1]], [Y[i₁-1], Y[i₁], Y[i₁+1]])
	elseif (i == 1)
		scatter!([X[i₁], X[i₁+1], X[i₁+2]], [Y[i₁], Y[i₁+1], Y[i₁+2]])
	else
		scatter!([X[i₁-2], X[i₁-1], X[i₁]], [Y[i₁-2], Y[i₁-1], Y[i₁]])
	end

	X̄ = [rand(X, 3) |> mean for i in 1:5000]
	Ȳ = [rand(Y, 3) |> mean for i in 1:5000]

	R = @. sqrt((X̄ - μ₁)^2 + (Ȳ - μ₂)^2)

	println(quantile(R, 0.95))

	fig
end

# ╔═╡ 33776495-04c1-4b1b-8226-fa5816e5435f
md"""
`-` 반지름을 체계적으로 탐색하기
"""

# ╔═╡ 4ca2c50f-3696-444b-bab3-d7a41b0cdb1e
md"""
1. 총을 더 많이 쏘자...

2.  $R^2$의 분포(박스뮬러 변환)를 이용하여 난수를 추출하자...

3. 그냥 이론적으로 산출해버리자...
"""

# ╔═╡ bcefc93b-7898-4d91-b5a3-fb52f9636cb8
let
	println("1회 사격 시나리오 : $(quantile(Exponential(2), 0.95) |> sqrt)")
	println("3회 사격 시나리오 : $(quantile(Exponential(2/3), 0.95) |> sqrt)")
end

# ╔═╡ 3a7e9d92-e59d-4d79-b25e-2f8bd95be5d5
md"""
## 가설 검정
"""

# ╔═╡ b7c77d64-cb49-4e34-b5ae-8caae8f89c6d
md"""
1. 일반적으로 알려진 사실에 대한 의문(귀무가설과 대립가설 설정)
2. 실험 및 데이터 수집
3. 검정통계량의 분포를 산출하고 p-value를 계산
4. 결과에 따라 귀무가설 기각 여부 결정
"""

# ╔═╡ 59c38af3-37bc-458c-a55f-71a1d2d34b25
md"
### A. 지수분포의 평균 검정
"

# ╔═╡ 0ca7a8da-c99e-4c98-b258-ca6400d9040f
md"""
확률변수 $X_1, \dots, X_n$을 아래의 pdf에서 추출한 iid 랜덤샘플이라고 하자.

$$f(x) = θexp(-xθ)I(x > 0)$$

> 누가봐도 지수분포의 pdf...

이러한 샘플을 사용하여 아래의 가설을 검정하고자 한다.

$$H_0 : θ = θ_0~vs.~H_1:θ ≠ θ_0$$

샘플을 사용하여 적절한 검정통계량을 설정하고 θ에 대한 95% 신뢰구간을 구하라.
"""

# ╔═╡ dcefd283-205d-447c-8ea8-188b619fe0e4
md"""
ΣX ∼ Γ(n, 1/θ) → $θΣX ∼ \Gamma(n, 1)$ → $2θΣX ∼ \Gamma(n,2) = χ^2(2n)$이므로,

$$P(c_1 ≤ 2θΣX ≤ c_2) = 0.95$$

인 $c_1, c_2$를 카이제곱분포에서 구한 뒤 변환하면 된다.
"""

# ╔═╡ d35c8ebb-d261-4a21-8db7-ee49811670db
let
	n = 20
	θ = 5
	c1 = quantile(Chisq(2n), 0.025)
	c2 = quantile(Chisq(2n), 0.975)
	@show c1, c2

	# L = c1/2nX̄  ## x̄가 없어서 추정치가 아니라 확률변수
	# U = c2/2nX̄
end

# ╔═╡ e1ed314b-5c1f-450e-85c1-dbb6362f4616
md"""
`-` 시뮬레이션으로 확인
"""

# ╔═╡ f84bb31b-b320-4df7-a81d-218210eb9278
let
	N = 10000
	θ = 5
	n = 20
	X̄ = [rand(Exponential(1/θ), n) |> mean for i in 1:N]  ## Γ(n, 1/nθ)를 따른다.
	p = histogram(2n*θ*X̄)  ## Γ(n, 2) = χ²(2n)를 따른다.

	c1 = quantile(Chisq(2n), 0.025)
	c2 = quantile(Chisq(2n), 0.975)

	L = @. c1/(2n*X̄)  ## 각 표본들의 하한
	U = @. c2/(2n*X̄)  ## 각 표본들의 상한
	
	println((@. L ≤ θ ≤ U) |> mean)  ## 신뢰구간들 중 모수를 포함하는 것들의 비율
	p
end

# ╔═╡ 09c7c57a-e7fa-4678-aa2b-1da0e36e7d94
md"""
> N이 커질수록 모수를 포함하는 신뢰구간은 0.95에 더 가까워짐을 알 수 있다.
"""

# ╔═╡ 928a01f0-fd9b-4503-878f-33813b4cd46e
md"""
### B. 베르누이 분포를 따르는 표본에 대한 검정
"""

# ╔═╡ 91303a81-5209-4197-94bd-b67580da11e7
md"""
`-` 여학생만 선호하는 교수...?

* 임용 이후 5명의 학생을 받았는데, 5명 모두 여학생이었다. 이 경우 여학생을 선호한다는 의혹은 사실일까...?
"""

# ╔═╡ 39ea95d0-57c6-4030-ac55-b0edd329e665
md"""
1. 가설 설정

 $p_x$ : 남학생을 받을 확률, $p_y$ : 여학생을 받을 확률이라 하자. 그러면 일반적으로 둘은 같으므로...

$$H_0 : p_x = p_y ~ vs. ~ H_1 : p_x < p_y$$

2. 검정통계량

받을 대학원생의 성별을 남자일때 1, 여자일때 0이라 하는 확률변수를 X라 하면 $X \sim Bernoulli(0.5)$이고, $\Sigma_{i = 1}^{5} = X_1 + X_2 + \dots + X_5 \sim B(5, 0.5)$이므로, 검정통계량을 ΣX라고 하자.

3. p-value

$$p-value = P(ΣX ≤ 0) = \frac{1}{32} = 0.03125 ≤ 0.05$$

4. 따라서 귀무가설을 기각하고, 대립가설을 수용한다. 즉, 해당 교수는 받는 대학원생으로 여성을 선호한다.
<p>
	<span style="color:grey;">(너무해...)</span>
</p>
"""

# ╔═╡ 0909c30f-b7da-4ac7-9f77-162a13f222ef
md"""
## 테일러정리와 델타메소드
"""

# ╔═╡ 13c75cd9-ecc9-4e7f-9c13-874c94330055
md"""
### A. Derivative
"""

# ╔═╡ f1d29b76-63f9-45fb-b850-030ca53e75b3
md"`ForwardDiff`"

# ╔═╡ 5d13ce35-32f0-4bc9-a79b-901c7d83292e
let
	f(x) = x^2
	ForwardDiff.derivative(f, 2)
end

# ╔═╡ 4739cd75-bdd2-4d99-bf7e-f3d3cdfe7026
slope = ForwardDiff.derivative  ## 너무 기니까 인스턴스화

# ╔═╡ 7eaa6784-4966-426e-9c55-9c5346ef4a97
md"`-` 함수를 리턴하는 함수를 만들려면?"

# ╔═╡ 4937a2e7-af3e-45fb-b54b-ab5197e1c392
function ∂(f, m = 1)
	if m == 0
		return f
	else
		return x -> slope(∂(f, m-1), x)  ## 재귀하여 m차 미분을 고려
	end
end

# ╔═╡ 80ebb5c5-0dc5-45eb-bf18-a762cb3cb8e0
md"""
### B. Tayler extension
"""

# ╔═╡ 11c1e3c8-b237-4285-b5b0-9edd0f4df1ac
md"""
a 근처에서 미분가능한 연속함수 f(x)를 m차 다항식을 이용하여 근사할 수 있다.

$$f(x) \approx \frac{f(a)(x-a)^0}{0!} + \frac{f'(a)(x-a)^1}{1!} + \frac{f''(a)(x-a)^2}{2!} + \dots + \frac{f^{(m)}(a)(x-a)^m}{m!}$$
"""

# ╔═╡ e5fddf03-05fc-4459-b4fb-7a9927a907bf
md"""
a₁ = $(@bind a₁ Slider(-4:0.5:4, show_value = true, default = 0))

m = $(@bind m Slider(0:8, show_value = true, default = 2))
"""

# ╔═╡ 08a6849a-5503-4376-88f9-3c11dd36f259
f(x) = exp(x) / (1 + exp(x))  ## \euler쓰니까 어째선지 안됨

# ╔═╡ 0f3f476b-6a2b-4c69-a4b6-1a1d92f6d666
function f_approx(x)
	coef = [∂(f, i)(a₁) for i in 0:m]  ## [f(a), f'(a), ...]
	basis = [(x - a₁)^i/factorial(i) for i in 0:m]
	return (coef .* basis) |> sum
end

# ╔═╡ 4c3a0b50-4161-4670-95cc-fcd48cd341c4
let
	plot(f, xlim = (-5, 5), ylim = (0, 1))
	plot!(f_approx)
	scatter!([a₁], [f(a₁)])
end

# ╔═╡ 1e322fc6-6463-4823-8dd1-d8d406657ffc
md"""
### C. Delta method
"""

# ╔═╡ c72cb6ce-260c-41db-800b-60050a460bb8
md"""
> 선형근사와 분포수렴을 이용하여 다른 분포를 정규분포로 근사한다.
"""

# ╔═╡ 49164c88-b2ee-4c65-b118-89b496e473e4


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Distributions = "~0.25.107"
ForwardDiff = "~0.10.36"
Plots = "~1.40.2"
PlutoUI = "~0.7.58"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "b9e5e9bd2ea40bb2afe824755aab26966734be2d"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0f748c81756f2e5e6854298f11ad8b2dfae6911a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.0"

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
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

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

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

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

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "0f4b5d62a88d8f59003e43c25a8a90de9eb76317"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.18"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random"]
git-tree-sha1 = "5b93957f6dcd33fc343044af3d48c215be2562f1"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.9.3"
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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

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
git-tree-sha1 = "cad560042a7cc108f5a4c24ea1431a9221f22c1b"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.2"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

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
git-tree-sha1 = "3bdfa4fa528ef21287ef659a89d686e8a1bcb1a9"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.3"

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
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

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
# ╟─455a0811-d32e-4459-a1da-2dedae860d88
# ╠═6f5e1250-e775-11ee-1994-e3c1b9e5584c
# ╠═9f1e3085-6804-4631-aeba-04afdd1fd01e
# ╠═abf78c62-9107-4aac-8113-9da0f95f5cde
# ╟─1d41c736-6b1d-46d1-9df7-447b7c7a02ce
# ╠═d0052329-8f0b-4fc3-998e-b8e5912d5536
# ╟─e38a58bc-c110-4885-993a-7f25fb0166ef
# ╠═4e593850-16ed-40ca-83fd-a486b18ec079
# ╠═6efcbb0a-8ef3-4599-b874-0b4d02fa7518
# ╠═a16b583b-9405-48ee-9c05-83e38533b68f
# ╟─b29f68bf-3de5-4d7c-84f4-2bd2bd874537
# ╠═a7de0a15-d975-418f-9a54-1f8441ae91ac
# ╟─cec3fbdf-1b41-438c-b263-8fe140700b26
# ╠═a65c8eef-f5b2-4ae5-8520-db338fe5780c
# ╟─9ee8c5bc-5f7a-4833-a531-1007466ffda8
# ╠═4997f438-a5ce-40bd-968c-32d70f07f801
# ╠═8cc89254-26ff-4020-bbeb-0a248564bbef
# ╟─b8ebbd63-f1ef-4892-9ef9-2f9286129f86
# ╠═059cd126-a60a-4009-8c1c-74f2de00ca8c
# ╟─0c8547d7-13e9-4215-b1a0-c4438a1127f7
# ╠═58be869e-bc81-4232-932e-a54d3fe0b3e3
# ╟─1df27dda-e79b-44bb-a8a3-5b6c48af4cc5
# ╠═7b9f0ebd-91fb-4bba-8cca-c1a515ff312e
# ╠═dc1c5b25-84cf-4967-b915-7468955ffa24
# ╠═bd78e53c-d222-41b7-beb3-a10991feb09a
# ╠═c00b097a-d5ae-4a5d-a384-bc06cbfdef08
# ╠═dcea012a-3cef-4a3d-9fcd-1014baec2b8f
# ╟─8dc0960a-99da-4a6b-b7b0-ffae32df16b4
# ╠═45ff35d1-1ebd-4ea7-b72c-0eb4ddf6f58f
# ╟─3f4e4892-a743-4bc5-8eb1-adaf684c61d5
# ╟─c170c172-2a1c-49d1-914f-aaf23a0c6f1f
# ╠═77c34287-881b-408b-9d9e-287318b5ba01
# ╠═e2d79467-f780-404a-b084-f71de303d97f
# ╠═668a0ce3-03ac-4f5e-8313-5fa3e741d9e9
# ╟─cefde001-9774-4069-9dda-cee8271f4c1f
# ╠═16feef51-3329-4289-a95d-59fa89576c73
# ╠═38e95bf2-76f6-4ff8-b108-ac3cafa2f308
# ╟─682518ab-28ad-4d98-93fe-3f9ba66380bf
# ╟─623fe2c0-6e50-44f2-982a-a99f7c5cbead
# ╠═9ab07c9f-4d3b-4109-8bda-cc29e99a40ef
# ╠═7ebf832f-13eb-4b0f-9d7d-b84dd1fb660c
# ╠═cb5eae90-aa93-4c04-9aff-dc4fd587e630
# ╠═c71c0636-3c50-4775-8578-640c70cc9009
# ╟─538ceafd-c3ad-4f58-8ef1-b8d2f7a80fb6
# ╠═e03cc014-83c8-4659-8737-c44be8c6ae74
# ╠═18afa3d2-517f-4c47-ac41-a8012079ada9
# ╠═08e626a3-6bdf-4dec-9a44-f051ed68d745
# ╟─3c403a5e-60cb-4f0b-a882-679cdfae1b6b
# ╟─32336b49-3be3-48d7-9f5c-d9fad228c27b
# ╟─db1b6061-2513-4ca3-9205-8242bd1c7472
# ╠═0153b93a-6edd-4a64-a992-c2c2e0cfe06b
# ╟─6f523ea7-cbae-47aa-a1c5-3480fbeaeedd
# ╠═cfd3861e-3440-4822-a83d-9382bb2bc316
# ╟─32f8f3a7-ab89-4188-aa6d-4d52cc084c21
# ╟─e7caf6fc-e34c-42a5-93fe-a7b9d4605afa
# ╠═a2c165b4-6459-4113-a25d-0c35e41f2e3c
# ╠═7ef017b1-5822-48ae-9643-7960ebf4fdb0
# ╟─3df97593-cea3-45d5-840b-9a9874abb8cc
# ╠═43536bc0-599c-4180-87a5-6d3b02c77dd4
# ╟─843fd1fa-3f42-41da-9254-34977df8d736
# ╠═2afbbb9b-46a0-47a1-8599-8363f458755b
# ╠═c0044d57-4bfc-4c8a-a8d9-9513fc9a1bef
# ╟─daa6729a-5f5d-4547-a792-0e8c54bf597e
# ╠═2a8cb317-2ccf-4d50-a005-6c4a3953febf
# ╟─027c5b5d-5212-488f-beba-b3476c7cec54
# ╟─f1f8dd40-c975-490b-9e91-7b49b84581ca
# ╠═5baad307-94f3-453c-9878-57d0c0fb6150
# ╟─032ddcbf-1edd-45fc-8ea7-c2c9a7c17b3a
# ╠═1e75c5ab-c0ea-49fd-9cb0-da11d2ae6de8
# ╠═cda2ef25-f70e-42a4-b721-882509c3b418
# ╟─337076ae-8469-4a0a-b1ea-c52ebc7a9027
# ╠═9e2bc040-2a33-43b0-86a0-e610b98f5930
# ╟─7ed313dd-830e-4381-8cfe-b8c98da4d002
# ╟─5bb17acc-c570-4b62-a01a-6b7c00c35dde
# ╠═ea41d446-be33-45f8-b372-2776119f4fda
# ╟─a30d1531-bcb7-48d1-a369-460aced7cc4f
# ╟─84bc5e5a-3c61-486c-b0b0-4e03d301690e
# ╠═57e5b93d-2f3b-40a8-9e4c-11901d498d98
# ╟─1304886c-ab78-4d23-80ce-6025d66640a8
# ╠═ccc44a13-355f-403e-be45-d4a031ea1ce5
# ╠═7f14bfa0-6fcd-4c8a-aba7-44c7937a4ddd
# ╟─8bdcb86c-1767-4990-9bb4-731790c9f2b1
# ╟─4379fd3f-3f92-4b0d-8d1a-a2cf17b189eb
# ╟─359d8ad8-a5a2-47c2-a62d-057ae7058c2a
# ╟─eaae015d-f8e4-404a-8c52-528f55f9843a
# ╠═862e890f-6be2-4d97-9c56-84c557940e55
# ╟─cc5c0817-b290-471f-aa31-0a2905b45741
# ╠═61907f88-fa58-49fc-ac22-d8b757b28e82
# ╠═cccc3d9e-de04-4029-b0e0-d59d98b6bc77
# ╟─a67234c9-94f6-4e5f-8c42-6f5cf4e1933d
# ╟─40871ab7-df22-4b9a-be07-0013cfbc656e
# ╟─f72c31a8-6065-465c-a0f8-62ca919094d4
# ╠═29be535a-fa0b-44c5-9822-4fca701d021a
# ╟─50466eab-bd9c-47a5-903c-e1e7c99d3548
# ╠═02242ed2-08df-49ee-91f5-61627dd28ecd
# ╟─1bcecc6e-c708-4cde-97f1-d21cbbe379f8
# ╠═ff8e50a0-8afc-48ea-aba6-57cef582b7f4
# ╟─f529499b-c961-4368-9a4d-a66ac7281d19
# ╟─1d5cf77b-e2f5-4927-8f98-da7babed96d3
# ╟─daf035aa-2be1-4b0f-9b97-095e34350b0a
# ╟─2e34e170-aed1-446a-82d5-41455004a69c
# ╠═e41f0bad-3ed5-4298-8d22-14f443517978
# ╟─d0be677b-ebac-4408-bc45-8f09044476be
# ╠═b181dd35-8690-4ef6-9538-dcd2e67e9ddb
# ╟─ebf0bdbf-868e-400a-b7ae-1dcedad97f89
# ╠═ac52601f-714d-4657-b980-bc5c1f558163
# ╟─9aa12753-7cb4-4370-ae10-9f99dfe01652
# ╠═7462ae30-aa78-479d-aa68-25acba417169
# ╠═e0db18e0-9b04-4eb6-bb0d-2091b428a553
# ╟─e98d6ef2-b836-4a7b-9beb-c24eed088abe
# ╟─923eb57d-bf2a-4815-ba45-296685cf5f43
# ╠═694ff7ac-f3e0-448b-9a47-d131c2d30650
# ╠═24332730-d9e4-45b2-8cc7-9bef7c0c3ec5
# ╟─f275e60c-912c-4feb-8010-e8449268a542
# ╠═d220f49f-b652-4f9e-84d6-46c50497e719
# ╟─a81e4c58-56e1-4f77-87de-ff26f070e77e
# ╠═3c1cbdb9-50f0-4429-ae50-b68de102cab7
# ╟─33776495-04c1-4b1b-8226-fa5816e5435f
# ╟─4ca2c50f-3696-444b-bab3-d7a41b0cdb1e
# ╠═bcefc93b-7898-4d91-b5a3-fb52f9636cb8
# ╟─3a7e9d92-e59d-4d79-b25e-2f8bd95be5d5
# ╟─b7c77d64-cb49-4e34-b5ae-8caae8f89c6d
# ╟─59c38af3-37bc-458c-a55f-71a1d2d34b25
# ╟─0ca7a8da-c99e-4c98-b258-ca6400d9040f
# ╟─dcefd283-205d-447c-8ea8-188b619fe0e4
# ╠═d35c8ebb-d261-4a21-8db7-ee49811670db
# ╟─e1ed314b-5c1f-450e-85c1-dbb6362f4616
# ╠═f84bb31b-b320-4df7-a81d-218210eb9278
# ╟─09c7c57a-e7fa-4678-aa2b-1da0e36e7d94
# ╟─928a01f0-fd9b-4503-878f-33813b4cd46e
# ╟─91303a81-5209-4197-94bd-b67580da11e7
# ╟─39ea95d0-57c6-4030-ac55-b0edd329e665
# ╟─0909c30f-b7da-4ac7-9f77-162a13f222ef
# ╟─13c75cd9-ecc9-4e7f-9c13-874c94330055
# ╟─f1d29b76-63f9-45fb-b850-030ca53e75b3
# ╠═5d13ce35-32f0-4bc9-a79b-901c7d83292e
# ╠═4739cd75-bdd2-4d99-bf7e-f3d3cdfe7026
# ╟─7eaa6784-4966-426e-9c55-9c5346ef4a97
# ╠═4937a2e7-af3e-45fb-b54b-ab5197e1c392
# ╟─80ebb5c5-0dc5-45eb-bf18-a762cb3cb8e0
# ╟─11c1e3c8-b237-4285-b5b0-9edd0f4df1ac
# ╟─e5fddf03-05fc-4459-b4fb-7a9927a907bf
# ╠═08a6849a-5503-4376-88f9-3c11dd36f259
# ╠═0f3f476b-6a2b-4c69-a4b6-1a1d92f6d666
# ╠═4c3a0b50-4161-4670-95cc-fcd48cd341c4
# ╟─1e322fc6-6463-4823-8dd1-d8d406657ffc
# ╟─c72cb6ce-260c-41db-800b-60050a460bb8
# ╠═49164c88-b2ee-4c65-b118-89b496e473e4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
