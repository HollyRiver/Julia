### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 748de188-5cd4-452c-b9b3-559417b475a8
md"""
202014107 통계학과 강신성
"""

# ╔═╡ de97e015-f2d8-453e-9f71-e748eab4159e
md"""
## 7. 숙제 

다음을 읽고 참 거짓을 판단하라. 

"""

# ╔═╡ 0af97f1f-2470-4648-a25c-d3a8ac4d8a6a
md"""

`1`. 단위행렬의 고유값은 1이외에 존재할 수 없다. 

"""

# ╔═╡ 205cd719-fc23-42dc-8a2e-476aeab4838d
md"""
> **참**
> 
> 단위행렬의 고유방정식은 $(1-\lambda)^n = 0$의 형태로 주어진다.
"""

# ╔═╡ 335f9d12-fcb2-47e3-85f5-5f9f7f1c1f0a
md"""

`2`. ${\bf A}={\bf O}$인 경우는 대각화가능하지 않다. 

"""

# ╔═╡ bfb0200c-c4a6-4b2b-9ead-94e1cda00b3b
md"""
> **거짓**
>
> 고유값이 모두 0이고, 이에 따라 고유벡터로 이루어진 행렬은 Full rank가 된다. 애초에 $\boldsymbol \Lambda = \boldsymbol 0$이므로, 임의의 비특이행렬 $\boldsymbol \Psi$과 그 역행렬을 앞뒤에 곱해도 등식이 성립한다.
"""

# ╔═╡ e639fd5b-657b-4737-ac0b-15553af55c92
md"""
`3`. ${\bf A}$의 고유값행렬이 ${\bf \Lambda}$ 라면 ${\bf A}^2$의 고유값행렬은 ${\bf \Lambda}^2$이 된다. 
"""

# ╔═╡ dfdeba57-910f-4779-877c-56e9d9a7b9c1
md"""
> **참**
>
> 고유벡터행렬 $\boldsymbol{\Psi}$에 대하여 $\boldsymbol{A\Psi} = \boldsymbol{\Psi\Lambda}, \boldsymbol{A(A\Psi)} = \boldsymbol{(A\Psi)\Lambda} = \boldsymbol{\Psi\Lambda^2}$
"""

# ╔═╡ f9d0f0d8-b8c2-4d8f-a1fd-5eb9f310be45
md"""
`4`. ${\bf A}$의 고유벡터행렬이 ${\bf \Psi}$ 라면 ${\bf A}^2$의 고유벡터행렬도 ${\bf \Psi}$이다. 
"""

# ╔═╡ 0a2d5cd9-161b-46fa-b188-94fcbe8623d8
md"""
> **참**
>
> 위에서 보인 바와 같다.
"""

# ╔═╡ 736e188b-6db5-465c-a5aa-bf18c8ad76ca
md"""
`5`. ${\bf A}$가 대각화가능행렬이라면 ${\bf A}$는 full-rank-matrix 이다. (즉 역행렬이 존재한다.)
"""

# ╔═╡ 1faca2d1-cc5b-4eb3-9de8-d75e1f81809e
md"""
> **거짓**
>
>  $\boldsymbol A$가 full-rank-matrix라고 가정했을 때, $\boldsymbol A = \boldsymbol 0$이여도 위처럼 대각화가 가능했으므로 모순이다. 따라서 $\boldsymbol A$는 full-rank-matrix가 아닐수도 있다.
"""

# ╔═╡ 6e20ec15-bf58-4966-a049-41e389f8ef11
md"""
`6`. ${\bf A}$가 대각화가능행렬이라면 ${\bf A}+2{\bf I}$ 의 고유값은 ${\bf A}$의 고유값에 2를 더한것과 같다. 
"""

# ╔═╡ a88c68f7-ed69-4385-903f-51a72839b5dd
md"""
> **참**
>
>  $\boldsymbol {(A + 2I)\Psi} = \boldsymbol {\Psi \Lambda + 2I\Psi} = \boldsymbol {\Psi \Lambda + 2\Psi I} = \boldsymbol {\Psi (\Lambda + 2I)}$
"""

# ╔═╡ a7ee4b82-3c76-41f0-b96a-70fe1d44d128
md"""
`7`. ${\bf A}$의 고유벡터행렬이 ${\bf I}$ 라면, ${\bf A}$는 대각행렬이다. 
"""

# ╔═╡ 65ef886c-4814-40b5-9262-37ced9679e6b
md"""
> **참**
>
>  $\boldsymbol A = \boldsymbol{I \Lambda I^{-1}} = \boldsymbol \Lambda$
"""

# ╔═╡ 463de3b9-09c8-4c85-9b79-5d507b18a4e8
md"""
`8`. 대각화가능행렬 ${\bf A}$의 모든 고유값이 0과 1사이라고 하자. 그렇다면 $\lim_{k\to \infty} {\bf A}^k={\bf O}$  이다. 
"""

# ╔═╡ 1cfcac49-5df0-4c1a-bd64-11380bbba0c5
md"""
> **참**
>
>  $\boldsymbol A = \boldsymbol{\Psi \Lambda \Psi^{-1}} \Rightarrow \boldsymbol A^k = \boldsymbol{(\Psi \Lambda \Psi^{-1})^k} = \boldsymbol{\Psi \Lambda^k \Psi^{-1}}$
>
>  $\overset{lim}{_{k \to \infty}} \boldsymbol \Lambda^k = \boldsymbol O, ~ \therefore \overset{lim}{_{k \to \infty}} \boldsymbol A^k = \boldsymbol O$
"""

# ╔═╡ Cell order:
# ╟─748de188-5cd4-452c-b9b3-559417b475a8
# ╟─de97e015-f2d8-453e-9f71-e748eab4159e
# ╟─0af97f1f-2470-4648-a25c-d3a8ac4d8a6a
# ╟─205cd719-fc23-42dc-8a2e-476aeab4838d
# ╟─335f9d12-fcb2-47e3-85f5-5f9f7f1c1f0a
# ╟─bfb0200c-c4a6-4b2b-9ead-94e1cda00b3b
# ╟─e639fd5b-657b-4737-ac0b-15553af55c92
# ╟─dfdeba57-910f-4779-877c-56e9d9a7b9c1
# ╟─f9d0f0d8-b8c2-4d8f-a1fd-5eb9f310be45
# ╟─0a2d5cd9-161b-46fa-b188-94fcbe8623d8
# ╟─736e188b-6db5-465c-a5aa-bf18c8ad76ca
# ╟─1faca2d1-cc5b-4eb3-9de8-d75e1f81809e
# ╟─6e20ec15-bf58-4966-a049-41e389f8ef11
# ╟─a88c68f7-ed69-4385-903f-51a72839b5dd
# ╟─a7ee4b82-3c76-41f0-b96a-70fe1d44d128
# ╟─65ef886c-4814-40b5-9262-37ced9679e6b
# ╟─463de3b9-09c8-4c85-9b79-5d507b18a4e8
# ╟─1cfcac49-5df0-4c1a-bd64-11380bbba0c5
